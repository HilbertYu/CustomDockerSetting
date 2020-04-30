FROM ubuntu:16.04
MAINTAINER Hsin Hsuan Yu <hsinhsuanyu@gmail.com>

RUN echo "root:1234" | chpasswd

RUN useradd -m fresh
RUN echo "fresh:1234" | chpasswd

ARG DEBIAN_FRONTEND=noninteractive 
RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    vim \
    locales \
    htop \
    build-essential \
    git g++ \
    openssh-server sudo tmux man \
    octave gnuplot-qt \
    exuberant-ctags \
    cscope \
    silversearcher-ag \
    valgrind \
    libxml2-dev \
    perl-tk \
    libdbi-perl \
    libc6:i386 libstdc++6:i386 \
    cmake \
    libncurses5-dev libncursesw5-dev \
    python-dev libxml2-dev libxslt-dev \
    python-pip

RUN mkdir -p /var/run/sshd

RUN echo "fresh ALL=(ALL:ALL) ALL " >> /etc/sudoers
RUN echo "X11UseLocalHost no" >> /etc/ssh/sshd_config
RUN locale-gen en_US.UTF-8


RUN chsh -s /bin/bash fresh

#RUN pip install scikit-learn pandoc

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /home/fresh
USER fresh

COPY ./install-dev.sh /tmp
RUN bash /tmp/install-dev.sh


VOLUME /home/fresh/shared


