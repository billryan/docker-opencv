FROM ubuntu:12.04
MAINTAINER Rhett yuanbin2014@gmail.com
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get install -qqy build-essential && \
    apt-get install -qqy wget curl unzip cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
    apt-get install -qqy python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

RUN wget https://github.com/Itseez/opencv/archive/2.4.13.zip && \
    unzip 2.4.13.zip && \
    mkdir opencv-2.4.13/release && \
    cd opencv-2.4.13/release && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j4 && make install && \
    cd ../../ && rm *2.4.13* -rf && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN cd /usr/local/src && \
    curl --remote-name http://www.ijg.org/files/jpegsrc.v9b.tar.gz && \
    tar -xzvf jpegsrc.v9b.tar.gz && \
    cd jpeg-9b && \
    ./configure --prefix=/usr/local/libjpeg-9b && \
    make && make install && \
    ln -s libjpeg-9b /usr/local/libjpeg
