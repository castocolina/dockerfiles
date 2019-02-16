#!/bin/bash


echo;echo;echo;
echo "BUILD FOR $IMAGE_NAME v$IMAGE_VERSION"

PLUGINS="grafana-clock-panel"; \
PLUGINS="${PLUGINS},grafana-piechart-panel"; \
PLUGINS="${PLUGINS},grafana-worldmap-panel"; \
PLUGINS="${PLUGINS},grafana-simple-json-datasource"; \
PLUGINS="${PLUGINS},fzakaria-simple-annotations-datasource"; \
echo "PLUGINS == ${PLUGINS}";
echo 

docker build \
-t $DOCKER_USER/$IMAGE_NAME -t $DOCKER_USER/$IMAGE_NAME:base -t $DOCKER_USER/$IMAGE_NAME:latest \
--force-rm --no-cache \
--build-arg BASE_IMAGE="grafana/grafana:$IMAGE_VERSION" \
--build-arg GF_INSTALL_PLUGINS="$PLUGINS" \
-f  Dockerfile .


#PLUGINS="stackdriver" ## Installed in default grafana package
PLUGINS="grafana-azure-monitor-datasource"
PLUGINS="${PLUGINS},sbueringer-consul-datasource"
PLUGINS="${PLUGINS},instana-datasource"
PLUGINS="${PLUGINS},grafana-kubernetes-app"
echo 
echo 
docker build \
-t $DOCKER_USER/$IMAGE_NAME:cloud -t $DOCKER_USER/$IMAGE_NAME:cloud-$IMAGE_VERSION -t $DOCKER_USER/$IMAGE_NAME:cloud-$IMAGE_SVERSION \
--force-rm --no-cache \
--build-arg BASE_IMAGE="$DOCKER_USER/$IMAGE_NAME:base" \
--build-arg GF_INSTALL_PLUGINS="$PLUGINS" \
-f  Dockerfile .

echo