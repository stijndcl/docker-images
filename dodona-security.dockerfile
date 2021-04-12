FROM alpine:3.13.4

RUN apk add --no-cache yarn=1.22.10-r0 shadow=4.8.1-r0 \
                       jq=1.6-r1 bash=5.1.0-r0 curl=7.74.0-r1 sed=4.8-r0 \
                       python3=3.8.8-r0 \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && chmod 711 /mnt \
    && adduser -D runner

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN curl -L https://github.com/sqlmapproject/sqlmap/archive/1.4.tar.gz \
        | tar xz --directory /usr/local/share/ \
    && mv /usr/local/share/sqlmap-1.4 /usr/local/share/sqlmap \
    && ln -sf /usr/local/share/sqlmap/sqlmap.py /usr/local/bin/sqlmap

USER runner
RUN mkdir /home/runner/workdir

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
