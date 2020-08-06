echo "main start..."

export WORKFLOW=$RESOURCES_PATH/bash/workflow

source $WORKFLOW/vcs_connect.sh || exit 1

source $WORKFLOW/setup.sh || exit 1
echo "PR_BRANCH_NAMES [${PR_BRANCH_NAMES[@]}]" # todo

if test $IS_LIGHTWEIGHT_BUILD_INTERNAL == $TRUE; then
    echo "skip main pipeline..."
else
    #docker build --no-cache -f $RESOURCES_PATH/docker/Dockerfile . || IS_BUILD_SUCCESS=$FALSE

    if test $IS_BUILD_SUCCESS == $TRUE; then
        echo "PR_BRANCH_NAMES [${PR_BRANCH_NAMES[@]}]" # todo
        source $WORKFLOW/after_success.sh || IS_BUILD_SUCCESS=$FALSE
        echo "PR_BRANCH_NAMES [${PR_BRANCH_NAMES[@]}]" # todo
    else
        IS_BUILD_SUCCESS=$FALSE # todo
    #    bash $RESOURCES_PATH/bash/after_failure.sh
    fi
fi

bash $WORKFLOW/after.sh
