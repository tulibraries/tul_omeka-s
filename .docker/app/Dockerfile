FROM php:7.4-apache-buster

# Omeka-S web publishing platform for digital heritage collections (https://omeka.org/s/)
# Previous maintainers: Oldrich Vykydal (o1da) - Klokan Technologies GmbH  / Eric Dodemont <eric.dodemont@skynet.be>
# MAINTAINER Giorgio Comai <g@giorgiocomai.eu>

ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /build

COPY . .

RUN a2enmod rewrite \
&&  apt-get -qq update \
&&  apt-get -qq -y --no-install-recommends install \
    unzip=6.0-23+deb10u2 \
    libfreetype6-dev=2.9.1-3+deb10u2 \
    libjpeg62-turbo-dev=1:1.5.2-2+deb10u1 \
    libmcrypt-dev=2.5.8-3.4 \
    libpng-dev=1.6.36-6 \
    libjpeg-dev=1:1.5.2-2+deb10u1 \
    libmemcached-dev=1.0.18-4.2 \
    zlib1g-dev=1:1.2.11.dfsg-1 \
    imagemagick=8:6.9.10.23+dfsg-2.1+deb10u1 \
    libmagickwand-dev=8:6.9.10.23+dfsg-2.1+deb10u1 \
    wget=1.20.1-1.1 \
    ghostscript=9.27~dfsg-2+deb10u4 \
    poppler-utils=0.71.0-5 \
&&  docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
&&  docker-php-ext-install -j"$(nproc)" iconv pdo pdo_mysql mysqli gd \
&&  yes | pecl install  mcrypt-1.0.3 || echo "pecl install encrypt: $?" \
&&  docker-php-ext-enable mcrypt || echo "docker-pop-ext-enable mcrypt: $?" \
&&  yes | pecl install imagick || echo "pecl install imagick $?" && docker-php-ext-enable imagick \
&&  wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v3.0.2/omeka-s-3.0.2.zip" -O /var/www/latest_omeka_s.zip \
&&  unzip -q /var/www/latest_omeka_s.zip -d /var/www/ \
&&  rm /var/www/latest_omeka_s.zip \
&&  rm -rf /var/www/html/ \
&&  mv /var/www/omeka-s/ /var/www/html/ \
&&  mkdir -p /var/www/html/config/ && mkdir -p /var/www/html/files/ && mkdir -p /var/www/html/modules/ && mkdir -p /var/www/html/themes/  \
&&  cp imagemagick-policy.xml /etc/ImageMagick-6/policy.xml \
&&  cp .htaccess /var/www/html/.htaccess \
&&  cp database.ini /var/www/html/config/ \
&&  cp local.config.php /var/www/html/config/ \
&&  chown -R www-data:www-data /var/www/html/ \
&&  chmod 600 /var/www/html/config/database.ini \
&&  chmod 600 /var/www/html/config/local.config.php \
&&  chmod 600 /var/www/html/.htaccess \
&&  echo "ServerName localhost" >> /etc/apache2/apache2.conf \
&&  rm -rf /build 

WORKDIR /var/www/html

CMD ["apache2-foreground"]
