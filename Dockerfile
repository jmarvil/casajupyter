# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /build

COPY requirements.txt .

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends sudo apt-utils && \
    apt-get install -y --no-install-recommends openssh-server \
        gcc gfortran libopenmpi-dev openmpi-bin openmpi-common openmpi-doc binutils && \
    apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 install -r requirements.txt

WORKDIR /casajupyter

COPY tclean_mpi.ipynb .

ENTRYPOINT ["jupyter", "lab"]

