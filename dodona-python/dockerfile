FROM python:3.5.2

RUN ["chmod", "711", "/mnt"]

RUN ["useradd", "runner"]

RUN ["pip", "install", "pylint"]
RUN ["pip", "install", "jsonschema"]

COPY main.sh /main.sh
COPY logger.sh /logger.sh
