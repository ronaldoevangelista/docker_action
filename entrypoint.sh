#!/bin/sh -l

export PROJECT="${PROJECT:-}"
export BOOTSTRAP="${BOOTSTRAP:-}"

export AUTOPROJ_INSTALL_URL=https://raw.githubusercontent.com/rock-core/autoproj/master/bin/autoproj_install

BOOTSTRAP_URL=git@github.com:romulogcerqueira/sonar_simulation-buildconf.git

set -e

echo "ENTRYPOINT::PROJECT ${PROJECT}"
echo "ENTRYPOINT::BOOTSTRAP ${BOOTSTRAP}"

version=$(cat /etc/issue)

echo "version ${version}"

exec "$@"