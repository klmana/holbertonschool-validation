#!/bin/bash

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
    new_machine=$(aws ec2 run-instances --image-id ami-0c94855ba95c71c99 --count 1 --instance-type t3.micro --key-name awesome-key --security-group-ids awesome-sg --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$machine_name'}]' --query 'Instances[*].InstanceId' --output text)
    echo "New machine created: $new_machine"
else
    echo "Machine $machine_name already exists: $existing_machine"
fi
