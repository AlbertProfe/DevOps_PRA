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
    --tag pra04/frontend-books:1.0 \
    --file fronted.Dockerfile \
    --build-arg REACT_DIR="${REACT_DIR}" \
    --build-arg REACT_PORT="${REACT_PORT}" \
    --progress plain \
     .