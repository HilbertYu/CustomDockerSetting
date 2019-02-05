FROM ubuntu:16.04
MAINTAINER Hsin Hsuan Yu <hsinhsuanyu@gmail.com>

RUN echo "root:1234" | chpasswd

RUN useradd -m fresh
RUN echo "fresh:1234" | chpasswd

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    build-essential \
    git g++ \
    openssh-server sudo tmux man \
    octave gnuplot-qt

RUN apt-get install -y \
       exuberant-ctags \
       cscope \
       silversearcher-ag

WORKDIR /home/fresh
USER fresh

VOLUME /home/fresh/shared


