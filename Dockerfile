FROM ubuntu:16.04

MAINTAINER Mitch Allen "docker@mitchallen.com"

# USAGE: docker run -it -v ~/raspberry/hello:/build mitchallen/pi-cross-compile

LABEL com.mitchallen.pi-cross-compile="{\"Description\":\"Cross Compile for Raspberry Pi\",\"Usage\":\"docker run -it -v ~/myprojects/mybuild:/build mitchallen/pi-cross-compile\",\"Version\":\"0.1.0\"}"

RUN apt-get update && apt-get install -y git && apt-get install -y build-essential && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN git clone --progress --verbose https://github.com/raspberrypi/tools.git --depth=1 pitools


RUN wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.55.tar.gz;
RUN tar xvfz bcm2835-1.55.tar.gz && cd bcm2835-1.55 && ./configure && make && make install


ENV BUILD_FOLDER /build

WORKDIR ${BUILD_FOLDER}

CMD ["/bin/bash", "-c", "make", "-f", "${BUILD_FOLDER}/Makefile"]
# CMD ["make", "clean"]
