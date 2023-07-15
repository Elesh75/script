#!/bin/bash

set -x

cd ./script.tf

ENVIRONMENT=prod
TF_PLAN="$ENVIRONMENT".tfplan

#winget install https://github.com/tfsec/tfsec/releases/download/v1.28.1/tfsec-linux-amd64
#chmod +x tfsec-linux-amd64
#mv tfsec-linux-amd64 /usr/local/bin/tfsec

echo $(aws sts get-caller-identity)
sleep 2
terraform fmt -recursive
terraform init
terraform validate
sleep 3

#tfsec .

if [ "$?" -eq "0" ]
then
  echo "your code passed all the tests"
  echo "The plan can be created successfully"
  sleep 3
else
  echo "Your code needs some work"
  exit 1
fi

terraform plan -out=${TF_PLAN}

if [ ! -f "${TF_PLAN}" ]; then
  echo "****Plan does not exist!****"

terraform apply "${TF_PLAN}"

#if [ "$?" -eq "0" ]
#then
 # cp scrit.sh /c/Users/ogunt/GitActionDemo1/File/Script
  #cd /c/Users/ogunt/GitActionDemo1/File/Script
  #bash scrit.sh
#else
 # echo "No response"
  #exit 1
#fi*/