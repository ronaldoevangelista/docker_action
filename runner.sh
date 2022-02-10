#!/bin/bash

option_sed_indent='s/^/      /'

export DISTRO_NAME=${DISTRO_NAME:-"nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04"}
export PROJECT_NAME=${PROJECT_NAME:-"overview"}

printf "%s\n" "$DISTRO_NAME"  | sed "$option_sed_indent"
printf "%s\n" "$PROJECT_NAME" | sed "$option_sed_indent"

IMAGE_NAME=${PROJECT_NAME}:devel

echo "::group::Build Image"
docker build  --rm \
    --build-arg PROJECT_NAME=$DISTRO_NAME \
    -t ${IMAGE_NAME} .
echo "::endgroup::"


