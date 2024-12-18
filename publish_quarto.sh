#!/bin/bash

# Function to create and log messages with timestamp
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    # Specify the absolute path to your log.txt file
    local log_file="/home/emma/MyProjects/IntroDevOps/Quarto/DevOps_PRA/log.txt"
    
    # Create log.txt if it doesn't exist
    if [ ! -f "$log_file" ]; then
        touch "$log_file"
    fi
    
    echo "[${timestamp}] ${message}" >> "$log_file"
}

# Check if the commit message is provided
if [ -z "$1" ]; then
  echo "Please provide a commit message."
  log_message "Error: Commit message not provided."
  exit 1
fi

# Commit the changes with the provided message
git add .
if [ $? -ne 0 ]; then
  log_message "Error: git add failed."
  exit 1
fi

git commit -m "$1"
if [ $? -ne 0 ]; then
  log_message "Error: git commit failed."
  exit 1
fi

# Log the commit message to the log file
log_message "Committed changes with message: $1"

# Push the changes to the PRA03 branch
git push origin MF03-PRA03-EmmaAlonsoMcCoy
if [ $? -ne 0 ]; then
  log_message "Error: git push failed."
  exit 1
fi
log_message "Successfully pushed changes to MF03-PRA03-EmmaAlonsoMcCoy."

# Go to the project directory
cd my-quarto-site || { log_message "Error: cd my-quarto-site failed."; exit 1; }

# Publish to GitHub Pages using Quarto
quarto publish gh-pages --no-render --no-prompt
if [ $? -ne 0 ]; then
  log_message "Error: Quarto publish failed."
  exit 1
fi
log_message "Successfully published to GitHub Pages."

log_message "Script execution completed successfully."
