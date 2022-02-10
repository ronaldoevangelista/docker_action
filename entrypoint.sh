#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo ::set-output name=time::$time

version=$(cat /etc/issue)

echo "version ${version}"

echo "::set-output name=version::${version}"
