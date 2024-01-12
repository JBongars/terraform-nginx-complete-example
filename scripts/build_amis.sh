#!/bin/bash

set -eu
set -o pipefail

script_path=$(dirname "$0")
packer_dir=$(realpath "$script_path/../packer")
region=${AWS_DEFAULT_REGION:-"ap-southeast-1"}

echo "region: $region"

_packer=$(which packer)
environment=$1

if [ ! -d "$packer_dir" ]; then
    echo "Packer directory not found: $packer_dir"
    exit 1
fi

default_vpc_id=$(aws --region ap-southeast-1 ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text)

(
    export PACKER_LOG=1
    export PACKER_LOG_PATH="$packer_dir/.logs/packer-$environment.log"

    if [ ! -d "$packer_dir/.logs" ]; then
        mkdir "$packer_dir/.logs"
    fi
    
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-"ap-southeast-1"}

    cd "$packer_dir/nginx"
    echo "Running command: $_packer build -var \"region=$region\" -var \"environment=$environment\" -var \"vpc_id=$default_vpc_id\" $packer_dir/nginx"
    
    $_packer init $packer_dir/nginx
    $_packer build \
        -var "region=$region" \
        -var "environment=$environment" \
        -var "vpc_id=$default_vpc_id" \
        $packer_dir/nginx
)