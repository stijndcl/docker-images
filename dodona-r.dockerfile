FROM r-base:4.0.3

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN apt-get update && \
  apt-get install -y --no-install-recommends procps=2:3.3.16-5 libcurl4-openssl-dev=7.72.0-1 libssl-dev=1.1.1h-1 libxml2-dev=2.9.10+dfsg-6.3 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 711 /mnt && \
  groupmod -n runner docker && \
  usermod -l runner -d /home/runner docker && \
  mkdir -p /home/runner/workdir && \
  chown -R runner:runner /home/runner && \
  chown -R runner:runner /mnt && \
  Rscript -e "install.packages(c( \
        'GGally' \
      , 'HistData' \
      , 'ISLR' \
      , 'MASS' \
      , 'NHANES' \
      , 'R6' \
      , 'RColorBrewer' \
      , 'base64enc' \
      , 'car' \
      , 'coin' \
      , 'dplyr' \
      , 'dslabs' \
      , 'ggplot2' \
      , 'ggrepel' \
      , 'ggridges' \
      , 'ggthemes' \
      , 'glmnet' \
      , 'gridExtra' \
      , 'jsonlite' \
      , 'kableExtra' \
      , 'leaps' \
      , 'multcomp' \
      , 'plotrix' \
      , 'pls' \
      , 'scales' \
      , 'scatterplot3d' \
      , 'tidyverse' \
    ))"


USER runner

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
