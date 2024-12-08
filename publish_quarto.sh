#!/bin/bash

# Function to log messages with a timestamp
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}

# Check if the commit message is provided
if [ -z "$1" ]; then
  log_message "Error: No commit message provided."
  echo "Please provide a commit message."
  exit 1
fi

# Define the Quarto project path (change this to your project directory)
QUARTO_PROJECT_PATH="DevOps_PRA"

# Check if the project path exists
if [ ! -d "$QUARTO_PROJECT_PATH" ]; then
  log_message "Error: Quarto project directory does not exist: $QUARTO_PROJECT_PATH"
  echo "Error: Quarto project directory does not exist: $QUARTO_PROJECT_PATH"
  exit 1
fi

# Navigate to the Quarto project directory
cd "$QUARTO_PROJECT_PATH" || exit

# Log navigation success
log_message "Navigated to project directory: $QUARTO_PROJECT_PATH"

# Commit the changes with the provided message
git add .
if git commit -m "$1"; then
  log_message "Commit successful with message: $1"
else
  log_message "Commit failed."
  exit 1
fi

# Push the changes to the main branch
if git push origin branchPR03; then
  log_message "Pushed changes to branchPR03."
else
  log_message "Push to branchPR03 failed."
  exit 1
fi

# Publish to GitHub Pages using Quarto
if quarto publish gh-pages --no-prompt; then
  log_message "Published to GitHub Pages successfully."
else
  log_message "Publishing to GitHub Pages failed."
  exit 1
fi

