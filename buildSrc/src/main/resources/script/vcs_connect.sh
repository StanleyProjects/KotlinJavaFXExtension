echo "vcs connect..."

if test -z $GITHUB_OWNER; then
  echo "GitHub owner must be exists!"
  exit 1
fi

if test -z $GITHUB_REPO; then
  echo "GitHub repo must be exists!"
  exit 2
fi

if test -z $GIT_COMMIT_SHA; then
  echo "GIT commit sha must be exists!"
  exit 3
fi

rm -f responseBodyFile
responseCode=$(curl -w %{http_code} \
    -o responseBodyFile \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/commits/$GIT_COMMIT_SHA)

if test $responseCode -ne 200; then
  echo "Request error with response code $responseCode!"
  exit 4
fi

responseBody=$(<responseBodyFile)
rm responseBodyFile

export GIT_COMMIT_MESSAGE=$(echo $responseBody | jq -r .commit.message)
echo git commit message: \"$GIT_COMMIT_MESSAGE\"
export GIT_COMMITTER_EMAIL=$(echo $responseBody | jq -r .commit.committer.email)
echo git committer email: $GIT_COMMITTER_EMAIL
export GIT_COMMITTER_NAME=$(echo $responseBody | jq -r .commit.committer.name)
echo git committer name: $GIT_COMMITTER_NAME
