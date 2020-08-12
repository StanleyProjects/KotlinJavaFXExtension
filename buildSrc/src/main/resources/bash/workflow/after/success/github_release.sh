echo "github release..."

if test -z $github_pat; then
    echo "GitHub personal access token must be exists!"
    return 1
fi

body="by $GIT_WORKER_NAME"
json="{\
\"tag_name\":\"$TAG_NAME\",
\"target_commitish\":\"$GIT_COMMIT_SHA\",
\"name\":\"$TAG_NAME\",
\"body\":\"$body\",
\"draft\":false,
\"prerelease\":true
}"

rm -f file
code=$(curl -w %{http_code} -o file -X POST \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases \
    -H "Authorization: token $github_pat" \
    -d "$json")
if test $code -ne 201; then
    echo "Create $VERSION_NAME release error!"
    echo "Request error with response code $code!"
    return 2
fi
body=$(<file); rm file

releaseId=$(echo $body | jq -r .id)

fileName=${APPLICATION_ID}-${VERSION_NAME}-${VERSION_CODE}-snapshot.jar
code=$(curl -w %{http_code} -o /dev/null -X POST \
    -s "https://uploads.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/$releaseId/assets?name=$fileName&label=$fileName" \
    -H "Content-Type: application/java-archive" \
    -H "Authorization: token $github_pat" \
    --data-binary @$ASSEMBLY_PATH/assembly/build/snapshot/$fileName)
if test $code -ne 201; then
    echo "Upload file $fileName error!"
    echo "Request error with response code $code!"
    return 3
fi

return 0
