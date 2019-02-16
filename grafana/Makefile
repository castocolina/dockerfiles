remove-local-image:
	true

build:
	bash make_build.sh

# create tag of image with software version
version-tag:
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)
	docker tag $(DOCKER_USER)/$(IMAGE_NAME) $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_SVERSION)

images: 
	docker images | egrep "$(IMAGE_NAME)"

test:
	echo
	true
	echo "docker run -d --rm --name local-test-$(IMAGE_NAME) -p 3000:3000 $(DOCKER_USER)/$(IMAGE_NAME)"
	URL="http://$(hostname -I | cut -d' ' -f1):3000"
	printf "\n\n\t$(URL)\n\n"

kill-test:
	echo "docker ps | grep $(DOCKER_USER)/$(IMAGE_NAME) && docker rm -f local-test-$(IMAGE_NAME)"

push:
	docker push $(DOCKER_USER)/$(IMAGE_NAME)

.PHONY: build test images push