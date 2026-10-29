#!/bin/bash

CONTAINER_NAME="upscayl-base"
IMAGE_NAME="upscayl-base:latest"
HOST_DIR="$(pwd)"

# If image does not exist create it
if [[ "$(sudo docker images -q ${IMAGE_NAME} 2> /dev/null)" == "" ]]; then
    echo "The image '${IMAGE_NAME}' doesn't exist. Building it from Dockerfile..."
    sudo docker build -t ${IMAGE_NAME} .
fi

# Check if container is running
if sudo docker ps --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
    echo "Container already UP. Adding new terminal"
    sudo docker exec -it ${CONTAINER_NAME} bash
else
    echo "Launching container for the first time"
    sudo docker rm -f ${CONTAINER_NAME} 2>/dev/null || true

    sudo docker run -it --rm \
        --name ${CONTAINER_NAME} \
        --runtime=nvidia \
        --net=host \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v ${HOST_DIR}:/workspace \
        ${IMAGE_NAME}
fi