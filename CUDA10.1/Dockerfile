########################################################
# CUDA 10.1 ON UBUNTU 18.04
########################################################
FROM ubuntu:18.04

# install other import packages
RUN apt-get update && apt-get install -y build-essential libxml2
# RUN apt-get update && apt-get install -y freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev wget software-properties-common

# set cuda paths
ENV PATH /usr/local/cuda-10.1/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda-10.1/lib64:/usr/local/cuda/lib64
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64


# set cuda version
ENV CUDA_VERSION 10.1

# nvidia-docker
 ENV NVIDIA_VISIBLE_DEVICES all
 ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
 ENV NVIDIA_REQUIRE_CUDA "cuda>=10.1"

# install cuda from a runfile
COPY cuda /tmp/cuda
RUN cd /tmp/cuda \
    && chmod 777 cuda_10.1.105_418.39_linux.run \
    && ./cuda_10.1.105_418.39_linux.run --silent --toolkit --override \
    && rm -rf /tmp/cuda \
    && rm -rf /tmp/*
    
## install gcc 8 (cuda 10.1 doesn't support gcc 9)
RUN apt-get update && apt-get install -y gcc-8 g++-8

## set default gcc to 8
RUN ln -s /usr/bin/gcc-8 /usr/local/cuda/bin/gcc \
    && ln -s /usr/bin/g++-8 /usr/local/cuda/bin/g++



# installing cudnn 7
COPY cudnn /tmp/cudnn
RUN CUDNN_TAR_FILE="cudnn-10.1-linux-x64-v7.6.5.32.tgz" \
    && cd /tmp/cudnn \
    && chmod 777 ${CUDNN_TAR_FILE} \
    && tar -xzf ${CUDNN_TAR_FILE} \
    && cp -P cuda/include/cudnn.h /usr/local/cuda-10.1/include \
    && cp -P cuda/lib64/libcudnn* /usr/local/cuda-10.1/lib64/ \
    && chmod a+r /usr/local/cuda-10.1/lib64/libcudnn* \
    && rm -rf /tmp/cudnn

# installing tensorflow-gpu
#RUN apt-get install python3-pip \
#    && yes | pip3 install --user tensorflow-gpu==2.1.0
