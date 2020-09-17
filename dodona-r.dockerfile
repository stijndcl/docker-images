FROM r-base:4.0.2

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN apt-get update && \
  apt-get install -y --no-install-recommends procps=2:3.3.16-5 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 711 /mnt && \
  groupmod -n runner docker && \
  usermod -l runner -d /home/runner docker && \
  mkdir -p /home/runner/workdir && \
  chown -R runner:runner /home/runner && \
  chown -R runner:runner /mnt && \
  Rscript -e "install.packages('jsonlite')" && \
  Rscript -e "install.packages('base64enc')" && \
  Rscript -e "install.packages('R6')" && \
  Rscript -e "install.packages('GGally')" && \
  Rscript -e "install.packages('HistData')" && \
  Rscript -e "install.packages('NHANES')" && \
  Rscript -e "install.packages('RColorBrewer')" && \
  Rscript -e "install.packages('car')" && \
  Rscript -e "install.packages('coin')" && \
  Rscript -e "install.packages('dplyr')" && \
  Rscript -e "install.packages('dslabs')" && \
  Rscript -e "install.packages('ggplot2')" && \
  Rscript -e "install.packages('ggrepel')" && \
  Rscript -e "install.packages('ggridges')" && \
  Rscript -e "install.packages('ggthemes')" && \
  Rscript -e "install.packages('gridExtra')" && \
  Rscript -e "install.packages('kableExtra')" && \
  Rscript -e "install.packages('multcomp')" && \
  Rscript -e "install.packages('plotrix')" && \
  Rscript -e "install.packages('scales')" && \
  Rscript -e "install.packages('scatterplot3d')" && \
  Rscript -e "install.packages('tidyverse')" && \
  Rscript -e "install.packages('ISLR')" && \
  Rscript -e "install.packages('MASS')" && \
  Rscript -e "install.packages('glmnet')" && \
  Rscript -e "install.packages('leaps')" && \
  Rscript -e "install.packages('pls')"


USER runner

WORKDIR /home/runner/workdir
COPY main.sh /main.sh
