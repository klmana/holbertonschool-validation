#!/bin/bash

test -n "${1}" || { echo "ERROR: please provide the remote SSH server's hostname as argument"; exit 1; }

set -eux -o pipefail

remote_hostname="${1}"

args=("${@:2}")
escaped_args=()
for arg in "${args[@]}"; do
  escaped_args+=("$(printf %q "$arg")")
done

ssh ubuntu@"${remote_hostname}" "${escaped_args[*]}"

## Check remote connexion
# Requirement: the remote server's fingerprint must be in ~/.ssh/known_hosts
ssh-keyscan -H "${1}" >> ~/.ssh/known_hosts  || exit_on_error "Failed to check remote connexion"
test "$(ssh -t ubuntu@"${1}" echo Hello)" == "Hello" || { echo "ERROR: unable to connect to the remote SSH server"; exit 1; }

ssh -t ubuntu@"${1}" sudo apt-get update

ssh -t ubuntu@"${1}" sudo apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

ssh -t ubuntu@"${1}" curl --fail --silent --show-error --location https://get.docker.com --output /tmp/get-docker.sh
ssh -t ubuntu@"${1}" sudo

remote_command docker ps

remote_command sudo curl --fail --silent --show-error --location --output /usr/local/bin/docker-compose \
  https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64

remote_command sudo chmod a+x /usr/local/bin/docker-compose

remote_command docker-compose --version
