FROM ubuntu:18.04

LABEL original-maintainer="philipp@haefelfinger.ch"
LABEL maintainer="niavasha@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /tmp
WORKDIR /tmp

# Updated to remove apt package files as per best practices
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    make \
    gcc \
&& rm -rf /var/lib/apt/lists/*

# Updated to delete source .tar.gz file and also remove 
# installed and unecessary packages, including docs
RUN wget http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz && \
    tar -xzvf udpxy-src.tar.gz && \
    cd udpxy-1.0.23-12 && make && make install && \ 
    cd /tmp && \
    rm -rf /tmp/udpxy-1.0.23-12 && \
    rm -rf /tmp/udpxy-src.tar.gz && \
    apt remove -y wget make gcc && \
    apt autoremove -y && \
    rm -rf /usr/share/doc/*

EXPOSE 4022

CMD ["/usr/local/bin/udpxy", "-T", "-p", "4022", "-v", "-S", "-c", "50"]
