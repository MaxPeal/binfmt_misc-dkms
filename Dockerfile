FROM ubuntu:16.04

# Install packages
RUN apt-get update
RUN apt-get install -y dkms
RUN apt-get install -y linux-headers-$(uname -r)

# Build module
WORKDIR /root/ch340-dkms
COPY Makefile ch340.c dkms.conf ./
RUN dkms build --verbose . || cat /var/lib/dkms/*/*/build/make.log
RUN cat /var/lib/dkms/*/*/build/make.log
RUN dkms install --verbose ch340/1.0.0
