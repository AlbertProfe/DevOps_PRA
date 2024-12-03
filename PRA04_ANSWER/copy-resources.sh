#!/bin/bash

# Load .env
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

# create backend dir
if [ -d "${SPRING_DIR_DESTINATION}" ]; then
    rm -rf "${SPRING_DIR_DESTINATION}"
fi
mkdir -p "${SPRING_DIR_DESTINATION}"
# copy content to backend
cp "${SPRING_DIR_ORIGIN}"/"${SPRING_JAR}" "${SPRING_DIR_DESTINATION}"/"${SPRING_JAR}"
echo "Backend resources copied to ${SPRING_DIR_DESTINATION}"

# create frontend dir
if [ -d "${REACT_DIR_DESTINATION}" ]; then
    rm -rf "${REACT_DIR_DESTINATION}"
fi
mkdir -p "${REACT_DIR_DESTINATION}"
# copy frontend to backend
tar -xzf "${REACT_TAR_GZ}" --strip-components 1 --directory "${REACT_DIR_DESTINATION}"
echo "Frontend resources copied to ${REACT_DIR_DESTINATION}"

