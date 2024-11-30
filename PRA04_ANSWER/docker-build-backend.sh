#!/bin/bash

ENV_VARS_TO_LOAD=$(bash util/clean-env-file.sh .env)
if [ $? -ne 0 ]; then
    exit 1
fi
if [ -z "$ENV_VARS_TO_LOAD" ]; then
    echo ".env file has no var defined!"
    exit 1
fi
while IFS== read -r key value; do
    printf -v "$key" %s "$value" && export "$key"
done <<< "${ENV_VARS_TO_LOAD}"

docker build \
    --tag ${SPRING_TAG}":${SPRING_VER}" \
    --file backend.Dockerfile \
    --build-arg MAINTAINER="${MAINTAINER}" \
    --build-arg SPRING_DIR="${SPRING_DIR}" \
    --build-arg SPRING_JAR="${SPRING_JAR}" \
    --build-arg SPRING_PORT="${SPRING_PORT}" \
    .