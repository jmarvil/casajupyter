# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /casa_jupyter

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

CMD [ "jupyter", "lab" , "--no-browser", "--ip 0.0.0.0"]

