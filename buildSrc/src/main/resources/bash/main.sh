echo "main start..."

bash $RESOURCES_PATH/bash/setup.sh || exit 1

bash $RESOURCES_PATH/bash/vcs_connect.sh || exit 2

status=0
#docker build --no-cache -f $RESOURCES_PATH/docker/Dockerfile . || status=1

if test $status -eq 0; then
    IS_BUILD_SUCCESS=0
#    bash $RESOURCES_PATH/bash/after_success.sh
else
    IS_BUILD_SUCCESS=1
#    bash $RESOURCES_PATH/bash/after_failure.sh
fi

bash $RESOURCES_PATH/bash/after.sh
