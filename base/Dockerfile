FROM cimg/base:2023.09

ARG TERRAFORM_VERSION=1.5.7
ENV GITHUB_COMMENT_VERSION=6.0.1
ENV TERRAFORM_BACKEND_GIT=0.1.5

RUN curl -s -o "/tmp/get-helm.sh" https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x /tmp/get-helm.sh && \
    sudo /tmp/get-helm.sh

RUN curl -s -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    sudo mv kubectl /usr/local/bin/

RUN curl -f -o /tmp/terraform.zip \
    https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm -f /tmp/terraform.zip

RUN curl -sSL https://github.com/suzuki-shunsuke/github-comment/releases/download/v${GITHUB_COMMENT_VERSION}/github-comment_${GITHUB_COMMENT_VERSION}_linux_amd64.tar.gz | \
    sudo tar -xz -C /usr/local/bin github-comment

RUN curl -sSL -o /tmp/terraform-backend-git https://github.com/plumber-cd/terraform-backend-git/releases/download/v${TERRAFORM_BACKEND_GIT}/terraform-backend-git-linux-amd64 && \
    sudo mv /tmp/terraform-backend-git /usr/local/bin/ && \
    sudo chmod +x  /usr/local/bin/terraform-backend-git 

RUN sudo apt-get update && \
    # sudo apt-get -y upgrade && \
    sudo apt-get install -y apt-utils

RUN uname --all

RUN sudo apt-get update && \
    sudo apt-get install -y python3 pip jq git docker-ce-cli openssl groff linux-headers-generic wireguard wireguard-tools && \
    sudo pip3 -q install --upgrade pip && \
    sudo pip3 -q install awscli boto3 && \
    sudo apt-get -y clean autoremove

RUN aws --version && \
    kubectl version --client=true && \
    helm version && \
    docker --version && \
    terraform version  && \
    github-comment -v && \
    terraform-backend-git version 
    # && \
    # sudo modprobe wireguard

USER circleci

ARG BUILD_DATE
ARG GIT_COMMIT
ARG VERSION

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="$BUILD_DATE"
LABEL org.label-schema.name="circleci-base"
LABEL org.label-schema.description="CircleCi custom base image"
LABEL org.label-schema.vcs-url="https://github.com/fr123k/circleci-images"
LABEL org.label-schema.vcs-ref="$GIT_COMMIT"
LABEL org.label-schema.version="$VERSION"
