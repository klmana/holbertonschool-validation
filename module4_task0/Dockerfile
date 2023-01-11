# syntax=docker/dockerfile:1
FROM golang:1.15.8-buster
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-arm64.deb && \
    dpkg -i hugo_extended_0.109.0_linux-arm64.deb && \
    rm -r hugo_extended_0.109.0_linux-arm64.deb && \
    rm -rf /usr/local/go/bin/go
WORKDIR /module4_task0
COPY . .
RUN hugo
CMD ["node", "hugo", "server", "--bind", "0.0.0.0", "--port", "5000"]
EXPOSE 5000
