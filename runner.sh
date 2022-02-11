#!/bin/bash

OPT_SED_INDENT='s/^/      /'

# Settings
export PROJECT=${PROJECT:-"overview"}
export DISTRO=${DISTRO:-"bionic"}
export IMAGE_NAME=${PROJECT}-${DISTRO}:devel

case ${DISTRO} in
    "xenial")
        BASE_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04";;
    "bionic")
        BASE_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04";;
    "focal")
        BASE_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04";;
    *)
        echo "Ubuntu distro invalid! Checks the file settings.sh"
        exit 1;;
esac

docker build --rm \
             --build-arg BASE_IMAGE=${BASE_IMAGE} \
             --compress \
             --no-cache=true \
             -t ${IMAGE_NAME} .

docker run -t --rm \
            --net host \
            --name overview \
            -e PROJECT=${PROJECT} \
            ${IMAGE_NAME}
