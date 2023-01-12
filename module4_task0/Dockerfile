FROM golang:1.15.8-buster
WORKDIR /module4_task0
COPY . .
RUN apt-get update
ENV NODE_VERSION=16.13.0
RUN apt install -y curl zip
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN npm install -g npm@latest
RUN npm install -g  gulp-cli
RUN node --version
RUN npm --version
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.78.2/hugo_0.78.2_Linux-64bit.deb
RUN hugo version
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-arm64.deb -o hugo.deb
RUN dpkg -i ./hugo.deb
RUN npm install -g markdownlint-cli
RUN make build
RUN make package
