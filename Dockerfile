#-- Download base image debian
FROM debian:stretch

#-- Set the image basics
SHELL [ "/bin/bash", "-c" ]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get update && \
 	apt-get install -y locales locales-all sudo
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN useradd -d /home/main -ms /bin/bash -g root dev && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev
WORKDIR /home/main

#-- Prepare container for what is needed and get Yocto
RUN sudo -S apt-get -y install gawk wget git-core diffstat unzip texinfo \
    gcc-multilib build-essential chrpath socat cpio python python3 \
    python3-pip  xz-utils debianutils iputils-ping libsdl2-dev xterm vim && cd /home/main && \
	wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/poky-sumo-19.0.0.tar.bz2 && \
	tar -xvjf poky-sumo-19.0.0.tar.bz2 && cd poky-sumo-19.0.0 && source oe-init-build-env && \
	bitbake core-image-minimal

#Shared folders
VOLUME ["~/ShareDev"] 
ENV DEBIAN_FRONTEND teletype
