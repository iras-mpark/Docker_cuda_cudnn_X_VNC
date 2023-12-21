#####################################################################
# CONDA 4.10.3, Python, Jupyter, Tensorflow, OpenAI Gym, Pytorch 
#####################################################################
FROM mk:cuda11.1-ubuntu18.04
LABEL maintainer="Minkyu Park <mk.park@unist.ac.kr>"
#####################################################################
ARG DEBIAN_FRONTEND=noninteractive
# 1. installing miniconda
ENV PATH /opt/conda/bin:$PATH
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HOME /root

# install miniconda4.10.3 based on python3.7
ENV CONDA_V="4.10.3"
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

######################################################################
# 2. installing jupyter, and a bunch of Science Python Packages
# packages taken from https://hub.docker.com/r/jupyter/datascience-notebook/
# 2.1 installing Tensorflow (GPU) + Pytorch
RUN pip install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN conda install --channel=numba llvmlite conda=${CONDA_V}
RUN pip install pyglet==1.5.15 tensorflow==2.1.0 tensorboard==2.1 tensorflow-gpu==2.1.0
#RUN conda install -c conda-forge tensorboardx -y && \
#    conda install -c conda-forge tensorboard -y

# It is easy to debug run every command seperately

#RUN conda install -c conda-forge tensorboardx -y && \
#    conda install -c conda-forge notebook -y && \
#    conda install -c conda-forge numpy=1.16.6 -y && \
#    conda install -c conda-forge pandas -y && \
#    conda install -c conda-forge matplotlib -y && \
#    conda install -c conda-forge opencv -y && \
#    conda install -c conda-forge scikit-learn -y && \
#    conda install -c conda-forge tqdm -y && \
#    conda install -c conda-forge scikit-image -y && \
#    conda install -c anaconda scipy=1.5.3 -y && \
#    conda install -c anaconda h5py=2.10.0 -y

######################################################################
# 4. installing OpenAI Gym (plus dependencies)
RUN pip install gym==0.18.3 pyopengl
# 4.1 installing roboschool and its dependencies.
RUN apt-get update \
    && apt-get install --no-install-recommends -y cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.7-dev libboost-python-dev libtinyxml-dev
# This got some dependencies, so let's get going
# https://github.com/openai/roboschool
#WORKDIR /gym
#ENV ROBOSCHOOL_PATH="/gym/roboschool"
## installing bullet (the physics engine of roboschool) and its dependencies
#RUN apt-get update \
#    && apt-get install -y --no-install-recommends git gcc g++ && \
#	git clone https://github.com/openai/roboschool && \
#	git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision && \
#	mkdir bullet3/build && \
#	cd    bullet3/build && \
#	cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -#DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -#DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -#DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF .. && \
#	make -j4 && \
#	make install

#WORKDIR /gym/roboschool
#RUN	pip install -e ./

# 5. installing X and xvfb so we can SEE the action using a remote desktop access (VNC)
# and because this is the last apt, let's clean up after ourselves
#RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
#RUN cat /etc/apt/sources.list
#RUN sed "s/security.ubuntu.com/mirror.kakao.com" -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y x11vnc
RUN apt-get install -y xvfb
RUN apt-get install -y fluxbox
RUN apt-get install -y wmctrl
RUN apt-get clean


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
# VNC Server
EXPOSE 5900

WORKDIR /root

RUN mkdir /notebooks
COPY example.ipynb /notebooks/.
RUN chmod 777 /notebooks/example.ipynb
COPY startup.sh /
RUN chmod 777 /startup.sh
ENTRYPOINT ["/startup.sh", "--allow-root"]
