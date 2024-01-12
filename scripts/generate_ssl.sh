#!/bin/bash

set -eu
set -o pipefail

# I don't have a domain name, so I'm using AWS as an example
DOMAIN="amazonaws.com"
DAYS=365

script_path=$(dirname "$0")
certs_dir=$(realpath "$script_path/../.secrets/certs")
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


if [ ! -d "$certs_dir" ]; then
    mkdir -p "$certs_dir"
fi

if [ -f "$certs_dir/$DOMAIN.key" ]; then
    echo "Certificate already exists: $certs_dir/$DOMAIN.key"

    if ask "Overwrite?" "y"; then
        rm "$certs_dir/$DOMAIN.key"
        rm "$certs_dir/$DOMAIN.crt"
    else
        exit 0
    fi
fi

(
    cd $certs_dir

    if [ ! -f "$certs_dir/$DOMAIN.key" ]; then
        echo "Generating certificate: $DOMAIN.key"

        openssl genrsa -out "$DOMAIN.key" 2048
        openssl req -new -x509 -key "$DOMAIN.key" -out "$DOMAIN.crt" -days $DAYS \
            -subj "/C=US/ST=State/L=City/O=Organization/OU=OrganizationalUnit/CN=$DOMAIN"
    fi

    echo "done!"
)
