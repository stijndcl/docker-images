FROM python:3.8.0-alpine

RUN chmod 711 /mnt && \
  adduser -D runner && \
  apk --no-cache add gcc==8.3.0-r0 g++==8.3.0-r0 fontconfig==2.13.1-r0 && \
  # Judge dependencies
  pip install --upgrade pylint==2.4.2 jsonschema==3.1.1 pyshp==2.1.0 && \
  # Exercise dependencies
  pip install --upgrade numpy==1.17.2 && \
  fc-cache -f && \
  apk del gcc g++ && \
  mkdir -p /home/runner/workdir && \
  chown -R runner:runner /home/runner && \
  chown -R runner:runner /mnt

USER runner
WORKDIR /home/runner/workdir
COPY main.sh /main.sh
