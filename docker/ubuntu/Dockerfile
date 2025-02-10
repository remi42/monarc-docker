FROM ubuntu:22.04

# 1. set environment to noninteractive
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

# 2. update
RUN apt-get update

# 3. Install system dependencies
RUN apt-get -y install zip unzip git gettext curl jq

# 4. Install Apache2
RUN apt-get -y install apache2 && \
    a2dismod status && \
    a2enmod ssl && \
    a2enmod rewrite && \
    a2enmod headers

EXPOSE 80
