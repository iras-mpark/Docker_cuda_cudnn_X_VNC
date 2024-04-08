########################################################
# CUDA 11.1 ON UBUNTU 22.04
########################################################
FROM ubuntu:22.04
LABEL maintainer="Minkyu Park <mpark@changwon.ac.kr>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y build-essential libxml2
RUN apt install -y python3-pip

ENV HOME /root

# installing X and xvfb so we can SEE the action using a remote desktop access
RUN apt-get update && \
    apt-get install -y net-tools \
    nano \
    x11-apps \
    xvfb \
    fluxbox \
    wmctrl \
    xterm && \
    apt-get clean

RUN rm /etc/apt/apt.conf.d/docker-clean
RUN apt update -y


WORKDIR /root
