#####################################################################
#Python 3.7 , Jupyter, Tensorflow, OpenAI Gym, Pytorch 
#####################################################################
FROM mk:cuda11.1-ubuntu18.04
LABEL maintainer="Minkyu Park <mk.park@unist.ac.kr>"
#####################################################################
# 1. setup docker ENV
ARG DEBIAN_FRONTEND=noninteractive
ENV HOME /root
####################################################################
# 1. installing miniconda
ENV PATH /opt/conda/bin:$PATH
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HOME /root

# install miniconda4.10.3 based on python3.7
ENV CONDA_V="4.10.3"
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,display
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
######################################################################
# 2. installing Python
RUN pip install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN conda install --channel=numba llvmlite conda=${CONDA_V}
RUN pip install jupyter pandas matplotlib scipy seaborn scikit-learn scikit-Image sympy cython patsy statsmodels cloudpickle dill numba bokeh tensorflow pyglet==1.5.27 colorama
#RUN pip install tensorflow-gpu==2.4.1
RUN conda install -c conda-forge tensorboardx -y && \
    conda install -c conda-forge tensorboard -y
RUN pip install tensorboard==2.11.2
######################################################################
# 3. installing OpenAI Gym (plus dependencies)
RUN pip install gym pyopengl
# 3.1 installing roboschool and its dependencies.
RUN apt-get update \
    && apt-get install --no-install-recommends -y cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.7-dev libboost-python-dev libtinyxml-dev
# This got some dependencies, so let's get going
# https://github.com/openai/roboschool
WORKDIR /gym
ENV ROBOSCHOOL_PATH="/gym/roboschool"
# installing bullet (the physics engine of roboschool) and its dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends git gcc g++ && \
	git clone https://github.com/openai/roboschool && \
	git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision && \
	mkdir bullet3/build && \
	cd    bullet3/build && \
	cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF .. && \
	make -j4 && \
	make install

WORKDIR /gym/roboschool
RUN	pip install -e ./
######################################################################################
# 4. installing X and xvfb so we can SEE the action using a remote desktop access
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


# TensorBoard
EXPOSE 6016
# IPython
EXPOSE 8898
# VNC Server
EXPOSE 5910

WORKDIR /root

