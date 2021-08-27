FROM python:3.9.6-slim-buster

RUN apt-get update && \
    # install procps, otherwise pkill cannot be not found
    apt-get -y install --no-install-recommends \
        procps=2:3.3.15-2 \
        sqlite3=3.27.2-3+deb10u1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# apply Dodona defaults
RUN chmod 711 /mnt && \
    useradd -m runner && \
    mkdir -p /home/runner/workdir && \
    chown -R runner:runner /home/runner && \
    chown -R runner:runner /mnt

RUN pip install --no-cache-dir --upgrade \
    pandas==1.1.4 \
    sqlparse==0.4.1

USER runner
WORKDIR /home/runner/workdir
COPY main.sh /main.sh
