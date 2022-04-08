# circleci-images

This provide custom circleci build images with the needed tools and application golang and infrastructure.

# How to Use those Images

The custom circleci images are stored at [fr123k](https://hub.docker.com/u/fr123k) dockerhub registry.

This is an example how to use the circleci-base image latest version.
```yml
jobs:
  build:
    docker:
    - image: fr123k/circleci-base:latest
```

This is an example how to use a circleci-base image pinned version.
```yml
jobs:
  build:
    docker:
    - image: fr123k/circleci-base:20220214_7db2157
```

# Images

## Base Image

This contains only the listed software and can either be used directly in a circleci pipeline or as a container base image for language specific images.

Installed software
* awscli
* docker
* git
* helm
* kubectl
* python3
* pip
* terraform
* [suzuki-shunsuke/github-comment](https://github.com/suzuki-shunsuke/github-comment)

## Golang Image

This image provide the golang building tools at the time of writing this documentation it is version 1.17.x.

Installed software
* [go](https://golang.org) 
* [gotestsum](https://github.com/gotestyourself/gotestsum)

The official circleci golang image was used as a reference. [cimg-go](https://github.com/CircleCI-Public/cimg-go/)

# Development

If you have trouble building this images then disable buildkit.
```bash
export DOCKER_BUILDKIT=0
```

## Build All Images
```bash
BUILD_DATE=$(date +"%Y%m%d") GIT_COMMIT=$(git rev-parse --short HEAD) make build-all
```

## Build one Image
```bash
# cd <image_folder>
cd base
BUILD_DATE=$(date +"%Y%m%d") GIT_COMMIT=$(git rev-parse --short HEAD) make build
```


# Update / Publish Images

Open a Pull Request and after its merged the circleci pipeline will build all images and push them to the [dockerhub](https://hub.docker.com/u/fr123k) registry.

# Add an new Image

Create a new image folder for example `helmut` and copy the Dockerfile and the Makefile from an other image folder.

```bash
mkdir helmut
cp golang/* helmut/
```

## Makefile
Adjust the Makefile and give the image a proper name
```bash
IMAGE_NAME?=circleci-golang
# change the name of the image
IMAGE_NAME?=circleci-helmut
```

## Dockerfile
Adjust the Dockerfile to your needs.
```bash
# keep the definition of the BASE_IMAGE
ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN echo helmut
```

## CircleCi
Adjust the circleci config.yml and add the new image to the push-images step.
```yaml
jobs:
  build:
    docker:
      ...
    environment:
      ...
    resource_class: small
    steps:
      ...
      - when:
          condition:
            and:
            - equal: [ "main",  << pipeline.git.branch >> ]
          steps:
            - push-images:
              # add the new image name here so that it will be pushed to the AWS ecr
              # the naming pattern is circleci-[folder name]
              image_names: "circleci-base circleci-golang circleci-helmut"
              image_tag: ${CIRCLE_SHA1:0:7}
```
