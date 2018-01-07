FROM ubuntu:16.04
MAINTAINER Hsin Hsuan Yu <hsinhsuanyu@gmail.com>

RUN echo "root:1234" | chpasswd

RUN useradd -m fresh
RUN echo "fresh:1234" | chpasswd

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y vim \
    build-essential

WORKDIR /home/fresh
USER fresh

VOLUME /home/fresh/shared


