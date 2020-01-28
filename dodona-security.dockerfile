FROM alpine

RUN apk add --no-cache nodejs yarn shadow jq bash curl sed \
    && chmod 711 /mnt \
    && adduser -D runner

RUN apk add --no-cache git python \
    && git clone https://github.com/sqlmapproject/sqlmap.git /usr/local/share/sqlmap \
    && ln -sf /usr/local/share/sqlmap/sqlmap.py /usr/local/bin/sqlmap

USER runner
RUN mkdir /home/runner/workdir

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
