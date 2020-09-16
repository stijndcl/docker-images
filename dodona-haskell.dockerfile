FROM haskell:8.8.4

RUN apt-get update \
 # Install jq for json querying in bash
 # Install freeglut headers for gloss compilation
 && apt-get install -y --no-install-recommends \
        jshon=20131010-3+b1 \
        freeglut3-dev=2.8.1-3 \
 && rm -rf /var/lib/apt/lists/* \
 # Make sure the students can't find our secret path, which is mounted in
 # /mnt with a secure random name.
 && chmod 711 /mnt \
 # Add the user which will run the student's code and the judge.
 && useradd -m runner

# As the runner user
WORKDIR /home/runner
USER runner
RUN \
 # happy must be installed to install haskell-src-exts
    stack --system-ghc --no-install-ghc --resolver=lts-16.14 install happy \
 && stack --system-ghc --no-install-ghc --resolver=lts-16.14 install hlint \
        QuickCheck \
        HUnit \
        MissingH \
        stm \
        gloss \
 # Clearing package cache
 && rm -rf /home/runner/.cabal/packages/* \
 # Create the working directory
 && mkdir workdir

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
