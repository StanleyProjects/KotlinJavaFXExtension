echo "set environment variables..."

IS_INTEGER_REGEX="^[1-9][0-9]*$"

export TRUE=0
export FALSE=1

export IS_BUILD_SUCCESS=$TRUE

export GITHUB_OWNER=StanleyProjects
export GITHUB_REPO=KotlinJavaFXExtension

#export CI_BUILD_LIGHTWEIGHT="auto"

#export DEVELOP_BRANCH_NAME="dev" # todo
export DEVELOP_BRANCH_NAME="dev.test"
#export MASTER_BRANCH_NAME="master"
export PR_BRANCH_NAMES="$DEVELOP_BRANCH_NAME"

export GIT_SOURCE_BRANCH=$TRAVIS_BRANCH
echo git source branch: $GIT_SOURCE_BRANCH

export GIT_COMMIT_SHA=$TRAVIS_COMMIT
echo git commit sha: $GIT_COMMIT_SHA

export PR_NUMBER=""
export PR_SOURCE_BRANCH=""

if test $TRAVIS_PULL_REQUEST =~ $IS_INTEGER_REGEX; then
  PR_NUMBER=$TRAVIS_PULL_REQUEST
  PR_SOURCE_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH
  if test -z "$PR_SOURCE_BRANCH"; then
    echo "name of the branch from which the PR originated must be not empty"
    exit 1
  fi
  echo "it is a pull request #$PR_NUMBER \"$PR_SOURCE_BRANCH\" -> \"$GIT_SOURCE_BRANCH\""
else
  echo "it is not a pull request"
fi
