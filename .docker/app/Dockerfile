FROM harbor.k8s.temple.edu/library/httpd:2.4-alpine

ARG OMEKA_VERSION=4.0.4

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.2.26-r0 \
      libxslt=1.1.39-r1 \
      tzdata=2024b-r0 \
      shared-mime-info=2.4-r0 \
      imagemagick=7.1.1.32-r2 \
      mariadb-connector-c=3.3.10-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      git=2.45.2-r0 \
      build-base=0.5-r3 \
      dpkg=1.22.6-r1 \
      libxslt-dev=1.1.39-r1 \
      mariadb-dev=10.11.8-r0 \
      mariadb-client=10.11.8-r0 \
      wget=1.24.5-r0 \
      curl=8.10.1-r0 \
      ghostscript=10.04.0-r0 \
      poppler-utils=24.02.0-r1 \
      libpng-dev=1.6.44-r0 \
      libjpeg-turbo-dev=3.0.3-r0 \
      freetype-dev=2.13.2-r0 \
      imagemagick-libs=7.1.1.32-r2 \
      imagemagick-dev=7.1.1.32-r2 \
      libxpm-dev=3.5.17-r0 \
      libwebp-dev=1.3.2-r0 \
      php83=8.3.12-r0 \
      php83-apache2=8.3.12-r0 \
      php83-dev=8.3.12-r0 \
      php83-pear=8.3.12-r0 \
      php83-session=8.3.12-r0 \
      php83-ctype=8.3.12-r0 \
      php83-pdo=8.3.12-r0 \
      php83-iconv=8.3.12-r0 \
      php83-gd=8.3.12-r0 \
      php83-openssl=8.3.12-r0 \
      php83-mysqlnd=8.3.12-r0 \
      php83-mysqli=8.3.12-r0 \
      php83-pdo_mysql=8.3.12-r0 \
      php83-fileinfo=8.3.12-r0 \
      php83-mbstring=8.3.12-r0 \
      php83-phar=8.3.12-r0 \
      php83-tokenizer=8.3.12-r0 \
      php83-pecl-imagick=3.7.0-r0

RUN ./build.sh > /dev/stdout 2>&1
WORKDIR /var/www/html
ENTRYPOINT ["/bin/bash"]

USER nobody
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
