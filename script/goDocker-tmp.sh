#!/bin/bash

REPO_NAME=fresh/ubuntu
REPO_TAG=v1
IMAGE_NAME="$REPO_NAME:$REPO_TAG"

MOUNT_HOST=`pwd`;
MOUNT_GUEST="/home/fresh/shared/"


WORK_DIR="/home/fresh/"

docker run --rm -it  \
        --name docker-ssh \
		-p 53:22 \
		-p 5901:5901 \
		-v $MOUNT_HOST:$MOUNT_GUEST \
		-w $WORK_DIR \
		$IMAGE_NAME \
		/bin/bash

# docker run  -it  \
#     -p 55667:22 \
#     -v $MOUNT_HOST:$MOUNT_GUEST \
#     -w $WORK_DIR \
#     --name hilbert_dk \
#     $IMAGE_NAME \
#     /bin/bash


# cd ~/Desktop/Docker-Working/
# docker start hilbert_dk
# docker attach hilbert_dk
