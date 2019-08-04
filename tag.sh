#!/bin/sh

VERSION=$(grep -e "ARG HTTPIE_VERSION=" Dockerfile)
VERSION=${VERSION#ARG HTTPIE_VERSION=\"}
VERSION=${VERSION%\"}
echo "Tagging version ${VERSION}"
docker tag "${DOCKER_USERNAME}/httpie:latest" "${DOCKER_USERNAME}/httpie:${VERSION}"
docker tag "${DOCKER_USERNAME}/httpie:latest" "${DOCKER_USERNAME}/httpie:master"
