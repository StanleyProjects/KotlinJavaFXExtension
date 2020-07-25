echo "after success..."

if test -z "$PR_NUMBER"; then
  echo "it is not pull request"
  exit 1
fi

if test -z "$PR_SOURCE_BRANCH_NAME"; then
  echo "source branch of pull request #$PR_NUMBER undefined"
  exit 2
fi

for branchName in $PR_BRANCH_NAMES; do
    if test "$GIT_SOURCE_BRANCH" == "$branchName"; then
        status=0
        bash $RESOURCES_PATH/script/accept_pr_script.sh || status=$?
        exit $status
    fi
done

echo "$GIT_SOURCE_BRANCH is not in [$PR_BRANCH_NAMES]"
