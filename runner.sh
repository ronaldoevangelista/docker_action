#!/bin/bash

option_sed_indent='s/^/      /'

DISTRO_NAME=${DISTRO_NAME:-"nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04"}
PROJECT_NAME=${PROJECT_NAME:-"overview"}

printf "%s\n" "$DISTRO_NAME"  | sed "$option_sed_indent"
printf "%s\n" "$PROJECT_NAME" | sed "$option_sed_indent"

echo "::group::Build Image"
docker build --rm --build-arg PROJECT_NAME="$PROJECT_NAME" -t "$DISTRO_NAME" .
echo "::endgroup::"

docker run -t --rm \
  "${PROJECT_NAME}"