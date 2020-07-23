echo "set environment variables..."

export TRUE=0
export FALSE=1

export IS_BUILD_SUCCESS=$TRUE

export GITHUB_OWNER=StanleyProjects
export GITHUB_REPO=KotlinJavaFXExtension

#export CI_BUILD_LIGHTWEIGHT="auto"

#export DEVELOP_BRANCH_NAME="dev"
#export MASTER_BRANCH_NAME="master"
export GIT_SOURCE_BRANCH=$TRAVIS_BRANCH
echo git source branch: $GIT_SOURCE_BRANCH

export GIT_COMMIT_SHA=$TRAVIS_COMMIT
echo git commit sha: $GIT_COMMIT_SHA
