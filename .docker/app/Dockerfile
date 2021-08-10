FROM php:7.4-apache-buster

# Omeka-S web publishing platform for digital heritage collections (https://omeka.org/s/)
# Previous maintainers: Oldrich Vykydal (o1da) - Klokan Technologies GmbH  / Eric Dodemont <eric.dodemont@skynet.be>
# MAINTAINER Giorgio Comai <g@giorgiocomai.eu>

RUN a2enmod rewrite

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get -qq -y upgrade \
&&  apt-get -qq update && apt-get -qq -y --no-install-recommends install \
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
&&  docker-php-ext-install -j$(nproc) iconv pdo pdo_mysql mysqli gd \
&&  yes | pecl install  mcrypt-1.0.3 && docker-php-ext-enable mcrypt && yes | pecl install imagick && docker-php-ext-enable imagick \
&&  wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v3.0.2/omeka-s-3.0.2.zip" -O /var/www/latest_omeka_s.zip \
&&  unzip -q /var/www/latest_omeka_s.zip -d /var/www/ \
&&  rm /var/www/latest_omeka_s.zip \
&&  rm -rf /var/www/html/ \
&&  mv /var/www/omeka-s/ /var/www/html/

COPY ./imagemagick-policy.xml /etc/ImageMagick-6/policy.xml
COPY ./.htaccess /var/www/html/.htaccess

# Create one volume for files, config, themes and modules
RUN mkdir -p /var/www/html/volume/config/ && mkdir -p /var/www/html/volume/files/ && mkdir -p /var/www/html/volume/modules/ && mkdir -p /var/www/html/volume/themes/

COPY ./database.ini /var/www/html/volume/config/
COPY ./local.config.php /var/www/html/volume/config/
RUN rm /var/www/html/config/database.ini \
&& ln -s /var/www/html/volume/config/database.ini /var/www/html/config/database.ini \
&& rm /var/www/html/config/local.config.php \
&& ln -s /var/www/html/volume/config/local.config.php /var/www/html/config/local.config.php \
&& rm -Rf /var/www/html/files/ \
&& ln -s /var/www/html/volume/files/ /var/www/html/files \
&& rm -Rf /var/www/html/modules/ \
&& ln -s /var/www/html/volume/modules/ /var/www/html/modules \
&& rm -Rf /var/www/html/themes/ \
&& ln -s /var/www/html/volume/themes/ /var/www/html/themes \
&& chown -R www-data:www-data /var/www/html/ \
&& chmod 600 /var/www/html/volume/config/database.ini \
&& chmod 600 /var/www/html/volume/config/local.config.php \
&& chmod 600 /var/www/html/.htaccess

VOLUME /var/www/html/volume/
\
CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["apache2-foreground"]
