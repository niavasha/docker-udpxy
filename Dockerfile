FROM alpine

LABEL original-maintainer="philipp@haefelfinger.ch"
LABEL maintainer="niavasha@gmail.com"
LABEL maintainer="ilya.prihlop@gmail.com"

ENV HOME /tmp
WORKDIR /tmp

# Updated to remove apt package files as per best practices
RUN apk add --update \
    wget \
    make \
    gcc \
    libc-dev && \
 rm -rf /var/cache/apk/*

# Updated to delete source .tar.gz file and also remove 
# installed and unecessary packages, including docs
RUN wget http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz && \
    tar -xzvf udpxy-src.tar.gz && \
    cd udpxy-1.0.23-12 && make && make install && \ 
    cd /tmp && \
    rm -rf /tmp/udpxy-1.0.23-12 && \
    rm -rf /tmp/udpxy-src.tar.gz && \
    rm -rf /usr/share/doc/*

EXPOSE 4022

CMD ["/usr/local/bin/udpxy", "-T", "-p", "4022", "-v", "-S", "-c", "50"]
