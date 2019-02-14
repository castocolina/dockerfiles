#!/bin/bash

# For local testing purposes

BASEDIR=$(dirname "$0")
export BASEDIR=$(readlink -f $BASEDIR)
export BASENAME=$(basename $BASEDIR)
export DIR_CHANGE=$(git log --name-status HEAD^..HEAD | cat | grep $BASENAME >/dev/null 2>&1)

export IMAGE_NAME=sonar-lts
export IMAGE_FLAVORS="base java js" # Space separate
export IMAGE_VERSION=6.7.6
export IMAGE_SVERSION=$(echo $IMAGE_VERSION | cut -d'.' -f1,2)
export DOCKER_USER=${DOCKER_USER:-castocolina}


# bash make_build.sh
make build
make images
make test
make version-tag

echo "$DOCKER_USER"
echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_USER" --password-stdin
make push