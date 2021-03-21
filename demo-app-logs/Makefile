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
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_SVERSION)

images: 
	docker images | egrep "$(IMAGE_NAME)"

test:
	true

push:
	docker push $(DOCKER_USER)/$(IMAGE_NAME)

.PHONY: build test images push