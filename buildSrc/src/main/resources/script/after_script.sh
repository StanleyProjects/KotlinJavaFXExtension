echo "after script..."

TOP="Travis build [#$TRAVIS_BUILD_NUMBER]($TRAVIS_URL/builds/$TRAVIS_BUILD_ID)"
if test $IS_BUILD_SUCCESS -ne $TRUE; then
  TOP="$TOP failure!"
fi

REPO_OWNER=${TRAVIS_REPO_SLUG%/*}
REPO_NAME=${TRAVIS_REPO_SLUG#*/}
REPO_OWNER_URL="https://github.com/$REPO_OWNER"
REPO_URL="https://github.com/$TRAVIS_REPO_SLUG"
TRAVIS_URL="https://travis-ci.com/$TRAVIS_REPO_SLUG"

MESSAGE="$TOP

Repository [$REPO_NAME]($REPO_URL) of [$REPO_OWNER]($REPO_OWNER_URL)

commit [${GIT_COMMIT_SHA::7}]($REPO_URL/commit/$GIT_COMMIT_SHA)
committer email $GIT_COMMITTER_EMAIL
committer name $GIT_COMMITTER_NAME"

bash $RESOURCES_PATH/script/telegram_send_message.sh "$MESSAGE"
