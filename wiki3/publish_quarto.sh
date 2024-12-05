#!/bin/bash

log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}

# Check if the commit message is provided
if [ -z "$1" ]; then
  echo "Please provide a commit message."
  exit 1
fi

# Commit the changes with the provided message
git add .
git commit -m "$1"

# Push the changes to the main branch
git push origin main

# Publish to GitHub Pages using quarto
quarto publish gh-pages --no-render --no-prompt
