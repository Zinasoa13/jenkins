FROM ubuntu:24.04
RUN apt update
RUN apt install git -y
EXPOSE 22 80
