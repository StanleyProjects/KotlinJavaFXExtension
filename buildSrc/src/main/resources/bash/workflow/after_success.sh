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
    . $WORKFLOW/tag_test.sh || return 21
    . $WORKFLOW/accept_pr.sh || return 22
    . $WORKFLOW/tag.sh || return 23
fi
