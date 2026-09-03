FROM harbor.k8s.temple.edu/docker-hub-proxy/library/httpd:2.4-alpine

ARG OMEKA_VERSION=4.2.1

WORKDIR /build

COPY . .

USER 0

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk upgrade --no-cache \
&&  apk add -U --no-cache \
      bash=5.3.9-r1 \
      freetype-dev=2.14.3-r0 \
      ghostscript=10.07.1-r0 \
      imagemagick-libs=7.1.2.30-r0 \
      imagemagick=7.1.2.30-r0 \
      libjpeg-turbo-dev=3.1.3-r0 \
      libpng-dev=1.6.58-r1 \
      libwebp-dev=1.6.0-r0 \
      libxpm-dev=3.5.19-r0 \
      libxslt=1.1.43-r3 \
      mariadb-connector-c=3.4.6-r0 \
      php85-apache2=8.5.10-r0 \
      php85-ctype=8.5.10-r0 \
      php85-dev=8.5.10-r0 \
      php85-dom=8.5.10-r0 \
      php85-fileinfo=8.5.10-r0 \
      php85-gd=8.5.10-r0 \
      php85-iconv=8.5.10-r0 \
      php85-intl=8.5.10-r0 \
      php85-mbstring=8.5.10-r0 \
      php85-mysqli=8.5.10-r0 \
      php85-mysqlnd=8.5.10-r0 \
      php85-openssl=8.5.10-r0 \
      php85-pdo=8.5.10-r0 \
      php85-pdo_mysql=8.5.10-r0 \
      php85-pear=8.5.10-r0 \
      php85-pecl-imagick=3.8.1-r0 \
      php85-phar=8.5.10-r0 \
      php85-session=8.5.10-r0 \
      php85-tokenizer=8.5.10-r0 \
      php85-xmlreader=8.5.10-r0 \
      php85-xmlwriter=8.5.10-r0 \
      php85=8.5.10-r0 \
      poppler-utils=25.12.0-r1 \
      shared-mime-info=2.4-r7 \
      tzdata=2026c-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r4 \
      curl=8.22.0-r0 \
      dpkg=1.23.7-r0 \
      git=2.54.0-r0 \
      imagemagick-dev=7.1.2.30-r0 \
      jq=1.8.2-r0 \
      libxslt-dev=1.1.43-r3 \
      mariadb-dev=11.8.8-r0 \
      nodejs=24.18.1-r0 \
      npm=11.12.1-r0 \
      wget=1.25.0-r3

RUN ln -sf /usr/bin/php85 /usr/bin/php \
 && ./build.sh > /dev/stdout 2>&1
WORKDIR /var/www/html
USER 65534
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
