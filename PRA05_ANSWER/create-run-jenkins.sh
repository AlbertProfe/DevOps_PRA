#!/bin/bash

# name of Jenkins container
NAME=jenkins

# save current dir
DIR=$(pwd)

if [ $( docker ps -a -f name="${NAME}" 2> /dev/null | wc -l ) -eq 2 ]; then
    echo "${NAME} container already exists"
else
    # script dir is the location of this script
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    # jenkins home is in this same folder
    DIR_HOME="${SCRIPT_DIR}"/jenkins_home
    docker run -d -p 9090:8080 -p 50000:50000 \
        -v "${DIR_HOME}":/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        --privileged \
        --name "${NAME}" \
        jenkins/jenkins:latest
    echo "${NAME} created and running"
    echo "Jenkins home directory is: ${DIR_HOME}"
fi

if [ "$(docker inspect -f '{{.State.Status}}' "${NAME}" 2>/dev/null)" = "running" ]; then 
    echo "${NAME} container is already running"
else
    docker start "${NAME}"
    echo "${NAME} container started"
fi

# go to saved location
cd "${DIR}"
