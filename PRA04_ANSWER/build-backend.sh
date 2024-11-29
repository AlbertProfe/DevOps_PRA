#!/bin/bash

while IFS== read -r key value; do
    printf -v "$key" %s "$value" && export "$key"
done <.env

docker build \
    --tag pra04/backend-books:1.0 \
    --file backend.Dockerfile \
    --build-arg springFolder="${SPRING_DIR}" \
    --build-arg springJar="${SPRING_JAR}" \
    .