#!/bin/sh -l

export PROJECT="${PROJECT:-}"

echo "ENTRYPOINT::PROJECT ${PROJECT}"

time=$(date)
echo ::set-output name=time::$time

version=$(cat /etc/issue)

echo "version ${version}"
echo "::set-output name=version::${version}"
