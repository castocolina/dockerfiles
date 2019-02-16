#!/bin/bash

# For local testing purposes


BASEDIR=$(dirname "$0")
export BASEDIR=$(readlink -f $BASEDIR)
export BASENAME=$(basename $BASEDIR)
export DIR_CHANGE=$(git log --name-status HEAD^..HEAD | cat | grep $BASENAME >/dev/null 2>&1)

export IMAGE_NAME=grafana-bundle
export IMAGE_VERSION=5.4.3
export IMAGE_SVERSION=$(echo $IMAGE_VERSION | cut -d'.' -f1,2)
export DOCKER_USER=${DOCKER_USER:-castocolina}

docker image rm -f $(docker images $DOCKER_USER/$IMAGE_NAME -q)

make build
make images
make test
make version-tag

make remove-local-image

URL="http://$(hostname -I | cut -d' ' -f1):3000"
printf "\n\n\t$URL\n\n"

# echo "$DOCKER_USER"
# echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_USER" --password-stdin
# make push