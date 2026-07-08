FROM harbor.k8s.temple.edu/docker-hub-proxy/library/httpd:2.4-alpine

ARG OMEKA_VERSION=4.2.1

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk upgrade --no-cache \
&&  apk add -U --no-cache \
      bash=5.3.9-r1 \
      freetype-dev=2.14.3-r0 \
      ghostscript=10.07.1-r0 \
      imagemagick-libs=7.1.2.24-r0 \
      imagemagick=7.1.2.24-r0 \
      libjpeg-turbo-dev=3.1.3-r0 \
      libpng-dev=1.6.58-r1 \
      libwebp-dev=1.6.0-r0 \
      libxpm-dev=3.5.19-r0 \
      libxslt=1.1.43-r3 \
      mariadb-connector-c=3.4.6-r0 \
      php84-apache2=8.4.23-r0 \
      php84-ctype=8.4.23-r0 \
      php84-dev=8.4.23-r0 \
      php84-dom=8.4.23-r0 \
      php84-fileinfo=8.4.23-r0 \
      php84-gd=8.4.23-r0 \
      php84-iconv=8.4.23-r0 \
      php84-intl=8.4.23-r0 \
      php84-mbstring=8.4.23-r0 \
      php84-mysqli=8.4.23-r0 \
      php84-mysqlnd=8.4.23-r0 \
      php84-openssl=8.4.23-r0 \
      php84-pdo=8.4.23-r0 \
      php84-pdo_mysql=8.4.23-r0 \
      php84-pear=8.4.23-r0 \
      php84-pecl-imagick=3.8.1-r0 \
      php84-phar=8.4.23-r0 \
      php84-session=8.4.23-r0 \
      php84-tokenizer=8.4.23-r0 \
      php84-xmlreader=8.4.23-r0 \
      php84-xmlwriter=8.4.23-r0 \
      php84=8.4.23-r0 \
      poppler-utils=25.12.0-r1 \
      shared-mime-info=2.4-r7 \
      tzdata=2026b-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r4 \
      curl=8.21.0-r0 \
      dpkg=1.23.7-r0 \
      git=2.54.0-r0 \
      imagemagick-dev=7.1.2.24-r0 \
      jq=1.8.1-r0 \
      libxslt-dev=1.1.43-r3 \
      mariadb-dev=11.8.8-r0 \
      nodejs=24.17.0-r0 \
      npm=11.12.1-r0 \
      wget=1.25.0-r3

RUN ln -sf /usr/bin/php84 /usr/bin/php \
 && ./build.sh > /dev/stdout 2>&1
WORKDIR /var/www/html
USER nobody
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
