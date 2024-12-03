#!/bin/bash

# Function to log messages to a log file
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}

# Check if a commit message was provided
if [ -z "$1" ]; then
  echo "Error: Please provide a commit message."
  log_message "Error: No commit message provided."
  exit 1
fi

# Log the start of the script
log_message "Script started: committing with message '$1'."

# Stage all changes
git add .
if [ $? -ne 0 ]; then
    log_message "Error executing 'git add'."
    exit 1
fi

# Commit the changes with the provided message
git commit -m "$1"
if [ $? -ne 0 ]; then
    log_message "Error executing 'git commit'."
    exit 1
fi
log_message "Commit completed successfully."

# Push changes to the main branch
git push origin MF01-PRA03-AlberteMartinez
if [ $? -ne 0 ]; then
    log_message "Error executing 'git push'."
    exit 1
fi
log_message "Push to 'main' branch completed successfully."

# Publish to GitHub Pages using Quarto
quarto publish gh-pages --no-render --no-prompt
if [ $? -ne 0 ]; then
    log_message "Error publishing with Quarto."
    exit 1
fi
log_message "Publication to GitHub Pages completed successfully."

# End of the script
log_message "Script finished."
