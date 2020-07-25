echo "accept pr #$PR_NUMBER..."

commitTitle="Merge by Travis"
commitMessage="Merge branch \"$GIT_SOURCE_BRANCH\"(${GIT_COMMIT_SHA::7}) into \"$PR_SOURCE_BRANCH_NAME\" by Travis"
json="{\
\"commit_title\":\"$commitTitle\",\
\"commit_message\":\"$commitMessage\"\
}"
responseCode=$(curl -w %{http_code} \
    -X PUT \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/commits/pulls/$PR_NUMBER/merge \
    -d $json)

if test $responseCode -ne 200; then
  echo "Pull request #$PR_NUMBER accepting error!"
  echo "Request error with response code $responseCode!"
  exit 1
fi
