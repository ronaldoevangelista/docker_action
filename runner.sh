#!/bin/bash
set -x
if [ -f "$PROJECT" ]; then export PROJECT=$(<${PROJECT:-"sonarsim"}); fi
if [ -f "$DISTRO" ]; then export DISTRO=$(<${DISTRO:-"focal"}); fi
if [ -f "$BOOTSTRAP_URL" ]; then export BOOTSTRAP_URL=$(<${BOOTSTRAP_URL:-}); fi
if [ -f "$USER_NAME" ]; then export USER_NAME=$(<${USER_NAME:-"Sonarsim"}); fi
if [ -f "$USER_EMAIL" ]; then export USER_EMAIL=$(<${USER_EMAIL:-"sonarsim@sonarsim.com"}); fi
if [ -f "$PRIVATE_SSH_KEY" ]; then export PRIVATE_SSH_KEY=$(<${PRIVATE_SSH_KEY:-}); fi

export IMAGE_NAME=${PROJECT}-${DISTRO}:devel

USER="$(id -nu)"
UUID="$(id -u)"
UGID="$(id -g)"

export UUID
export UGID

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
             --build-arg USER=${USER} \
            --compress \
            --no-cache=true \
            -t ${IMAGE_NAME} .

docker run -t --rm \
            --net host \
            -e PROJECT="${PROJECT}" \
            -e BOOTSTRAP_URL="${BOOTSTRAP_URL}" \
            -e USER_NAME="${USER_NAME}" \
            -e USER_EMAIL="${USER_EMAIL}" \
            -e PRIVATE_SSH_KEY="${PRIVATE_SSH_KEY}" \
            --user="${USER}" \
            --workdir="${HOME}" \
            --name "${PROJECT}-${DISTRO}" ${IMAGE_NAME}
