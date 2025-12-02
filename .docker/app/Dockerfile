FROM harbor.k8s.temple.edu/library/httpd:2.4-alpine

ARG OMEKA_VERSION=4.1.1

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.2.37-r0 \
      freetype-dev=2.13.3-r0 \
      ghostscript=10.05.1-r0 \
      imagemagick-libs=7.1.2.8-r0 \
      imagemagick=7.1.2.8-r0 \
      libjpeg-turbo-dev=3.1.0-r0 \
      libpng-dev=1.6.51-r0 \
      libwebp-dev=1.5.0-r0 \
      libxpm-dev=3.5.17-r0 \
      libxslt=1.1.43-r3 \
      mariadb-connector-c=3.3.10-r0 \
      php83-apache2=8.3.27-r0 \
      php83-ctype=8.3.27-r0 \
      php83-dev=8.3.27-r0 \
      php83-dom=8.3.27-r0 \
      php83-fileinfo=8.3.27-r0 \
      php83-gd=8.3.27-r0 \
      php83-iconv=8.3.27-r0 \
      php83-intl=8.3.27-r0 \
      php83-mbstring=8.3.27-r0 \
      php83-mysqli=8.3.27-r0 \
      php83-mysqlnd=8.3.27-r0 \
      php83-openssl=8.3.27-r0 \
      php83-pdo=8.3.27-r0 \
      php83-pdo_mysql=8.3.27-r0 \
      php83-pear=8.3.27-r0 \
      php83-pecl-imagick=3.8.0-r1 \
      php83-phar=8.3.27-r0 \
      php83-session=8.3.27-r0 \
      php83-tokenizer=8.3.27-r0 \
      php83-xmlreader=8.3.27-r0 \
      php83-xmlwriter=8.3.27-r0 \
      php83=8.3.27-r0 \
      poppler-utils=25.04.0-r0 \
      shared-mime-info=2.4-r6 \
      tzdata=2025b-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r3 \
      curl=8.14.1-r2 \
      dpkg=1.22.15-r0 \
      git=2.49.1-r0 \
      imagemagick-dev=7.1.2.8-r0 \
      jq=1.8.1-r0 \
      libxslt-dev=1.1.43-r3 \
      mariadb-dev=11.4.8-r0 \
      nodejs=22.16.0-r2 \
      npm=11.6.4-r0 \
      wget=1.25.0-r1

RUN ./build.sh > /dev/stdout 2>&1
WORKDIR /var/www/html
USER nobody
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
