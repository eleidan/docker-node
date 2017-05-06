#!/usr/bin/env bash

# Copy existing one as a base for another version
VER=$1
mkdir $VER
cp -R 4.8.3/* $VER/

SEMVER_PATTERN="[0-9]+\.[0-9]+\.[0-9]+"

TARGET_FILE="${VER}/jessie/Dockerfile"
sed -i -r \
    -e "s/Node\.js ${SEMVER_PATTERN}/Node\.js ${VER}/g" \
    -e "s/node:${SEMVER_PATTERN}/node:${VER}/g" \
    -e "s/NODE_VERSION=${SEMVER_PATTERN}/NODE_VERSION=${VER}/g" \
    -e "s/version=\S*/version=\"$(date +"%F")\"/g" \
    ${TARGET_FILE}

TARGET_FILE="${VER}/jessie/recipes/Dockerfile"
sed -i -r \
    -e "s/node:${SEMVER_PATTERN}/node:${VER}/g" \
    ${TARGET_FILE}
