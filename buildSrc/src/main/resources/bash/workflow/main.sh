echo "main start..."

export WORKFLOW=$RESOURCES_PATH/bash/workflow

source $WORKFLOW/setup.sh || exit 1

source $WORKFLOW/vcs_connect.sh || exit 2

#docker build --no-cache -f $RESOURCES_PATH/docker/Dockerfile . || IS_BUILD_SUCCESS=$FALSE

if test $IS_BUILD_SUCCESS -eq $TRUE; then
    bash $WORKFLOW/after_success.sh || IS_BUILD_SUCCESS=$FALSE
else
    IS_BUILD_SUCCESS=$FALSE # todo
#    bash $RESOURCES_PATH/bash/after_failure.sh
fi

bash $WORKFLOW/after.sh
