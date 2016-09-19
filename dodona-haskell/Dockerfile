FROM haskell:7

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "jq"]

RUN ["chmod", "711", "/mnt"]
RUN ["useradd", "runner"]
RUN ["mkdir", "/home/runner"]
RUN ["chown", "runner", "/home/runner"]
RUN ["chmod", "700", "/home/runner"]

USER runner
RUN ["cabal", "update"]
RUN ["cabal", "install", "quickcheck"]
RUN ["cabal", "install", "hunit"]
RUN ["cabal", "install", "missingh"]
USER root

RUN ["mv", "/home/runner/.cabal", "/"]

COPY main.sh /main.sh

