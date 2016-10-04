#!/bin/bash

# process arguments
RUNNER_SCRIPT=$1

# Checkout the workdir
config="$(cat)"
cd "$(jshon -e 'workdir' -u <<<"$config")"

# switch to user "runner" and start the script
# the exec code to this script is the exit code of the runner script
su runner -c "PATH='$PATH' ${RUNNER_SCRIPT}" <<<"$config"
