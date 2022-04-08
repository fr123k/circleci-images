.PHONY: build

IMAGE_NAME?=fr123k/circleci-golang
VERSION?=${BUILD_DATE}_${GIT_COMMIT}
BASE_IMAGE?=circleci-base:latest
IMAGE?="${IMAGE_NAME}:${VERSION}"

build:
	docker build \
		--build-arg BASE_IMAGE=${BASE_IMAGE} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg GIT_COMMIT=${GIT_COMMIT} \
		--build-arg VERSION=${VERSION} \
		 -t $(IMAGE) -f Dockerfile .
