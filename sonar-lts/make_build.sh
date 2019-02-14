#!/bin/bash

IFS=' ' read -r -a IMAGE_FLAVOR <<< "$IMAGE_FLAVORS"
echo "BUILD FOR $IMAGE_NAME v$IMAGE_VERSION --> ${IMAGE_FLAVORS[@]}"

for FLAVOR in ${IMAGE_FLAVORS[@]}; do
    printf "\n>>> BUILD FOR $FLAVOR v$IMAGE_SVERSION \n\n"
    docker build \
        -t $DOCKER_USER/$IMAGE_NAME:$FLAVOR-$IMAGE_SVERSION \
        -t $DOCKER_USER/$IMAGE_NAME:$FLAVOR-$IMAGE_VERSION \
        -t $DOCKER_USER/$IMAGE_NAME:$FLAVOR \
        --build-arg SONAR_VERSION=$IMAGE_VERSION \
        --force-rm --no-cache \
        -f  $FLAVOR/Dockerfile $FLAVOR || exit 1
done