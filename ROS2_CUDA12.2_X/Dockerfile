########################################################
# CUDA 12.2 + CUDNN 8.9.4 ON UBUNTU 22.04
########################################################
FROM ubuntu:22.04
LABEL maintainer="Minkyu Park <mpark@changwon.ac.kr>"

ENV HOME /root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y build-essential libxml2 git gedit
RUN apt install -y python3-pip cmake openssl libssl-dev
RUN apt remove -y --purge cmake

# set cmake and cuda paths
ENV PATH=/opt/cmake/bin:/usr/local/cuda-12.2/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64:/usr/local/cuda/lib64

RUN apt install wget
RUN cd /tmp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.31.5/cmake-3.31.5.tar.gz \
    && tar -xzvf cmake-3.31.5.tar.gz \
    && cd cmake-3.31.5 && ./bootstrap --prefix=/opt/cmake \
    && make \
    && make install \
    && cmake --version

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
    && cp -r cudnn-linux-x86_64-8.9.4.25_cuda12-archive/include/cudnn* /usr/local/cuda-12.2/include/ \
    && cp -r cudnn-linux-x86_64-8.9.4.25_cuda12-archive/lib/libcudnn* /usr/local/cuda-12.2/lib64/ \
    && chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda-12.2/lib64/libcudnn* \
    && rm -rf /tmp/cudnn

# Nvidia driver
RUN add-apt-repository ppa:graphics-drivers/ppa \
    && apt install -y nvidia-driver-560
# installing tensorflow-gpu
RUN apt install -y python3-pip


# installing ROS2
RUN apt update && apt -y upgrade
RUN apt install -y locales
RUN locale-gen en_US en_US.UTF-8 && \
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
