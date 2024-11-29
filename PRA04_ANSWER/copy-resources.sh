#!/bin/bash


# SPRING BOOT RESOURCES
SPRING_DIR=BooksBackend
SPRING_JAR=springboot

mkdir -p "${SPRING_DIR}"
cp ../Resources/SpringBoot_projects/BooksPageable-0.0.4-SNAPSHOT.jar "${SPRING_DIR}"/"${SPRING_JAR}".jar

# REACT RESOURCES
REACT_DIR=BooksFrontend

mkdir -p "${REACT_DIR}"
tar -xvzf ../Resources/React_projects/dist.tar.gz  --strip-components 1 --directory "${REACT_DIR}"
