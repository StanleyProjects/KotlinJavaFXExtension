echo "build..."

export DOCKER_IMAGE_NAME=docker_${GITHUB_RUN_NUMBER}_${GITHUB_RUN_ID}_image

docker image prune -f
status=0
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

. $WORKFLOW/assembly.sh || status=$?
if test $status -ne 0; then
    echo "Assembly error!"; return 3
fi

export VERSION_NAME=""
#export VERSION_CODE=""
while IFS='=' read -r k v; do
    if test $k == versionName; then
        VERSION_NAME=$v
#    elif test $k == versionCode; then
#        VERSION_CODE=$v
    fi
done < $ASSEMBLY_PATH/summary

if test -z $VERSION_NAME; then
    echo "Assembly summary file must contains VERSION_NAME!"; return 41
fi
#if test -z $VERSION_CODE; then
#    echo "Assembly summary file must contains VERSION_CODE!"; return 42
#fi

return 0
