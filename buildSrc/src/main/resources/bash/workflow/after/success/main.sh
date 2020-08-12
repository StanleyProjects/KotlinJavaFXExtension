echo "after success..."

if test -z "$PR_NUMBER"; then
    echo "it is not pull request"
    return 0
fi

if test -z $PR_SOURCE_BRANCH; then
    echo "source branch of pull request #$PR_NUMBER undefined"
    return 1
fi

if test $PR_SOURCE_BRANCH == $DEVELOP_BRANCH_NAME; then
    export TAG_NAME="$VERSION_NAME-snapshot" # todo dev/master
    . $WORKFLOW/after/success/tag_test.sh || return 21
    . $WORKFLOW/after/success/accept_pr.sh || return 22
    . $WORKFLOW/after/success/github_release.sh || return 23
fi
