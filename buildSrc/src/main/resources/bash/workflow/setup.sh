echo "setup..."

export IS_INTEGER_REGEX="^[1-9][0-9]*$"

export TRUE=0
export FALSE=1

export IS_BUILD_SUCCESS=$TRUE

#export CI_BUILD_LIGHTWEIGHT="auto"

export DEVELOP_BRANCH_NAME=dev
export MASTER_BRANCH_NAME=master
export PR_BRANCH_NAMES=$DEVELOP_BRANCH_NAME $MASTER_BRANCH_NAME

if [[ $PR_NUMBER =~ $IS_INTEGER_REGEX ]]; then
  if test -z "$PR_SOURCE_BRANCH"; then
    echo "name of the branch from which the PR originated must be not empty"
    exit 1
  fi
  echo "it is a pull request #$PR_NUMBER $GIT_SOURCE_BRANCH -> $PR_SOURCE_BRANCH"
else
  echo "it is not a pull request"
fi
