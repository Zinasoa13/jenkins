FROM ubuntu:24.04
RUN apt update
RUN apt installl git -y
EXPOSE 22 80
