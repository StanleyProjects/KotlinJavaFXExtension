echo "accept pr #$PR_NUMBER..."

if test -z "$github_pat"; then
  echo "GitHub personal access token must be exists!"
  exit 1
fi

message="Merge branch $GIT_SOURCE_BRANCH(${GIT_COMMIT_SHA::7}) into $PR_SOURCE_BRANCH_NAME by Travis"
json="{\
\"commit_title\":\"$message\",\
\"commit_message\":\"$message\"\
}"

responseCode=$(curl -w %{http_code} \
    -X PUT \
    -H "Authorization: token $github_pat" \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/commits/pulls/$PR_NUMBER/merge \
    -d "$json")

if test $responseCode -ne 200; then
  echo "Pull request #$PR_NUMBER accepting error!"
  echo "Request error with response code $responseCode!"
  exit 2
fi
