# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /build

COPY requirements.txt .

# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends sudo apt-utils && \
#     apt-get install -y --no-install-recommends openssh-server \
#         gcc gfortran libopenmpi-dev openmpi-bin openmpi-common openmpi-doc binutils && \
#     apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
#     pip3 install -r requirements.txt

RUN pip3 install -r requirements.txt

WORKDIR /notebooks

COPY example* .

RUN mkdir -p /scratch /tmp/overlay
RUN mount -t overlay overlay -o index=off,workdir=/tmp/overlay,upperdir=/scratch,lowerdir=/notebooks /notebooks

ENTRYPOINT ["jupyter", "lab"]

