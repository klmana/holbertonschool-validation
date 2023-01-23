#!/bin/bash

set -eux -o pipefail

KEYPAIR_NAME="awesome-key"
SECGROUP_NAME="awesome-sg"
INSTANCE_SUFFIX="${INSTANCE_SUFFIX:-dev}"

function exit_on_error() {
  echo "ERROR: ${1}. Exiting."
  exit 1
}

function get_instance_id() {
  aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=running Name='tag:Name',Values="${INSTANCE_NAME}" \
    | grep 'InstanceId' \
    | cut -d'"' -f4
}

allowed_instance_names=("production" "jenkins")
if [[ ! ${allowed_instance_names[*]} =~ (^|[[:space:]])"${1:-empty}"($|[[:space:]]) ]]; then
  exit_on_error "please provide the name of the instance as argument with a value in [${allowed_instance_names[*]}]"
fi
INSTANCE_NAME="${1:-production}_${INSTANCE_SUFFIX}"

## Check prerequisites
command -v aws >/dev/null 2>&1 || exit_on_error "No command line 'aws' found"

aws ec2 describe-key-pairs --key-names="${KEYPAIR_NAME}" >/dev/null 2>&1 \
  || exit_on_error "No keypair named '${KEYPAIR_NAME}' found"

aws ec2 describe-security-groups --group-name="${SECGROUP_NAME}" >/dev/null 2>&1 \
  || exit_on_error "No security group named '${SECGROUP_NAME}' found"


## Create the instance if it does not already exist
if test -z "$(get_instance_id)"
then
  # Retrieve the AMI ID
  ami_name_pattern='ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-????????'
  owner_id='099720109477'
  ami_id="$(aws ec2 describe-images --owners "${owner_id}" --output text \
    --filters "Name=name,Values=${ami_name_pattern}" "Name=state,Values=available" \
    --query "reverse(sort_by(Images, &CreationDate))[:1].ImageId")"
  test -n "${ami_id}" || exit_on_error "No AMI found for owner ${owner_id} and name ${ami_name_pattern}"

  # Create the instance
  aws ec2 run-instances --image-id="${ami_id}" --instance-type="t3.micro" \
    --key-name="${KEYPAIR_NAME}" \
    --security-groups="${SECGROUP_NAME}" \
    --tag-specifications='ResourceType=instance,Tags=[{Key=Name,Value='"${INSTANCE_NAME}"'}]' >/dev/null

  # Wait for the instance to be started
  sleep 60
fi

## Sanity Check
instance_id="$(get_instance_id)"
test -n "${instance_id}" || exit_on_error 'No  running instance found with the tag "Name='"${INSTANCE_NAME}"'"'

## Prints the public DNS name and exit successfully
aws ec2 describe-instances --instance-ids="${instance_id}" \
  | grep 'PublicDnsName' \
  | cut -d'"' -f4 \
  | sort | uniq
exit 0
