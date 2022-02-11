#!/bin/sh -l

export DISTRO="${DISTRO:-}"

echo ">>>DISTRO ${DISTRO}"

time=$(date)
echo ::set-output name=time::$time

version=$(cat /etc/issue)

echo "version ${version}"
echo "::set-output name=version::${version}"
