#!/bin/bash

LOG_DIR=logs

# check if log directory exists
if [ ! -d "${LOG_DIR}" ]; then
    # if not then we try to create it
    mkdir "${LOG_DIR}"
    if [ $? -ne 0 ] ; then
        echo "log directory '${LOG_DIR}' does not exist and can't be created."
        exit 1
    fi
fi

log_message() {
    local count=$(printf "%02d" ${COUNT})
    local type="$1"
    local message="$2"
    local timestamp=$(date +"%H:%M:%S")
    echo "${count}-[${timestamp}] ${type}: ${message}" | tee -a "${LOG_FILE}"
}

log_message_error() { 
    log_message "ERROR" "$1" 
}

log_message_ok() {
    log_message "OK" "$1"
}

LOG_FILE=${LOG_DIR}/$(date +"%Y-%m-%d").log
COUNT_FILE=${LOG_DIR}/count

# using a count for better track of different executions
# if log file don't exists => first execution
if [ ! -f "${LOG_FILE}" ]; then
    COUNT=0
    # reset count => Delete count file. No error if not exists
    rm -f -- $COUNT_FILE
else
    # read last value
    read COUNT < $COUNT_FILE 2>/dev/null
    # count file must exists because is not the first execution
    if [ $? -ne 0 ]; then
        COUNT=99
        log_message_error "Can't read count file '$COUNT_FILE'"
        exit 1
    fi
fi
# increment count by 1
(( COUNT++ ))
# write count to count file
echo "$COUNT" > $COUNT_FILE
if [ $? -ne 0 ]; then
    log_message_error "Can't write count to count file '$COUNT_FILE'"
    exit 1
fi

# separating executions in log file with an empty line
if [ "$COUNT" -gt 1 ]; then
    echo >> "${LOG_FILE}"
fi

# Check if the commit message is provided
if [ -z "$1" ]; then
    log_message_error "Please provide a commit message."
    exit 1
fi

# Check if the commit message is the only argument
if [ $# -gt 1 ]; then
    log_message_error "The only admited argument is the commit message."
    log_message_error "If the message is more than a word enclose it with double quotes: \""
    log_message_error "Arguments where '$*'"
    exit 1
fi

# log commit message
log_message "COMMIT MESSAGE" "$1"

# get current branch
BRANCH=$(git branch --show-current 2>/dev/null)
if [ $? -ne 0 ]; then
    log_message_error "git branch --show-current"
    exit 1
fi

# Check if there are some changes to save
# https://stackoverflow.com/questions/3878624/how-do-i-programmatically-determine-if-there-are-uncommitted-changes
GS=$(git status --porcelain=v1 2>/dev/null)
if [ $? -eq 128 ]; then
    log_message_error "There is no git repository in current folder."
    log_message_error "Current folder is: $(pwd)"
    exit 1
fi

if [ -z "${GS}" ]; then
    log_message "INFO" "There are no changes to commit."
    exit 0
fi

git add . 2>/dev/null
if [ $? -ne 0 ]; then
    log_message_error "git add ."
    exit 1
else
    log_message_ok "git add ."
fi

git commit -m "$1" 2>/dev/null
if [ $? -ne 0 ]; then
    log_message_error "git commit -m \"$1\""
    exit 1
else
    log_message_ok "git commit -m \"$1\""
fi

git push origin $BRANCH 2>/dev/null
if [ $? -ne 0 ]; then
    log_message_error "git push origin $BRANCH"
    exit 1
else
    log_message_ok "git push origin $BRANCH"
fi

quarto publish gh-pages --no-prompt 2>/dev/null
if [ $? -ne 0 ]; then
    log_message_error "quarto publish gh-pages --no-prompt"
    exit 1
else
    log_message_ok "quarto publish gh-pages --no-prompt"
fi

exit 0
