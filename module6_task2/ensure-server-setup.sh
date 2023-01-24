#!/bin/bash

test -n "${1}" || { echo "ERROR: please provide the remote SSH server's hostname as argument"; exit 1; }

set -eux -o pipefail

./ensure-server-setup.sh new_remote_hostname "${1}"

function remote_command() {
  local remote_hostname="${1}"
  ssh ubuntu@"${remote_hostname}" "${@:2}"
}

## Check remote connexion
# Requirement: the remote server's fingerprint must be in ~/.ssh/known_hosts
ssh-keyscan -H "new_remote_hostname" >> ~/.ssh/known_hosts  || exit_on_error "Failed to check remote connexion"
test "$(remote_command echo Hello)" == "Hello" || { echo "ERROR: unable to connect to the remote SSH server"; exit 1; }

remote_command sudo apt-get update

remote_command sudo apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

remote_command curl --fail --silent --show-error --location https://get.docker.com --output /tmp/get-docker.sh
remote_command sudo sh /tmp/get-docker.sh
remote_command sudo adduser ubuntu docker
remote_command sudo systemctl enable docker
remote_command sudo systemctl restart docker

remote_command docker ps

remote_command sudo curl --fail --silent --show-error --location --output /usr/local/bin/docker-compose \
  https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64

remote_command sudo chmod a+x /usr/local/bin/docker-compose

remote_command docker-compose --version
