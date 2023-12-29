FROM mk:cuda11.1-ubuntu18.04
LABEL maintainer="Minkyu Park <mpark@changwon.ac.kr>"
#####################################################################
# 1. setup docker ENV
ARG DEBIAN_FRONTEND=noninteractive
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

# install python modules
RUN pip install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install gym==0.18.3 pyglet==1.5.15 pillow==8.2.0 tensorflow==2.1.0 tensorboard==2.1 tensorflow-gpu==2.1.0
RUN pip install scikit-learn==1.0.2 matplotlib==3.5.3
RUN pip install --upgrade "protobuf<=3.20.1"

# default screen size
ENV XRES=1280x800x24

# default tzdata
ENV TZ=Etc/UTC

# update and install software
RUN export DEBIAN_FRONTEND=noninteractive  \
	&& apt-get update -q \
	&& apt-get upgrade -qy \
	&& apt-get install -qy  --no-install-recommends \
	apt-utils sudo supervisor vim openssh-server \
	xserver-xorg xvfb x11vnc dbus-x11 \
	xfce4 xfce4-terminal xfce4-xkb-plugin  \
	freeglut3-dev nano gedit \
	# fix "LC_ALL: cannot change locale (en_US.UTF-8)""
	locales \
	&& echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "LANG=en_US.UTF-8" > /etc/locale.conf \
	&& locale-gen en_US.UTF-8 \
	\
	# keep it slim
	# 	&& apt-get remove -qy \
	\
	# cleanup and fix
	&& apt-get autoremove -y \
	&& apt-get --fix-broken install \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# required preexisting dirs
RUN mkdir /run/sshd

# add my sys config files
ADD etc /etc

# user config files

# terminal
ADD config/xfce4/terminal/terminalrc /root/.config/xfce4/terminal/terminalrc
# wallpaper
ADD config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
# icon theme
ADD config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

# TZ, aliases
RUN cd /root \
	&& echo 'export TZ=/usr/share/zoneinfo/$TZ' >> .bashrc \
	&& sed -i 's/#alias/alias/' .bashrc  \
	&& echo "alias lla='ls -al'" 		>> .bashrc \
	&& echo "alias llt='ls -ltr'"  		>> .bashrc \
	&& echo "alias llta='ls -altr'" 	>> .bashrc \
	&& echo "alias llh='ls -lh'" 		>> .bashrc \
	&& echo "alias lld='ls -l|grep ^d'" >> .bashrc \
	&& echo "alias hh=history" 			>> .bashrc \
	&& echo "alias hhg='history|grep -i" '"$@"' "'" >> .bashrc

# Tensorboard
EXPOSE 6006
# VNC
EXPOSE 5900

# # default command
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
