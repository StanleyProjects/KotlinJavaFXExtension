echo "after success..."

if test -z "$PR_NUMBER"; then
    echo "it is not pull request"
    return 0
fi

if test -z $PR_SOURCE_BRANCH; then
    echo "source branch of pull request #$PR_NUMBER undefined"
    return 1
fi

if [[ " ${PR_BRANCH_NAMES[@]} " =~ " $PR_SOURCE_BRANCH " ]]; then
    . $WORKFLOW/accept_pr.sh || return 2
else
    echo "$PR_SOURCE_BRANCH is not in [${PR_BRANCH_NAMES[@]}]"
fi
