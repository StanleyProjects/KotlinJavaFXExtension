echo "tag..."

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

echo "release $releaseId created" # todo
# todo asset

return 0
