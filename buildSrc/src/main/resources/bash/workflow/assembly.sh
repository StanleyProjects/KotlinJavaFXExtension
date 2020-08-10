echo "assembly..."

tasks=(\
"docker run --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME"
"docker cp $DOCKER_CONTAINER_NAME:/assembly $ASSEMBLY_PATH"
"docker stop $DOCKER_CONTAINER_NAME"
"docker container rm -f $DOCKER_CONTAINER_NAME")

for ((i = 0; i < ${#tasks[@]}; i++)); do
    task=${tasks[$i]}
    status=0
    $task || status=$?
    if test $status -ne 0; then
        echo "task \"$task\" error!"; return $status
    fi
done

return 0
