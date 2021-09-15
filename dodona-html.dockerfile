FROM python:3.9.7-slim-buster

RUN apt-get update && \
    # install procps, otherwise pkill cannot be not found
    apt-get -y install --no-install-recommends \
        procps=2:3.3.15-2 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    chmod 711 /mnt && \
    useradd -m runner && \
    mkdir -p /home/runner/workdir && \
    chown -R runner:runner /home/runner && \
    chown -R runner:runner /mnt && \
    pip install --no-cache-dir --upgrade beautifulsoup4==4.10.0

USER runner
WORKDIR /home/runner/workdir
COPY main.sh /main.sh
