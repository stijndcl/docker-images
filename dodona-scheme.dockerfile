FROM racket/racket:8.1

MAINTAINER dirk@dinf.vub.ac.be

# add generic tools
RUN apt-get update \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# add a unit testing framework
RUN raco pkg install -i --auto --binary-lib --no-cache rackunit

# follow dodona conventions
RUN chmod 711 /mnt \
    && useradd -m runner \
    && mkdir /home/runner/workdir \
    && chown runner:runner /home/runner/workdir
USER runner
WORKDIR /home/runner/workdir
COPY main.sh /main.sh
