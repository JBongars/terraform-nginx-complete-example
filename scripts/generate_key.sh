#!/bin/sh

set -eu
set -o pipefail

script_path=$(dirname "$0")
secrets_dir=$(realpath "$script_path/../.secrets")

function generate_key() {
    local key_name=$1
    local key_type=$2
    local comment=$3
    local key_path="$secrets_dir/$key_name"

    # check if key already exists
    if [ ! -f "$key_path" ]; then
        ssh-keygen -t "$key_type" -f "$key_path" -N "" -C "$comment"
    fi
    echo "$key_path"
}

if [ ! -d "$secrets_dir" ]; then
    mkdir "$secrets_dir"
fi

#nginx key
generate_key "nginx" "ed25519" "nginx-key"