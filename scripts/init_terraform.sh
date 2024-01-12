#!/bin/bash

set -eu
set -o pipefail

script_dir=$(dirname "$0")
terraform_dir=$(realpath "$script_dir/../terraform")

export BUCKET_NAME=""
export DYNAMODB_NAME=""

if ! [ -x "$(command -v envsubst)" ]; then
    echo "envsubst is not installed. Please install it first."
    echo "alpine: apk add gettext"
    echo "ubuntu: apt-get install gettext-base"
    exit 1
fi

# init setup backend for terraform
(
    cd "$terraform_dir/setup"
    
    if ! [ -f ./.tfvars/test.tfvars ]; then
        cp ./test.tfvars.tpl ./.tfvars/test.tfvars
    fi

    terraform init 
    terraform apply -var-file ./.tfvars/test.tfvars -auto-approve

    export BUCKET_NAME=$(terraform output bucket_name)
    export DYNAMODB_NAME=$(terraform output dynamodb_name)

    cd "$terraform_dir"

    if ! [ -f ./.tfvars/test.tfvars ]; then
        cp ./test.tfvars.tpl ./.tfvars/test.tfvars
    fi

    if ! [ -f ./provider.tf ]; then
        echo "BUCKET_NAME: $BUCKET_NAME"
        echo "DYNAMODB_NAME: $DYNAMODB_NAME"

        envsubst < provider.tf.tpl > provider.tf
    fi
)

