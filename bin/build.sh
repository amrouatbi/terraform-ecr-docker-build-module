#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2
build_arg=$3

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Connect into aws
docker run \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_DEFAULT_REGION \
    amazon/aws-cli:latest \
    ecr get-login-password \
    | docker login \
    --username AWS \
    --password-stdin \
    $aws_ecr_repository_url_with_tag

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Workaround to build in parent context and so we can include utils
cd $build_folder

# Build image
docker build -t $aws_ecr_repository_url_with_tag --build-arg=$build_arg $build_folder

# Push image
docker push $aws_ecr_repository_url_with_tag
