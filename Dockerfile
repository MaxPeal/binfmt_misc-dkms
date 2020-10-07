FROM ubuntu:16.04

# Install packages
RUN apt-get update
RUN apt-get install -y dkms linux-headers-$(uname -r)
RUN apt-get install -y linux-headers-$(uname -r)

# Build module
WORKDIR /root/build-dkms
COPY patches/* ./patches/
#COPY binfmt_misc.c open.c internal.h ./
COPY binfmt_misc.c ./
COPY Makefile dkms.conf ./
RUN dkms build --verbose . || cat /var/lib/dkms/*/*/build/make.log
RUN cat /var/lib/dkms/*/*/build/make.log ||:
RUN dkms install --verbose binfmt_misc/1.1.0
