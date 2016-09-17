FROM ubuntu:14.04
MAINTAINER Hsin Hsuan Yu <hsinhsuanyu@gmail.com>
RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install vim
