echo "vcs connect..."

if test -z $GITHUB_OWNER; then
    echo "GitHub owner must be exists!"; exit 1
fi

if test -z $GITHUB_REPO; then
    echo "GitHub repo must be exists!"; exit 2
fi

if test -z $GIT_COMMIT_SHA; then
    echo "GIT commit sha must be exists!"; exit 3
fi

rm -f file
code=$(curl -w %{http_code} -o file \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/commits/$GIT_COMMIT_SHA)

if test $code -ne 200; then
    echo "Request error with response code $code!"; exit 4
fi

body=$(<file)
rm file

export GIT_COMMIT_MESSAGE=$(echo $body | jq -r .commit.message)
echo git commit message: \"$GIT_COMMIT_MESSAGE\"

export GIT_COMMITTER_EMAIL=$(echo $body | jq -r .commit.committer.email)
export GIT_COMMITTER_NAME=$(echo $body | jq -r .commit.committer.name)
export GITHUB_COMMITTER_LOGIN=$(echo $body | jq -r .committer.login)

export GIT_AUTHOR_EMAIL=$(echo $body | jq -r .commit.author.email)
export GIT_AUTHOR_NAME=$(echo $body | jq -r .commit.author.name)
if test -z "$GIT_AUTHOR_NAME"; then
    echo no git author name
else
    echo git author name: $GIT_AUTHOR_NAME
fi
export GITHUB_AUTHOR_LOGIN=$(echo $body | jq -r .author.login)
if test -z $GITHUB_AUTHOR_LOGIN; then
    echo no github author login
else
    echo github author login: $GITHUB_AUTHOR_LOGIN
fi
