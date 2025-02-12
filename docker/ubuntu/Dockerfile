FROM ubuntu:22.04

# 1. set environment to noninteractive
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV APACHE_RUN_DIR=/var/www
ENV PATH_TO_MONARC=/var/lib/monarc/fo
ENV PATH_TO_MONARC_DATA=/var/lib/monarc/data

# 2. System updates & installation
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y zip unzip git gettext curl jq apache2 php8.1 \
    php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring \
    php8.1-curl php8.1-xml php8.1-bcmath php8.1-intl php8.1-imagick && \
    a2dismod status && \
    a2enmod ssl rewrite headers && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Copy files to image
COPY copy/ /

# 4. Execution permission
RUN chmod +x /usr/local/bin/start.sh

# 5. Fetch MONARC latest version
RUN MONARC_VERSION=$(curl --silent -H 'Content-Type: application/json' https://api.github.com/repos/monarc-project/MonarcAppFO/releases/latest | jq  -r '.tag_name') && \
    MONARCFO_RELEASE_URL="https://github.com/monarc-project/MonarcAppFO/releases/download/$MONARC_VERSION/MonarcAppFO-$MONARC_VERSION.tar.gz" && \
    mkdir -p $PATH_TO_MONARC && \
    curl -sL $MONARCFO_RELEASE_URL -o /var/lib/monarc/monarc.tar.gz && \
    chown -R www-data:www-data /var/lib/monarc

# 6. Installation of MONARC
USER www-data
RUN tar -xzf /var/lib/monarc/monarc.tar.gz -C /var/lib/monarc/fo/ && \
    mkdir -p $PATH_TO_MONARC_DATA/cache $PATH_TO_MONARC_DATA/DoctrineORMModule/Proxy $PATH_TO_MONARC_DATA/LazyServices/Proxy $PATH_TO_MONARC_DATA/import/files && \
    ln -s $PATH_TO_MONARC_DATA $PATH_TO_MONARC/data

# 7. Configurate MONARC part I
RUN cd /var/lib/monarc/fo/config/autoload && \
    mv local.php.dist local.php

# 8. Configurate MONARC part II
COPY database.local.php /var/lib/monarc/releases/MonarcAppFO-v2.13.2/config/autoload/database.local.php

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/start.sh"]
