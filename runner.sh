#!/bin/bash

OPT_SED_INDENT='s/^/      /'

# Settings
export PROJECT=${PROJECT:-"overview"}
export DISTRO=${DISTRO:-"bionic"}
export BASE_IMAGE=${BASE_IMAGE:-"nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04"};
export IMAGE_NAME=${PROJECT}-${DISTRO}:devel

echo "::group::List Parameter"
printf "%s\n" "$PROJECT"      | sed "$OPT_SED_INDENT"
printf "%s\n" "$DISTRO"       | sed "$OPT_SED_INDENT"
printf "%s\n" "$BASE_IMAGE"   | sed "$OPT_SED_INDENT"
printf "%s\n" "$IMAGE_NAME"   | sed "$OPT_SED_INDENT"
echo "::endgroup::"

echo "::group::Build Image"
docker build --rm \
             --build-arg BASE_IMAGE=${BASE_IMAGE} \
             --compress \
             --no-cache=true \
             -t ${IMAGE_NAME} .
echo "::endgroup::"

echo "::group::Run docker"
docker run -t --rm \
            --net host \
            --name overview \
            -e PROJECT=${PROJECT} \
            ${IMAGE_NAME}
echo "::endgroup::"

