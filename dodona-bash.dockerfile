FROM continuumio/anaconda3

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "zip"]
RUN ["apt-get", "-y", "install", "unzip"]
RUN ["apt-get", "-y", "install", "bc"]
RUN ["apt-get", "-y", "install", "cowsay"]
RUN ["apt-get", "-y", "install", "fortune-mod"]
RUN ["apt-get", "-y", "install", "figlet"]
RUN ["apt-get", "-y", "install", "toilet"]
RUN ["apt-get", "-y", "install", "ed"]

# imagemagick
RUN ["apt-get", "-y", "install", "build-essential"]
RUN ["apt-get", "-y", "install", "checkinstall"]
RUN ["sed", "-i", "p;s/deb/deb-src/", "/etc/apt/sources.list"]
RUN ["cat", "/etc/apt/sources.list"]
RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "build-dep", "imagemagick"]
WORKDIR /tmp
RUN ["wget", "http://www.imagemagick.org/download/ImageMagick-7.0.7-8.tar.gz"]
RUN ["tar", "xzvf", "ImageMagick-7.0.7-8.tar.gz"]
WORKDIR ImageMagick-7.0.7-8
RUN ["./configure", "--prefix=/usr", "--with-rsvg=yes"]
RUN ["make"]
RUN ["make", "install"]

RUN ["apt-get", "-y", "install", "vim"]
WORKDIR /

ENV PATH="/home/runner/workdir:/usr/games:${PATH}"

RUN ["chmod", "711", "/mnt"]

RUN ["useradd", "-m", "runner"]

USER runner
RUN ["mkdir", "/home/runner/workdir"]
USER root

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
COPY logger.sh /logger.sh
