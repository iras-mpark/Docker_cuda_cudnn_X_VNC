########################################################
# CUDA 12.2 + CUDNN 8.9.4 ON UBUNTU 22.04
########################################################
FROM ubuntu:22.04
LABEL maintainer="Minkyu Park <mpark@changwon.ac.kr>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y build-essential libxml2 git gedit
RUN apt install -y python3-pip

# set cuda paths
ENV PATH /usr/local/cuda/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib:/usr/local/cuda/lib
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib

# set cuda version
ENV CUDA_VERSION 12.2

# nvidia-docker
 ENV NVIDIA_VISIBLE_DEVICES all
 ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
 ENV NVIDIA_REQUIRE_CUDA "cuda>=12.2"

# install cuda from a runfile
COPY cuda /tmp/cuda
RUN cd /tmp/cuda \
    && chmod 777 cuda_12.2.2_535.104.05_linux.run \
    && ./cuda_12.2.2_535.104.05_linux.run --silent --toolkit --override \
    && rm -rf /tmp/cuda \
    && rm -rf /tmp/*
    
## install gcc 9
RUN apt-get update && apt install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y gcc-9 g++-9

## set default gcc to 9
RUN ln -s /usr/bin/gcc-9 /usr/local/cuda/bin/gcc \
    && ln -s /usr/bin/g++-9 /usr/local/cuda/bin/g++



# installing cudnn 8.9.4
COPY cudnn /tmp/cudnn
ENV CUDNN_TAR_FILE="cudnn-linux-x86_64-8.9.4.25_cuda12-archive.tar.xz"
RUN cd /tmp/cudnn\
    && chmod 777 ${CUDNN_TAR_FILE}\
    && tar -xf ${CUDNN_TAR_FILE}\
    && cp -P cudnn-linux-x86_64-8.9.4.25_cuda12-archive/include/cudnn.h /usr/local/cuda/include \
    && cp -P cudnn-linux-x86_64-8.9.4.25_cuda12-archive/lib/libcudnn* /usr/local/cuda/lib/ \
    && chmod a+r /usr/local/cuda/lib/libcudnn* \
    && rm -rf /tmp/cudnn

# Nvidia driver
RUN add-apt-repository ppa:graphics-drivers/ppa \
    && apt install -y nvidia-driver-535
# installing tensorflow-gpu
RUN apt install -y python3-pip

ENV HOME /root
# installing ROS2
RUN apt update && apt -y upgrade && \
    apt install -y locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

RUN apt install -y software-properties-common && \
    add-apt-repository universe && \
    apt update && apt install -y curl && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update && apt -y upgrade && \
    apt install -y ros-humble-desktop

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

RUN apt install -y ros-humble-gazebo-ros-pkgs python3-rosdep && \
    rosdep init && rosdep update && \
    apt install -y python3-colcon-common-extensions ros-humble-xacro


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
