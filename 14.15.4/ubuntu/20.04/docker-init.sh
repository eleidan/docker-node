#!/bin/sh

uid=$(id -u)
if [ $uid -eq 1000 ]; then
  exit 0
fi

echo "Adopting Dockerfile for the host UID and GID" \
  && sed -i -r -e "s/1000/$(id -u)/g" docker/Dockerfile

