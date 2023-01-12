#!/usr/bin/env bash
apt-get update && apt-get install -y golang
curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-amd64.deb -o hugo.deb
sudo apt install ./hugo.deb
npm install -g markdownlint-cli
rm hugo.deb