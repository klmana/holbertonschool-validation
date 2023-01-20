#!/bin/bash

# check if security group already exists
existing_sg=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=awesome-sg" --query "SecurityGroups[].GroupId" --output text)
if [ -n "$existing_sg" ]; then
    # use existing security group
    sg_id=$existing_sg
else
    # create security group
    sg_id=$(aws ec2 create-security-group --group-name awesome-sg --description "Security group for awesome server" --query 'GroupId' --output text)
fi

# check if the ingress rule already exists
existing_rule=$(aws ec2 describe-security-groups --group-ids "$sg_id" --query "SecurityGroups[].IpPermissions[?FromPort=='22']" --output text)
if [ -n "$existing_rule" ]; then
    # revoke security group ingress
    aws ec2 revoke-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
fi

# authorize security group ingress
aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
