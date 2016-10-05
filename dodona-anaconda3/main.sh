#!/bin/bash

# process arguments
RUNNER_SCRIPT=$1
LOG_PATH=$2

# make ~runner the current directory
cd /home/runner

# start memory footprint logging
/logger.sh "$LOG_PATH" &
LOGGER_PID=$!

# checkout the working directory
config="$(cat)"
cd "$(jshon -e 'workdir' -u <<<"$config")"

# switch to user "runner" and start the script
su runner -c "PATH='$PATH' ${RUNNER_SCRIPT}" <<<"$config"
#${RUNNER_SCRIPT} <&0

# it's the exit status of the runner script that we want to return
STATUS=$?

#echo 'done with judge'

# stop memory footprint logging
kill ${LOGGER_PID}

# return the runner script's exit status
exit $STATUS
