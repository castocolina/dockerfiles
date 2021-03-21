#!/bin/bash

# For local testing purposes

BASEDIR=$(dirname "$0")
export BASEDIR=$(readlink -f $BASEDIR)
export BASENAME=$(basename $BASEDIR)
export DIR_CHANGE=$(git log --name-status HEAD^..HEAD | cat | grep $BASENAME >/dev/null 2>&1)

export IMAGE_NAME=lighttpd
export IMAGE_VERSION=1.4.52
export IMAGE_SVERSION=$(echo $IMAGE_VERSION | cut -d'.' -f1,2)
export DOCKER_USER=${DOCKER_USER:-castocolina}


make -f $BASEDIR/Makefile build
make -f $BASEDIR/Makefile images
make -f $BASEDIR/Makefile test
make -f $BASEDIR/Makefile version-tag

echo "$DOCKER_USER"
echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_USER" --password-stdin
make -f $BASEDIR/Makefile push