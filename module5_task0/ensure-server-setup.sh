#!/bin/bash

# Configure the AWS CLI with your access key and secret key
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key

# check if security group already exists
existing_sg=$(aws ec2 describe-security-groups --region ap-southeast-2 --filters "Name=group-name,Values=awesome-sg" --query "SecurityGroups[].GroupId" --output text)
if [ -z "$existing_sg" ]; then
    # create security group
    sg_id=$(aws ec2 create-security-group --region ap-southeast-2 --group-name awesome-sg --description "Security group for awesome server" --query 'GroupId' --output text)
    echo "Security group created with id: $sg_id"
else
    sg_id=$existing_sg
    echo "Security group already exists with id: $sg_id"
fi

# check if the ingress rule already exists
existing_rule=$(aws ec2 describe-security-groups --region ap-southeast-2 --group-ids "$sg_id" --query "SecurityGroups[].IpPermissions[?FromPort=='22']" --output text)
if [ -z "$existing_rule" ]; then
    # authorize security group ingress for port 22
    aws ec2 authorize-security-group-ingress --region ap-southeast-2 --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
    echo "Ingress rule added for port 22"
else
    echo "Ingress rule already exists for port 22"
fi

# Check if key pair already exists
existing_key=$(aws ec2 describe-key-pairs --region ap-southeast-2 | grep 'KeyName' | grep -c 'awesome-key')
if [ $existing_key -eq 0 ]; then
    # create key pair 
    aws ec2 create-key-pair --region ap-southeast-2 --key-name awesome-key
    echo "Key pair created with the name awesome-key"
else
    echo "Key pair already exists with the name awesome-key"
fi
