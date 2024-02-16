########################################################
# CUDA 11.1 ON UBUNTU 18.04
########################################################
FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
# install other import packages
RUN apt-get update && apt-get install -y build-essential libxml2
# RUN apt-get update && apt-get install -y freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev wget software-properties-common

# set cuda paths
ENV PATH /usr/local/cuda-11.1/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda-11.1/lib64:/usr/local/cuda/lib64
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64


# set cuda version
ENV CUDA_VERSION 11.1

# nvidia-docker
 ENV NVIDIA_VISIBLE_DEVICES all
 ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
 ENV NVIDIA_REQUIRE_CUDA "cuda>=11.1"

# install cuda from a runfile
COPY cuda /tmp/cuda
RUN cd /tmp/cuda \
    && chmod 777 cuda_11.1.0_455.23.05_linux.run \
    && ./cuda_11.1.0_455.23.05_linux.run --silent --toolkit --override \
    && rm -rf /tmp/cuda \
    && rm -rf /tmp/*
    
## install gcc 9
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y gcc-9 g++-9

## set default gcc to 9
RUN ln -s /usr/bin/gcc-9 /usr/local/cuda/bin/gcc \
    && ln -s /usr/bin/g++-9 /usr/local/cuda/bin/g++



# installing cudnn 8.0.5
COPY cudnn /tmp/cudnn
RUN CUDNN_TAR_FILE="cudnn-11.1-linux-x64-v8.0.5.39.tgz" \
    && cd /tmp/cudnn \
    && chmod 777 ${CUDNN_TAR_FILE} \
    && tar -xzf ${CUDNN_TAR_FILE} \
    && cp -P cuda/include/cudnn.h /usr/local/cuda-11.1/include \
    && cp -P cuda/lib64/libcudnn* /usr/local/cuda-11.1/lib64/ \
    && chmod a+r /usr/local/cuda-11.1/lib64/libcudnn* \
    && rm -rf /tmp/cudnn

# Nvidia driver
RUN add-apt-repository ppa:graphics-drivers/ppa \
    && apt install -y nvidia-driver-530
# installing tensorflow-gpu
RUN apt install -y python3-pip \
    && pip3 install --user tensorflow-gpu==2.1.0
