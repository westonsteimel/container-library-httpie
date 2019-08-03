#!/bin/sh

echo "$DOCKER_PASSWORD" | docker login $DOCKER_REGISTRY_URL -u $DOCKER_USERNAME --password-stdin
