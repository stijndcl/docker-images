FROM continuumio/anaconda3

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "zip"]
RUN ["apt-get", "-y", "install", "unzip"]
RUN ["apt-get", "-y", "install", "bc"]
RUN ["apt-get", "-y", "install", "cowsay"]
RUN ["apt-get", "-y", "install", "fortune-mod"]
RUN ["apt-get", "-y", "install", "figlet"]
RUN ["apt-get", "-y", "install", "toilet"]
RUN ["apt-get", "-y", "install", "imagemagick"]

ENV PATH="/usr/games:${PATH}"

RUN ["chmod", "711", "/mnt"]

RUN ["useradd", "-m", "runner"]

USER runner
RUN ["mkdir", "/home/runner/workdir"]
USER root

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
COPY logger.sh /logger.sh
