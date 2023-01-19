#!/bin/bash

# check if the server is reachable
if ssh -q -o "StrictHostKeyChecking no" ubuntu@"$1" exit; then
  echo "Server is reachable."
else
  echo "Error: unable to reach the server."
  exit 1
fi

# check if Docker is installed and of the correct version
docker_version=$(ssh ubuntu@"$1" 'docker -v' | awk '{print $3}')
if [ "$docker_version" != "20.10" ]; then
  echo "Error: invalid Docker version installed. Expected 20.10, got $docker_version"
  exit 1
else
  echo "Docker version 20.10 is installed."
fi

# check if all packages are up to date
ssh ubuntu@"$1" 'sudo apt update'
