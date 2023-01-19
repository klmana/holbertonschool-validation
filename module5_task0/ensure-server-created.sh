#!/bin/bash

# check if the server is running
status=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=awesome-server" --query "Reservations[].Instances[].State.Name" --output text)
if [ "$status" == "running" ]; then
  # get the public DNS name of the instance
  dns=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=awesome-server" --query "Reservations[].Instances[].PublicDnsName" --output text)
  echo "Server is running with public DNS name: $dns"
else
  # create the key pair
  aws ec2 create-key-pair --key-name awesome-key --query 'KeyMaterial' --output text > awesome-key.pem
  chmod 400 awesome-key.pem

  # create the security group
  sg_id=$(aws ec2 create-security-group --group-name awesome-sg --description "Security group for awesome server" --query 'GroupId' --output text)
  aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
  aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 80 --cidr 0.0.0.0/0
  aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 443 --cidr 0.0.0.0/0

  # create the instance
  instance_id=$(aws ec2 run-instances --image-id ami-0ac019f4fcb7cb7e6 --instance-type t3.micro --key-name awesome-key --security-group-ids "$sg_id" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=awesome-server}]' --query 'Instances[0].InstanceId' --output text)
  dns=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[].Instances[].PublicDnsName' --output text)
  echo "Server created with public DNS name: $dns"
fi
