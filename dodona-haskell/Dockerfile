FROM haskell:7

# Install jq for json querying in bash
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "jq"]

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN ["chmod", "711", "/mnt"]

# Add the user which will run the student's code and the judge.
RUN ["useradd", "-m", "runner"]

# As the runner user
WORKDIR /home/runner
USER runner

    # Install the cabal packages
    RUN ["cabal", "update"]
    RUN ["cabal", "install", "quickcheck"]
    RUN ["cabal", "install", "hunit"]
    RUN ["cabal", "install", "missingh"]

    # Create the working directory
    RUN ["mkdir", "workdir"]

USER root
WORKDIR /

COPY main.sh /main.sh

