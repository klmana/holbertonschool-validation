#!/bin/bash
apt-get update && apt-get install -y golang && apt-get install -y hugo make shellcheck
curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-amd64.deb -o hugo.deb
apt install ./hugo.deb
rm hugo.deb
make build
