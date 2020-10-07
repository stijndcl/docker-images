FROM python:3.8-buster

# Environment Kotlin
ENV SDKMAN_DIR /usr/local/sdkman
ENV PATH $SDKMAN_DIR/candidates/kotlin/current/bin:$PATH

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
       # TESTed Java and Kotlin judge dependency
       default-jdk \
       # TESTed Haskell judge dependency
       haskell-platform \
       # TESTed C judge dependency
       gcc-8 \
       # TESTed Javascript judge dependency
       nodejs \
       # Additional dependencies
       dos2unix \
       curl \
       zip \
       unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 # TESTed Judge depencencies
 && pip install jsonschema psutil mako pydantic==1.4 toml typing_inspect pylint \
 # TESTed Kotlin judge dependencies
 && curl -s "https://get.sdkman.io?rcupdate=false" | bash \
 && chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh" \
 && bash -c "source \"$SDKMAN_DIR/bin/sdkman-init.sh\" && sdk install kotlin" \
 # Haskell dependencies
 && cabal update \
 && cabal install aeson --global --force-reinstalls \
 # Make sure the students can't find our secret path, which is mounted in
 # /mnt with a secure random name.
 && chmod 711 /mnt \
 # Add the user which will run the student's code and the judge.
 && useradd -m runner \
 && mkdir /home/runner/workdir \
 && chown -R runner:runner /home/runner/workdir

USER runner
WORKDIR /home/runner/workdir

COPY main.sh /main.sh

