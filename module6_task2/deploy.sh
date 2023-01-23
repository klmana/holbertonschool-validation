#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide the path to the docker-compose file as an argument."
    exit 1
fi

# Set the path to the docker-compose file
docker_compose_path=$1

# Set the remote hostname
DOCKER_HOST=ssh://ubuntu@$JENKINS_REMOTE_HOSTNAME

# Deploy the Docker Compose file
docker-compose -f $docker_compose_path up -d
"${compose_cmd[@]}" pull
"${compose_cmd[@]}" build
"${compose_cmd[@]}" up --detach
