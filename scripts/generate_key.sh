#!/bin/bash

set -eu
set -o pipefail

script_path=$(dirname "$0")
secrets_dir=$(realpath "$script_path/../.secrets")
no_attend=false

if [[ "$@" == *"-y"* ]]; then
    no_attend=true
fi

function ask(){
    local question=$1
    local default_answer=${2:-"y"}
    local answer

    if [ "$no_attend" = true ]; then
        answer=$default_answer
    else
        echo "$question (y/n)"
        read -r answer
    fi

    if [[ $answer =~ ^[Yy]([Ee][Ss])?$ ]]; then
        return 0
    else
        return 1
    fi
}

function generate_key() {
    local key_name=$1
    local key_type=$2
    local comment=$3
    local key_path="$secrets_dir/$key_name"

    # check if key already exists
    if [ -f "$key_path" ]; then
        echo "Key already exists: $key_path"

        if ask "Overwrite?" "y"; then
            echo "$key_path"
            exit 0
        fi
    else 
        ssh-keygen -t "$key_type" -f "$key_path" -N "" -C "$comment"
    fi
    echo "$key_path"
}

if [ ! -d "$secrets_dir" ]; then
    mkdir "$secrets_dir"
fi

#nginx key
(
    cd "$secrets_dir"

    if [ ! -f "$secrets_dir/nginx-key" ]; then
        generate_key "nginx" "ed25519" "nginx-key"
    fi 

    echo "done!"
)