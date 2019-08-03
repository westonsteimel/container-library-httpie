#!/bin/sh

echo "$GH_PKG_REG_PASSWORD" | docker login $GH_PKG_REG_URL -u $DOCKER_USERNAME --password-stdin
