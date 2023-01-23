#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide the hostname of the remote machine as an argument."
    exit 1
fi

# Set the remote hostname
remote_hostname=$1

# Check if Docker is installed on the remote machine
docker_installed=$(ssh ubuntu@$remote_hostname 'which docker')

if [ -z "$docker_installed" ]; then
    echo "Docker not found on $remote_hostname, installing..."
# Install Docker on the remote machine
    ssh ubuntu@$remote_hostname 'sudo apt-get update && sudo apt-get install -y docker.io'
    echo "Docker installed on $remote_hostname"
else
    echo "Docker already installed on $remote_hostname"
fi
