# syntax=docker/dockerfile:1

#FROM python:3.8-slim-buster
FROM ubuntu:18.04

WORKDIR /build

COPY requirements.txt .

# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends sudo apt-utils && \
#     apt-get install -y --no-install-recommends openssh-server \
#     python-dev python-numpy python-pip python-virtualenv python-scipy \
#         gcc gfortran libopenmpi-dev openmpi-bin openmpi-common openmpi-doc binutils && \
#     apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    
# RUN MPICC=/usr/bin/mpicc pip3 install -r requirements.txt

RUN mkdir /notebooks && chmod 777 /notebooks

COPY *ipynb /notebooks

COPY example* /notebooks

RUN mkdir -p /tmp/overlay
RUN mount -t tmpfs tmpfs /tmp/overlay
RUN mkdir -p /tmp/overlay/{upper,work}
RUN mkdir -p /root/folder
RUN mount -t overlay overlay -o lowerdir=/root/folder-ro,upperdir=/tmp/overlay/upper,workdir=/tmp/overlay/work /root/folder

ENTRYPOINT ["jupyter", "lab"]

