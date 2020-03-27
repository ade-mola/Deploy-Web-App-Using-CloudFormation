#!/bin/bash
echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --region us-west-2 --stack-name $1 ; then

    echo -e "\nStack does not exist, creating ..."
    aws cloudformation create-stack \
    --stack-name $1 \
    --template-body file://$2 \
    --parameters file://$3 \
    --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
    --region=us-west-2

    echo "Waiting for stack to be created ..."
    aws cloudformation wait stack-create-complete --stack-name $1 --region=us-west-2