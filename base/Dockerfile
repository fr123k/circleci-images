FROM cimg/base:2022.03

ARG TERRAFORM_VERSION=1.0.2
ENV GITHUB_COMMENT_VERSION=4.1.1

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

RUN sudo apt-get update && \
    sudo apt-get -y upgrade && \
    sudo apt-get install -y apt-utils

RUN sudo apt-get update && \
    sudo apt-get install -y python3 pip jq git docker-ce-cli openssl groff && \
    sudo pip3 -q install --upgrade pip && \
    sudo pip3 -q install awscli boto3 && \
    sudo apt-get -y clean autoremove

RUN aws --version && \
    kubectl version --client=true && \
    helm version && \
    docker --version && \
    terraform version  && \
    github-comment -v

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