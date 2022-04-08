.PHONY: build

IMAGE_NAME?=fr123k/circleci-base
VERSION?=${BUILD_DATE}_${GIT_COMMIT}
IMAGE?="${IMAGE_NAME}:${VERSION}"

build:
	docker build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg GIT_COMMIT=${GIT_COMMIT} \
		--build-arg VERSION=${VERSION} \
		 -t $(IMAGE) -f Dockerfile .
