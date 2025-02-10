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

# 6. Installation of MONARC
RUN PATH_TO_MONARC='/var/lib/monarc/fo' && \
    PATH_TO_MONARC_DATA='/var/lib/monarc/fo-data' && \
    MONARC_VERSION=$(curl --silent -H 'Content-Type: application/json' https://api.github.com/repos/monarc-project/MonarcAppFO/releases/latest | jq  -r '.tag_name') && \
    MONARCFO_RELEASE_URL="https://github.com/monarc-project/MonarcAppFO/releases/download/$MONARC_VERSION/MonarcAppFO-$MONARC_VERSION.tar.gz" && \
    mkdir -p /var/lib/monarc/releases/ && \
    curl -sL $MONARCFO_RELEASE_URL -o /var/lib/monarc/releases/`basename $MONARCFO_RELEASE_URL` && \
    mkdir /var/lib/monarc/releases/`basename $MONARCFO_RELEASE_URL | sed 's/.tar.gz//'` && \
    tar -xzf /var/lib/monarc/releases/`basename $MONARCFO_RELEASE_URL` -C /var/lib/monarc/releases/`basename $MONARCFO_RELEASE_URL | sed 's/.tar.gz//'` && \
    ln -s /var/lib/monarc/releases/`basename $MONARCFO_RELEASE_URL | sed 's/.tar.gz//'` $PATH_TO_MONARC  && \
    mkdir -p $PATH_TO_MONARC_DATA/cache $PATH_TO_MONARC_DATA/DoctrineORMModule/Proxy $PATH_TO_MONARC_DATA/LazyServices/Proxy $PATH_TO_MONARC_DATA/import/files && \
    ln -s $PATH_TO_MONARC_DATA $PATH_TO_MONARC/data

# 7. Copy files to image
COPY copy/ /

# 8. Configurate MONARC
RUN cd /var/lib/monarc/releases/MonarcAppFO-v2.13.2/config/autoload && \
    mv local.php.dist local.php

# 9. Configurate MONARC
COPY database.local.php /var/lib/monarc/releases/MonarcAppFO-v2.13.2/config/autoload/database.local.php

# 10. Change owner
RUN chown -R www-data:www-data /var/lib/monarc

# 11. Initial user
RUN cd /var/lib/monarc/releases/MonarcAppFO-v2.13.2/ && \
    php ./vendor/robmorgan/phinx/bin/phinx seed:run -c ./module/Monarc/FrontOffice/migrations/phinx.php

EXPOSE 80
