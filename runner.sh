#!/bin/bash

OPTION_SED_INDENT='s/^/      /'

# Settings
export PROJECT=${PROJECT:-"sonarsim"}

if [ -f "$DISTRO" ]; then export DISTRO=$(<${DISTRO:-"focal"}); fi
if [ -f "$BOOTSTRAP" ]; then export BOOTSTRAP=$(<${BOOTSTRAP:-}); fi

export IMAGE_NAME=${PROJECT}-${DISTRO}:devel
export USER="$(id -nu)"
export UUID="$(id -u)"
export UGID="$(id -g)"
export WORKSPACE="~/workspace/${PROJECT}_${DISTRO}"

case ${DISTRO} in
    "xenial")
        export IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04";;
    "bionic")
        export IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04";;
    "focal")
        export IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04";;
    *)
        echo "Ubuntu distro invalid! Checks the file settings.sh"
        exit 1;;
esac

docker build --rm \
             --build-arg IMAGE_BASE=${IMAGE_BASE} \
             --compress \
             --no-cache=true \
             -t ${IMAGE_NAME} .

docker run -t --rm \
            --net host \
            --name overview \
            -e PROJECT=${PROJECT} \
            ${IMAGE_NAME}
