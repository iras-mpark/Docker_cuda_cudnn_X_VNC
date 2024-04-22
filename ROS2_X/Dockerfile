########################################################
# CUDA 11.1 ON UBUNTU 22.04
########################################################
FROM ubuntu:22.04
LABEL maintainer="Minkyu Park <mpark@changwon.ac.kr>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y build-essential libxml2 git gedit
RUN apt install -y python3-pip

ENV HOME /root
# installing ROS2
RUN apt update && apt -y upgrade && \
    apt install locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

RUN apt install -y software-properties-common && \
    add-apt-repository universe && \
    apt update && apt install -y curl && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt update && apt upgrade && \
    apt install ros-humble-desktop

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && source ~/.bashrc

RUN apt install ros-humble-gazebo-ros-pkgs python3-rosdep && \
    rosdep init && rosdep update && \
    apt install python3-colcon-common-extensions ros-humble-xacro


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
