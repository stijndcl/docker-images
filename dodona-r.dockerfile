FROM r-base:4.0.4

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN apt-get update && \
  apt-get install -y --no-install-recommends procps=2:3.3.17-4 libcurl4-openssl-dev=7.74.0-1.1 libssl-dev=1.1.1k-1 libxml2-dev=2.9.10+dfsg-6.3+b1 && \
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
      , 'ROCR' \
      , 'base64enc' \
      , 'car' \
      , 'coin' \
      , 'dplyr' \
      , 'dslabs' \
      , 'e1071' \
      , 'gam' \
      , 'gbm' \
      , 'ggplot2' \
      , 'ggrepel' \
      , 'ggridges' \
      , 'ggthemes' \
      , 'glmnet' \
      , 'gridBase' \
      , 'gridGraphics' \
      , 'gridExtra' \
      , 'jsonlite' \
      , 'kableExtra' \
      , 'lattice' \
      , 'latticeExtra' \
      , 'leaps' \
      , 'multcomp' \
      , 'plotrix' \
      , 'pls' \
      , 'randomForest' \
      , 'scales' \
      , 'scatterplot3d' \
      , 'sp' \
      , 'tidyverse' \
      , 'tree' \
    ))"


USER runner

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
