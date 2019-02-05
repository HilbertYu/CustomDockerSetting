FROM ubuntu:16.04
MAINTAINER Hsin Hsuan Yu <hsinhsuanyu@gmail.com>

RUN echo "root:1234" | chpasswd

RUN useradd -m fresh
RUN echo "fresh:1234" | chpasswd

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    locales \
    build-essential \
    git g++ \
    openssh-server sudo tmux man \
    octave gnuplot-qt \
    exuberant-ctags \
    cscope \
    silversearcher-ag \
    valgrind


ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /home/fresh
USER fresh

VOLUME /home/fresh/shared


