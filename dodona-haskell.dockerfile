FROM haskell:8.2

# Install jq for json querying in bash
RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "jshon"]
RUN ["apt-get", "-y", "install", "freeglut3-dev"]

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
    RUN ["cabal", "install", "happy-1.19.9"]
    RUN ["cabal", "install", "hlint-2.1.10"]
    RUN ["cabal", "install", "QuickCheck-2.10.1"]
    RUN ["cabal", "install", "HUnit-1.6.0.0"]
    RUN ["cabal", "install", "MissingH-1.4.0.1"]
    RUN ["cabal", "install", "json-builder-0.3"]
    RUN ["cabal", "install", "stm-2.4.5.0"]
    RUN ["cabal", "install", "gloss-1.13.0.1"]

    # Create the working directory
    RUN ["mkdir", "workdir"]

USER root

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
