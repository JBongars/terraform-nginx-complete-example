#!/bin/bash

set -eu
set -o pipefail

script_path=$(dirname "$0")
terraform_dir=$(realpath "$script_path/../terraform")

_terraform=$(which terraform)
environment=$1
command=$2
args=${@:3}

enable_var_file=true # enabled by default
var_file="$terraform_dir/.tfvars/$environment.tfvars"

if [ ! -d "$terraform_dir" ]; then
    echo "Terraform directory not found: $terraform_dir"
    exit 1
fi

if [ ! -f "$var_file" ]; then
    echo "Terraform variable file not found: $var_file"
    echo "Create one by copying the example file:"
    echo "cp $terraform_dir/.tfvars/example.tfvars.tpl $var_file"
fi

# check if var file exist and if it should be used
if [[ "$args" == *"-no-var-file"* ]]; then
    enable_var_file=false
    args=$(echo "$args" | sed 's/-no-var-file//g')
else 
    enable_var_file=true
    args=$(echo "$args -var-file $var_file")
fi

(
    export TF_WORKSPACE="$environment"

    cd "$terraform_dir"
    echo "Running command: $_terraform $command $args"
    
    $_terraform init
    $_terraform $command $args
)