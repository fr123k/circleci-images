ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV GO_VERSION=1.17.8

# Install packages needed for CGO
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends g++ libc6-dev && \
    sudo rm -rf /var/lib/apt/lists/* && \
    curl -sSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | sudo tar -xz -C /usr/local/ && \
    mkdir -p /home/circleci/go/bin && \
    sudo apt-get -y clean autoremove

RUN curl -sSL "https://github.com/gotestyourself/gotestsum/releases/download/v1.7.0/gotestsum_1.7.0_linux_amd64.tar.gz" | \
    sudo tar -xz -C /usr/local/bin gotestsum

ENV GOPATH /home/circleci/go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN aws --version && \
    kubectl version --client=true && \
    helm version && \
    docker --version && \
    terraform version && \
    go version

LABEL org.label-schema.description="CircleCi custom golang image"
