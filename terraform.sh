#!/bin/bash  # This specifies the interpreter to be used

set -x  # This will show us the command to be run

export TF_LOG="DEBUG"
export TF_LOG_PATH="./terraform.log"   # This two variable are used when debugging

ENVIRONMENT=prod
TF_PLAN="$ENVIRONMENT".tfplan

wget https://github.com/tfsec/tfsec/releases/download/v1.28.1/tfsec-linux-amd64
chmod +x tfsec-linux-amd64
mv tfsec-linux-amd64 /usr/local/bin/tfsec

[ -d .terraform ] && rm -rf .terraform
rm -f *.tfplan

echo $(aws sts get-caller-identity)
sleep 2
terraform fmt -recursive
terraform init
terraform validate
sleep 3

tfsec .

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

# terraform apply 

cd /path/to/directory

./terraform.sh