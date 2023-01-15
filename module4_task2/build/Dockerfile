FROM golang:1.15.8-buster
WORKDIR /module4_task1
COPY . .

RUN apt-get update && \
    apt-get install -y curl zip && \
    rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=16.13.0

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm use v${NODE_VERSION} && \
    nvm alias default v${NODE_VERSION} && \
    PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN node --version && \
    npm --version && \
    curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-amd64.deb -o hugo.deb && \
    test -e /tmp/hugo.deb && dpkg -i /tmp/hugo.deb || echo 'File not found' && \
    npm install -g markdownlint-cli && \
    apt update -y && apt-get install -y docker.io && \
    apt install -y python3-pip && \
    pip3 install awscli && \
    apt install -y jq

RUN make build && \
    make package