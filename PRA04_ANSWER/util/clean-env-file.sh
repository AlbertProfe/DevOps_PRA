#!/bin/bash

# Check if there is a file as an argument
if [ -z "$1" ]; then
    echo "Please provide a file"
    exit 1
fi

# Only one file
if [ $# -gt 1 ]; then
    echo "Only one file is admited as argument"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "$1 don't exists"
    exit 1
fi

remove_comments() {
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    sed -f "${SCRIPT_DIR}"/remove-comments.sed
}

remove_empty_lines() {
    sed '/^[[:blank:]]*$/d'
}

trim() {
    sed 's/^ *//;s/ *$//'
}

cat $1 | remove_comments | trim | remove_empty_lines