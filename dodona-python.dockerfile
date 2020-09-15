FROM python:3.8.5-slim-buster

RUN chmod 711 /mnt && \
  useradd -m runner && \
  apt-get update && \
  apt-get -y install --no-install-recommends \
     emboss=6.6.0+dfsg-7+b1 \
     gcc=4:8.3.0-1 \
     g++=4:8.3.0-1 \
     fontconfig=2.13.1-2 \
     libc6-dev=2.28-10 \
     make=4.2.1-1.2 \
     wget=1.20.1-1.1 \
     zlib1g-dev=1:1.2.11.dfsg-1 && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean && \
  # Judge dependencies
  pip install --upgrade pylint==2.4.2 jsonschema==3.1.1 pyshp==2.1.0 psutil==5.7.0 mako==1.1.2 pydantic==1.4 pyhumps==1.3.1 typing_inspect==0.5.0 && \
  # Exercise dependencies
  pip install --upgrade numpy==1.17.2 biopython==1.74 sortedcontainers==2.1.0

WORKDIR /tmp

RUN wget http://faculty.virginia.edu/wrpearson/fasta/fasta3/fasta-36.3.8h.tar.gz && \
  tar xzf fasta-36.3.8h.tar.gz

WORKDIR /tmp/fasta-36.3.8h/src

RUN make -f ../make/Makefile.linux64 all && \
  sed -i "/XDIR/s#= .*#= /usr/bin#" ../make/Makefile.linux64 && \
  make -f ../make/Makefile.linux64 install

WORKDIR /tmp

RUN rm fasta-36.3.8h.tar.gz fasta-36.3.8h -r && \
  fc-cache -f && \
  apt-get -y purge --autoremove gcc g++ libc6-dev make wget zlib1g-dev && \
  mkdir -p /home/runner/workdir && \
  chown -R runner:runner /home/runner && \
  chown -R runner:runner /mnt

USER runner
WORKDIR /home/runner/workdir
COPY main.sh /main.sh
