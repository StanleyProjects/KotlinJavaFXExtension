echo "after success..."

if test -z "$PR_NUMBER"; then
    echo "it is not pull request"
    exit 0
fi

if test -z "$PR_SOURCE_BRANCH"; then
    echo "source branch of pull request #$PR_NUMBER undefined"
    exit 1
fi

for it in $PR_BRANCH_NAMES; do
    if test $PR_SOURCE_BRANCH == $it; then
        bash $WORKFLOW/accept_pr.sh || exit 2
    fi
done

echo "$PR_SOURCE_BRANCH is not in [$PR_BRANCH_NAMES]"
