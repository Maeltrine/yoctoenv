#Download base image debian
FROM debian:stretch

#Set the basics
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y locales \
    && locale-gen en_GB.UTF-8     
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en 
ENV LC_ALL en_GB.UTF-8 

#Prepare container for what is useful
RUN apt-get -y install gawk wget git-core diffstat unzip texinfo \
    gcc-multilib build-essential chrpath socat cpio python python3 \
    python3-pip  xz-utils debianutils iputils-ping libsdl2-dev xterm vim 

# Get Yocto
RUN git clone git://git.yoctoproject.org/poky && mkdir /home/work && \
    source /poky/oe-init-build-env /home/work && \
    bitbake -k core-image-minimal

#Shared folders
VOLUME ["/ShareDev"] 

ENV DEBIAN_FRONTEND teletype
