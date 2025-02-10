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

# 5. Install PHP and dependencies
RUN apt-get install -y php8.1 php8.1-cli php8.1-common hp8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath php8.1-intl php8.1-imagic

# 6. Copy files to image
COPY copy/ /

EXPOSE 80
