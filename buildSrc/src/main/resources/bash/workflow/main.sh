echo "main start..."

export WORKFLOW=$RESOURCES_PATH/bash/workflow

. $WORKFLOW/vcs_connect.sh || exit 1
. $WORKFLOW/setup.sh || exit 2

if test $IS_LIGHTWEIGHT_BUILD_INTERNAL == $TRUE; then
    echo "skip main pipeline..."
else
    . $WORKFLOW/build/main.sh || IS_BUILD_SUCCESS=$FALSE

    if test $IS_BUILD_SUCCESS == $TRUE; then
        . $WORKFLOW/after/success/main.sh || IS_BUILD_SUCCESS=$FALSE
    fi
    if test $IS_BUILD_SUCCESS != $TRUE; then
        . $WORKFLOW/after/failure/main.sh
    fi
fi

. $WORKFLOW/after.sh

if test $IS_BUILD_SUCCESS != $TRUE; then
    exit 3
fi
