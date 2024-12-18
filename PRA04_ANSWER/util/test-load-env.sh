#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ENV_VARS_TO_LOAD=$(bash "${SCRIPT_DIR}"/clean-env-file.sh "${SCRIPT_DIR}"/../.env)
if [ $? -ne 0 ]; then
    exit 1
fi
if [ -z "$ENV_VARS_TO_LOAD" ]; then
    echo ".env file has no variable defined!"
    exit 1
fi
while IFS== read -r key value; do
    printf -v "$key" %s "$value" && export "$key"
    echo "loaded '${key}' with value '${value}'"
done <<< "${ENV_VARS_TO_LOAD}"



