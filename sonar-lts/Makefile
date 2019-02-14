remove-local-image:
	true

build:
	bash make_build.sh

# create latest tag of image with base version
version-tag:
	docker tag $(DOCKER_USER)/$(IMAGE_NAME):base-$(IMAGE_VERSION) $(DOCKER_USER)/$(IMAGE_NAME):latest

images: 
	docker images | egrep "$(IMAGE_NAME)"

test:
	true

push:
	docker push $(DOCKER_USER)/$(IMAGE_NAME)

.PHONY: build test images push