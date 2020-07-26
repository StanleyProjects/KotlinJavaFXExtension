echo "accept pr #$PR_NUMBER..."

if test -z $github_pat; then
    echo "GitHub personal access token must be exists!"
    exit 1
fi

message="Merge branch $GIT_SOURCE_BRANCH(${GIT_COMMIT_SHA::7}) into $PR_SOURCE_BRANCH by GitHub"
json="{\
\"commit_title\":\"$message\",\
\"commit_message\":\"$message\"\
}"

code=$(curl -w %{http_code} -o /dev/null -X PUT \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/pulls/$PR_NUMBER/merge \
    -H "Authorization: token $github_pat" \
    -d "$json")

if test $code -ne 200; then
    echo "Pull request #$PR_NUMBER accepting error!"
    echo "Request error with response code $code!"
    exit 2
fi
