FROM node:13.0.1-buster-slim

RUN chmod 711 /mnt && \
    groupmod -n runner node && \
    usermod -l runner -d /home/runner node && \
    mkdir /home/runner/workdir && \
    chown -R runner:runner /home/runner && \
    chown -R runner:runner /mnt && \
    npm install -g fs deep-equal eslint --save-dev

ENV NODE_PATH="/usr/local/lib/node_modules"
USER runner
WORKDIR /home/runner/workdir

COPY main.sh /main.sh
