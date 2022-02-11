#!/bin/bash

OPT_SED_INDENT='s/^/      /'

# Settings
export PROJECT="${PROJECT:-"overview"}"
export DISTRO="${DISTRO:-"bionic"}"
export BASE_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04";
export IMAGE_NAME=${PROJECT}-${DISTRO}:devel

printf "-- %s\n env" "$PROJECT"      | sed "$OPT_SED_INDENT"
printf "-- %s\n env" "$DISTRO"       | sed "$OPT_SED_INDENT"
printf "-- %s\n env" "$BASE_IMAGE"   | sed "$OPT_SED_INDENT"
printf "-- %s\n env" "$IMAGE_NAME"   | sed "$OPT_SED_INDENT"

docker build --compress \
             --no-cache=true \
             --build-arg BASE_IMAGE=${BASE_IMAGE} \
             -t ${IMAGE_NAME} .

docker run -t -i --rm \
            --net host \
            --name overview \
            -e DISTRO=${DISTRO} 
            ${IMAGE_NAME}

# docker run -d -t -i --rm -p 5051:5051
# --network=training_net -e NODE_ENV=${NODE_ENV} -e DATABASE_HOST=${DATABASE_HOST}
#  -e DATABASE_USERNAME=${DATABASE_USERNAME} -e DATABASE_PASSWORD=${DATABASE_PASSWORD} 
#  -e DATABASE=${DATABASE} -e SERVICE_TOKEN=${SERVICE_TOKEN} 
#  -e HOST_TRAINING_COURSE=${HOST_TRAINING_COURSE} -e SECRET=${SECRET} 
#  -e SECRET_KEY_PASSWORD=${SECRET_KEY_PASSWORD} --name training-user training-user:latest

# DISTRO=${DISTRO:-"bionic"}
# BASE_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04";


# export DISTRO_NAME=${DISTRO_NAME:-"nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04"}
# export PROJECT_NAME=${PROJECT_NAME:-"overview"}

# printf "%s\n" "$BASE_IMAGE"  | sed "$option_sed_indent"


# IMAGE_NAME=${PROJECT_NAME}:devel

# printf "%s\n" "$IMAGE_NAME" | sed "$option_sed_indent"

# CONTAINER_USER=${USER}-${PROJECT}

# docker build  \
#     --build-arg BASE_IMAGE=$BASE_IMAGE \
#     --build-arg USER=$CONTAINER_USER \
#     --compress --no-cache=true \
#     -t ${IMAGE_NAME} .

# docker run -d -t -i --rm \
#     --net host \
#     --name overview} overview:devel
