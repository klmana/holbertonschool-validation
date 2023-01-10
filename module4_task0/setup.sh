#!/bin/bash
docker run -v "$(pwd)":/usr/src/app -w /usr/src/app golang:1.15.8-buster make build
