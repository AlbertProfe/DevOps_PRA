#!/bin/bash

# Check if the commit message is provided
if [ -z "$1" ]; then
  echo "Please provide a commit message."
  exit 1
fi

# Commit the changes with the provided message
git add .
git commit -m "$1"

# Push the changes to the correct branch (MF03-PRA3-AlexCano)
git push origin MF03-PRA3-AlexCano

# Go to the 'mi-practica-quarto' folder where the Quarto project is located
cd mi-practica-quarto

# Publish to GitHub Pages using quarto
quarto publish gh-pages --no-prompt

# Log the message to a log file
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}
