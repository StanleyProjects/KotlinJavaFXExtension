echo "after..."

REPO_OWNER=$GITHUB_OWNER
REPO_NAME=$GITHUB_REPO
REPO_URL=https://github.com/$REPO_OWNER/$REPO_NAME
CI_URL=$REPO_URL/actions/runs

TOP="GitHub build [#$GITHUB_RUN_NUMBER]($CI_URL/$GITHUB_RUN_ID)"
if test $IS_BUILD_SUCCESS -ne $TRUE; then
  TOP="$TOP failure!"
fi

if test -z $GITHUB_COMMITTER_LOGIN; then
    committerName=$GIT_COMMITTER_NAME
else
    committerName="[$GIT_COMMITTER_NAME](https://github.com/$GITHUB_COMMITTER_LOGIN)"
fi

MESSAGE="$TOP

Repository [$REPO_NAME]($REPO_URL) of [$REPO_OWNER](https://github.com/$REPO_OWNER)

commit [${GIT_COMMIT_SHA::7}]($REPO_URL/commit/$GIT_COMMIT_SHA)
committer email $GIT_COMMITTER_EMAIL
committer name $committerName"

bash $RESOURCES_PATH/bash/telegram_send_message.sh "$MESSAGE"
