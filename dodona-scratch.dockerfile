FROM buildkite/puppeteer:v1.15.0

RUN chmod 711 /mnt && \
    groupmod -n runner node && \
    usermod -l runner -d /home/runner node && \
    mkdir /home/runner/workdir && \
    chown -R runner:runner /home/runner && \
    chown -R runner:runner /mnt && \
    npm install -g fs

ENV NODE_PATH="/usr/local/lib/node_modules"
USER runner
WORKDIR /home/runner/workdir

COPY main.sh /main.sh
