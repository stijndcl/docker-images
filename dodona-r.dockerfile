FROM r-base:4.1.1

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN apt-get update && \
  apt-get install -y --no-install-recommends procps=2:3.3.17-5 libcurl4-openssl-dev=7.74.0-1.3+b1 libssl-dev=1.1.1l-1 libxml2-dev=2.9.10+dfsg-6.7 && \
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
      , 'ISLR2' \
      , 'MASS' \
      , 'NHANES' \
      , 'R6' \
      , 'RColorBrewer' \
      , 'ROCR' \
      , 'base64enc' \
      , 'car' \
      , 'coin' \
      , 'coxed' \
      , 'dplyr' \
      , 'dslabs' \
      , 'e1071' \
      , 'gam' \
      , 'gbm' \
      , 'ggplot2' \
      , 'ggplotify' \
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
      , 'survival' \
      , 'tidyverse' \
      , 'tree' \
    ))"


USER runner

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
