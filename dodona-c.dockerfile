FROM python:3.8.3-slim-buster

RUN ["apt-get", "update"]
RUN apt-get install -y jshon=20131010-3+b1 \
                       libgtest-dev=1.8.1-3 \ 
                       g++=4:8.3.0-1 \
                       cmake=3.13.4-1

RUN ["apt-get", "clean"]

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN ["chmod", "711", "/mnt"]

# Add the user which will run the student's code and the judge.
RUN ["useradd", "-m", "runner"]

# https://gist.github.com/Cartexius/4c437c084d6e388288201aadf9c8cdd5
WORKDIR /usr/src/gtest
RUN ["cmake", "CMakeLists.txt"]
RUN ["make"]
RUN cp *.a /usr/lib
RUN ["mkdir", "/usr/local/lib/gtest"]
RUN ["ln", "-s", "/usr/lib/libgtest.a", "/usr/local/lib/gtest/libgtest.a"]
RUN ["ln", "-s", "/usr/lib/libgtest_main.a", "/usr/local/lib/gtest/libgtest_main.a"]

# As the runner user
USER runner
RUN ["mkdir", "/home/runner/workdir"]
WORKDIR /home/runner/workdir

COPY main.sh /main.sh
