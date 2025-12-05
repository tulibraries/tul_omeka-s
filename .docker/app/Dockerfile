FROM harbor.k8s.temple.edu/docker-hub-proxy/library/httpd:2.4-alpine

ARG OMEKA_VERSION=4.2.0

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.3.3-r1 \
      freetype-dev=2.14.1-r0 \
      ghostscript=10.06.0-r0 \
      imagemagick-libs=7.1.2.8-r0 \
      imagemagick=7.1.2.8-r0 \
      libjpeg-turbo-dev=3.1.2-r0 \
      libpng-dev=1.6.51-r1 \
      libwebp-dev=1.6.0-r0 \
      libxpm-dev=3.5.17-r0 \
      libxslt=1.1.43-r3 \
      mariadb-connector-c=3.4.6-r0 \
      php84-apache2 \
      php84-ctype \
      php84-dev \
      php84-dom \
      php84-fileinfo \
      php84-gd \
      php84-iconv \
      php84-intl \
      php84-mbstring \
      php84-mysqli \
      php84-mysqlnd \
      php84-openssl \
      php84-pdo \
      php84-pdo_mysql \
      php84-pear \
      php84-pecl-imagick \
      php84-phar \
      php84-cli \
      php84-session \
      php84-tokenizer \
      php84-xmlreader \
      php84-xmlwriter \
      php84 \
      poppler-utils=25.12.0-r0 \
      shared-mime-info=2.4-r6 \
      tzdata=2025b-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r3 \
      curl=8.17.0-r1 \
      dpkg=1.22.21-r0 \
      git=2.52.0-r0 \
      imagemagick-dev=7.1.2.8-r0 \
      jq=1.8.1-r0 \
      libxslt-dev=1.1.43-r3 \
      mariadb-dev=11.4.9-r0 \
      nodejs=24.11.1-r0 \
      npm=11.6.3-r0 \
      wget=1.25.0-r2

RUN ln -sf /usr/bin/php84 /usr/bin/php

RUN ./build.sh > /dev/stdout 2>&1
WORKDIR /var/www/html
USER nobody
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
