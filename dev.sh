#!/bin/sh

set -eu
set -o pipefail

# Run me to start a new dev container
# For more info see: https://github.com/JBongars/docker-tools
# source: https://github.com/JBongars/docker-tools/tree/main/images/aws

project_dir=$(dirname $0)
home_dir=$(echo $HOME)

docker run -it \
    -v "$project_dir:/work  \
    --hostname dtools-aws \
    -v $HOME/.gitconfig:/root/.gitconfig \
    -v $HOME/.netrc:/root/.netrc \
    -v $HOME/.ssh:/root/.ssh \
    -v $HOME/.git-credentials:/root/.git-credentials \
    -v $HOME/.terraform.d:/root/.terraform.d \
    -v $HOME/.aws:/root/.aws \
    --rm  dtools_aws:latest fish