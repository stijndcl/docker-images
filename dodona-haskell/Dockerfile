FROM haskell:7

RUN ["chmod", "711", "/mnt"]
RUN ["useradd", "runner"]

RUN ["cabal", "update"]
RUN ["cabal", "install", "quickcheck"]
RUN ["cabal", "install", "hunit"]

COPY main.sh /main.sh

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "jq"]
