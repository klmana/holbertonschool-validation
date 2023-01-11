#!/bin/bash
apt-get update && apt-get install -y hugo make
make build
if [[ $? -ne 0 ]] ; then
        exit 255
fi