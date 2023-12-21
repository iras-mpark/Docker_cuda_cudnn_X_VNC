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


######################################################################
# 3. installing OpenAI Gym (plus dependencies)
RUN pip install gym==0.18.3 pyopengl
# 3.1 installing roboschool and its dependencies.
RUN apt-get update \
    && apt-get install --no-install-recommends -y cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.7-dev libboost-python-dev libtinyxml-dev

# 4. installing X and xvfb so we can SEE the action using a remote desktop access (VNC)
# and because this is the last apt, let's clean up after ourselves
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
