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

MID=""
if test $IS_BUILD_SUCCESS -eq $TRUE; then
    if [[ $PR_NUMBER =~ $IS_INTEGER_REGEX ]]; then
        rm -f file
        code=$(curl -w %{http_code} -o file \
            -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/pulls/$PR_NUMBER)
        if test $code -ne 200; then
          echo "Request error with response code $code!"; exit 1
        fi
        body=$(<file); rm file
        state=$(echo $body | jq -r .state)
        if test $state == closed; then
            MID="
pull request [#$PR_NUMBER](https://github.com/$GITHUB_OWNER/$GITHUB_REPO/pull/$PR_NUMBER) closed
"
        fi
    fi
fi

MESSAGE="$TOP

Repository [$REPO_NAME]($REPO_URL) of [$REPO_OWNER](https://github.com/$REPO_OWNER)
$MID
commit [${GIT_COMMIT_SHA::7}]($REPO_URL/commit/$GIT_COMMIT_SHA)
committer email $GIT_COMMITTER_EMAIL
committer name $committerName"

bash $WORKFLOW/telegram_send_message.sh "$MESSAGE"
