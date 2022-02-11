#!/bin/sh -l

export PROJECT="${PROJECT:-}"

echo "ENTRYPOINT::PROJECT ${PROJECT}"

version=$(cat /etc/issue)

echo "version ${version}"
