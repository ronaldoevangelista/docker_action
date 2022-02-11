#!/bin/bash

OPT_SED_INDENT='s/^/      /'

# Settings
export PROJECT=${PROJECT:-"sonarsim"}

if [ -f "$DISTRO" ]; then export DISTRO=$(<"$DISTRO"); fi

OPTION_SED_INDENT='s/^/      /'


export IMAGE_NAME=${PROJECT}-${DISTRO}:devel
export USER="$(id -nu)"
export UUID="$(id -u)"
export UGID="$(id -g)"
export WORKSPACE="~/workspace/${PROJECT}_${DISTRO}"
export BOOTSTRAP=${BOOTSTRAP}

printf "%s\n" "$DISTRO" | sed "$OPTION_SED_INDENT"


case ${DISTRO} in
    "xenial")
        IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04";;
    "bionic")
        IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04";;
    "focal")
        IMAGE_BASE="nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04";;
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
