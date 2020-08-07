echo "main start..."

export WORKFLOW=$RESOURCES_PATH/bash/workflow

. $WORKFLOW/vcs_connect.sh || exit 1

. $WORKFLOW/setup.sh || exit 2

if test $IS_LIGHTWEIGHT_BUILD_INTERNAL == $TRUE; then
    echo "skip main pipeline..."
else
    IS_BUILD_SUCCESS=$FALSE # todo
#    docker build --no-cache -f $RESOURCES_PATH/docker/Dockerfile . || IS_BUILD_SUCCESS=$FALSE

    if test $IS_BUILD_SUCCESS == $TRUE; then
        . $WORKFLOW/after_success.sh || IS_BUILD_SUCCESS=$FALSE
    else
        . $WORKFLOW/after_failure.sh
    fi
fi

. $WORKFLOW/after.sh

if test $IS_BUILD_SUCCESS != $TRUE; then
    exit 3
fi
