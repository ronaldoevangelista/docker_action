#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo ::set-output name=time::$time

version=$(cat /etc/alpine-release)

echo "::set-output name=version::${version}"
