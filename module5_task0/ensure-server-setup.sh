#!/bin/bash

# check if instance already exists
instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=awesome-server" --query "Reservations[].Instances[].InstanceId" --output text)

if [ -n "$instance_id" ]; then
    # get public dns name of existing instance
    dns=$(aws ec2 describe-instances --instance-ids "$instance_id" --query "Reservations[].Instances[].PublicDnsName" --output text)
    echo "Instance already exists with public DNS name: $dns"
else
    # create security group
    sg_id=$(aws ec2 create-security-group --group-name awesome-sg --description "Security group for awesome server" --query 'GroupId' --output text)
    aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress --
fi
