FROM r-base:latest

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN apt-get update && \
  apt-get install -y --no-install-recommends procps>=3.3.15 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 711 /mnt && \
  groupmod -n runner docker && \
  usermod -l runner -d /home/runner docker && \
  mkdir -p /home/runner/workdir && \
  chown -R runner:runner /home/runner && \
  chown -R runner:runner /mnt && \
  Rscript -e "install.packages('jsonlite')" && \
  Rscript -e "install.packages('R6')"

WORKDIR /home/runner/workdir
COPY main.sh /main.sh

