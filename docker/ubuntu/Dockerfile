FROM ubuntu:22.04

# 1. set environment to noninteractive
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV APACHE_RUN_DIR=/var/www
ENV PATH_TO_MONARC=/var/lib/monarc/fo
ENV PATH_TO_MONARC_DATA=/var/lib/monarc/data

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
RUN apt-get install -y php8.1 php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath php8.1-intl php8.1-imagick

# 6. Copy files to image
COPY copy/ /

# 7. Execution permission
RUN chmod +x /usr/local/bin/start.sh

# 8. Installation of MONARC port I
RUN MONARC_VERSION=$(curl --silent -H 'Content-Type: application/json' https://api.github.com/repos/monarc-project/MonarcAppFO/releases/latest | jq  -r '.tag_name') && \
    MONARCFO_RELEASE_URL="https://github.com/monarc-project/MonarcAppFO/releases/download/$MONARC_VERSION/MonarcAppFO-$MONARC_VERSION.tar.gz" && \
    mkdir -p /var/lib/monarc/ && \
    curl -sL $MONARCFO_RELEASE_URL -o /var/lib/monarc/monarc.tar.gz && \
    chown -R www-data:www-data /var/lib/monarc

# 9. Installation of MONARC port II \
USER www-data
RUN tar -xzf /var/lib/monarc/monarc.tar.gz -C ./fo && \
    mkdir -p $PATH_TO_MONARC_DATA/cache $PATH_TO_MONARC_DATA/DoctrineORMModule/Proxy $PATH_TO_MONARC_DATA/LazyServices/Proxy $PATH_TO_MONARC_DATA/import/files && \
    ln -s $PATH_TO_MONARC_DATA $PATH_TO_MONARC/data

# 10. Configurate MONARC part I
RUN cd /var/lib/monarc/releases/MonarcAppFO-v2.13.2/config/autoload && \
    mv local.php.dist local.php

# 11. Configurate MONARC part II
COPY database.local.php /var/lib/monarc/releases/MonarcAppFO-v2.13.2/config/autoload/database.local.php

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/start.sh"]
