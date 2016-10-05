#!/bin/bash

# process arguments
RUNNER_SCRIPT=$1

# prepare the homedir with the workdir files and check it out
config="$(cat)"
homedir="/home/runner"
workdir="$(jshon -e 'workdir' -u <<<"$config")"
su runner -c "cp -r '$workdir' '$homedir'"
cd "$homedir"

# switch to user "runner" and start the script
# the exec code to this script is the exit code of the runner script
su runner -c "PATH='$PATH' ${RUNNER_SCRIPT}" <<<"$config"
