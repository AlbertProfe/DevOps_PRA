#!/bin/bash

# Get current date for log file name
log_date=$(date '+%Y-%m-%d')
log_file="log_${log_date}.txt"

# Function to log messages
log_message() {
    local message="$(date '+%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$log_file"
}

# Check if the commit message is provided
if [ -z "$1" ]; then
    log_message "Error: Please provide a commit message."
    exit 1
fi

# Start logging
log_message "Starting Quarto publishing process"

# Commit the changes with the provided message
git add .
git commit -m "$1"
if [ $? -eq 0 ]; then
    log_message "Changes committed successfully"
else
    log_message "Error: Git commit failed"
    exit 1
fi

# Push the changes to the main branch
git push origin main
if [ $? -eq 0 ]; then
    log_message "Changes pushed to remote repository"
else
    log_message "Error: Git push failed"
    exit 1
fi

# Publish to GitHub Pages using quarto
quarto publish gh-pages --no-render --no-prompt
if [ $? -eq 0 ]; then
    log_message "Quarto site published successfully"
else
    log_message "Error: Quarto publish failed"
    exit 1
fi

log_message "Quarto publishing process completed successfully"

# Prompt user before exiting
while true; do
    read -p "Do you want to exit the script? (y/n): " choice
    case "$choice" in 
        y|Y ) 
            log_message "Process completed. Check $log_file for details."
            exit 0;;
        n|N ) 
            log_message "Continuing with the script..."
            # You can add more actions here if needed.
            break;;
        * ) 
            echo "Invalid input. Please enter 'y' or 'n'.";;
    esac
done
