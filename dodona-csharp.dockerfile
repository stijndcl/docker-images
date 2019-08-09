FROM mono:6.0.0

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "--no-install-recommends", "jshon"]
RUN ["apt-get", "-y", "install", "--no-install-recommends", "time"]
RUN ["apt-get", "clean"]
RUN ["rm", "-rf", "/var/lib/apt/lists/*"]

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN ["chmod", "711", "/mnt"]

# Add the user which will run the student's code and the judge.
RUN ["useradd", "-m", "runner"]

# As the runner user
USER runner
RUN ["mkdir", "/home/runner/workdir"]

WORKDIR /home/runner/workdir
COPY main.sh /main.sh