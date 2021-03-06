echo "build..."

docker image prune -f
status=0
export DOCKER_IMAGE_NAME=docker_${GITHUB_RUN_NUMBER}_${GITHUB_RUN_ID}_image
docker build --no-cache \
    -t $DOCKER_IMAGE_NAME \
    -f $RESOURCES_PATH/docker/Dockerfile . || status=$?
if test $status -ne 0; then
    echo "Build error!"; return 1
fi

export DOCKER_CONTAINER_NAME=docker_${GITHUB_RUN_NUMBER}_${GITHUB_RUN_ID}_container
export ASSEMBLY_PATH=assembly_${GITHUB_RUN_NUMBER}_${GITHUB_RUN_ID}
rm -rf $ASSEMBLY_PATH
mkdir -p $ASSEMBLY_PATH || return 2

. $WORKFLOW/build/assembly.sh || status=$?
if test $status -ne 0; then
    echo "Assembly error!"; return 3
fi

export VERSION_NAME=""
export VERSION_CODE=""
export APPLICATION_ID=""
while IFS='=' read -r k v; do
    if test $k == versionName; then
        VERSION_NAME=$v
    elif test $k == versionCode; then
        VERSION_CODE=$v
    elif test $k == applicationId; then
        APPLICATION_ID=$v
    fi
done < $ASSEMBLY_PATH/assembly/summary

if test -z $VERSION_NAME; then
    echo "Assembly summary file must contains VERSION_NAME!"; return 41
fi
if test -z $VERSION_CODE; then
    echo "Assembly summary file must contains VERSION_CODE!"; return 42
fi
if test -z $APPLICATION_ID; then
    echo "Assembly summary file must contains APPLICATION_ID!"; return 43
fi

return 0
