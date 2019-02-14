remove-local-image:
	true

build:
	echo "BUILD FOR $(IMAGE_NAME) v$(IMAGE_VERSION)"
	docker build \
    -t $(DOCKER_USER)/$(IMAGE_NAME) -t $(DOCKER_USER)/$(IMAGE_NAME):latest \
    --force-rm --no-cache \
    -f  Dockerfile .

# create tag of image with software version
version-tag:
	SOFT_VERSION=$(docker run --rm --name test-lighthttpd-image $(DOCKER_USER)/$(IMAGE_NAME) \
	/bin/sh -c "lighttpd -version")
	IMAGE_VERSION=$(echo $SOFT_VERSION | cut -d' ' -f1 | cut -d'/' -f2)
	IMAGE_SVERSION=$(echo $IMAGE_VERSION | cut -d'.' -f1,2)
	echo "VERSIONS ::: $(IMAGE_VERSION)  === $(IMAGE_SVERSION)"
	
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_SVERSION)

images: 
	docker images | egrep "$(IMAGE_NAME)"

test:
	true

push:
	docker push $(DOCKER_USER)/$(IMAGE_NAME)

.PHONY: build test images push