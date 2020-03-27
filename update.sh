#!/bin/bash
echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --region us-west-2 --stack-name $1 ; then

    echo -e "\nStack exists, attempting update ..."
    aws cloudformation update-stack \
    --stack-name $1 \
    --template-body file://$2 \
    --parameters file://$3 \
    --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
    --region=us-west-2

    echo "Waiting for stack update to complete ..."
    aws cloudformation wait stack-update-complete --stack-name $1 --region=us-west-2