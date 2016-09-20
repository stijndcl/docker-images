#!/bin/sh 

# process arguments
RUNNER_SCRIPT=$1
SECRET_PATH=$2

# make secret path read-only
# TODO: only directories should have execute permission set (not the regular files)
chmod -R 555 "${SECRET_PATH}" 2> /dev/null

# create home directory for user "runner"
chown runner /home/runner
chmod 700 /home/runner
mv /.cabal /home/runner
mv /.ghc /home/runner

# make ~runner the current directory
cd /home/runner

# switch to user "runner" and start the script
su runner -c "PATH='$PATH' ${RUNNER_SCRIPT}" <&0

# it's the exit status of the runner script that we want to return
STATUS=$?

# return the runner script's exit status
exit $STATUS
