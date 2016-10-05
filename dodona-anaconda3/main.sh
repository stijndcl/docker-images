#!/bin/bash

# process arguments
RUNNER_SCRIPT=$1
LOG_PATH=$2

# start memory footprint logging
/logger.sh "$LOG_PATH" &
LOGGER_PID=$!

# prepare the homedir with the workdir files and check it out
config="$(cat)"
homedir="/home/runner"
workdir="$(jshon -e 'workdir' -u <<<"$config")"
su runner -c "cp -r '$workdir' '$homedir'"
cd "$homedir"

# switch to user "runner" and start the script
su runner -c "PATH='$PATH' ${RUNNER_SCRIPT}" <<<"$config"

# it's the exit status of the runner script that we want to return
STATUS=$?

# stop memory footprint logging
kill ${LOGGER_PID}

# return the runner script's exit status
exit $STATUS
