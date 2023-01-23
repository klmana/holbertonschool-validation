#!/bin/bash

KEYPAIR_NAME="awesome-key"
SECGROUP_NAME="awesome-sg"
INSTANCE_SUFFIX="${INSTANCE_SUFFIX:-dev}"

if [ -z "$1" ]; then
    echo "Error: Please provide a machine name (jenkins or production) as an argument."
    exit 1
fi

# Set the machine name
machine_name=$1

# Check if the machine already exists
existing_machine=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$machine_name" --query 'Reservations[*].Instances[*].InstanceId' --output text)

if [ -z "$existing_machine" ]; then
    echo "Creating new machine: $machine_name"

# Create a new machine with the specified name
    aws ec2 run-instances --image-id="${ami_id}" --instance-type="t3.micro" \
    --key-name="${KEYPAIR_NAME}" \
    --security-groups="${SECGROUP_NAME}" \
    --tag-specifications='ResourceType=instance,Tags=[{Key=Name,Value='"${INSTANCE_NAME}"'}]' >/dev/null

# Check prerequisites
command -v aws >/dev/null 2>&1 || exit_on_error "No command line 'aws' found"

aws ec2 describe-key-pairs --key-names="${KEYPAIR_NAME}" >/dev/null 2>&1 \
  || exit_on_error "No keypair named '${KEYPAIR_NAME}' found"

aws ec2 describe-security-groups --group-name="${SECGROUP_NAME}" >/dev/null 2>&1 \
  || exit_on_error "No security group named '${SECGROUP_NAME}' found"

