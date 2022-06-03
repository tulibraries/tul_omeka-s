FROM harbor.k8s.temple.edu/library/httpd:2.4-alpine

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.1.16-r2 \
      libxslt=1.1.35-r0 \
      tzdata=2022a-r0 \
      shared-mime-info=2.2-r0 \
      imagemagick=7.1.0.35-r0 \
      mariadb-connector-c=3.1.13-r4 \
&&  apk add -U --no-cache --virtual build-dependencies \
      git=2.36.1-r0 \
      build-base=0.5-r2 \
      dpkg=1.21.8-r0 \
      libxslt-dev=1.1.35-r0 \
      mariadb-dev=10.6.8-r0 \
      mariadb-client=10.6.8-r0 \
      wget=1.21.3-r0 \
      curl=7.83.1-r1 \
      ghostscript=9.56.1-r0 \
      poppler-utils=22.05.0-r0 \
      libpng-dev=1.6.37-r1 \
      libjpeg-turbo-dev=2.1.3-r1 \
      freetype-dev=2.12.1-r0 \
      imagemagick-libs=7.1.0.35-r0 \
      imagemagick-dev=7.1.0.35-r0 \
      libxpm-dev=3.5.13-r0 \
      libwebp-dev=1.2.2-r0 \
      php8=8.0.19-r1 \
      php8-apache2=8.0.19-r1 \
      php8-dev=8.0.19-r1 \
      php8-pear=8.0.19-r1 \
      php8-session=8.0.19-r1 \
      php8-ctype=8.0.19-r1 \
      php8-pdo=8.0.19-r1 \
      php8-iconv=8.0.19-r1 \
      php8-gd=8.0.19-r1 \
      php8-openssl=8.0.19-r1 \
      php8-mysqlnd=8.0.19-r1 \
      php8-mysqli=8.0.19-r1 \
      php8-pdo_mysql=8.0.19-r1 \
      php8-fileinfo=8.0.19-r1 \
      php8-mbstring=8.0.19-r1 \
      php8-phar=8.0.19-r1 \
&&  pecl install -o -f imagick \
&&  wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v3.2.1/omeka-s-3.2.1.zip" -O latest_omeka_s.zip \
&&  unzip -q latest_omeka_s.zip -d /var/www/ \
&&  rm latest_omeka_s.zip \
&&  rm -rf /var/www/html/ \
&&  mv /var/www/omeka-s/ /var/www/html/ \
&&  mkdir -p /var/www/html/config/ && mkdir -p /var/www/html/files/ && mkdir -p /var/www/html/modules/ && mkdir -p /var/www/html/themes/  \
&&  mkdir -p /etc/ImageMagick-6/ \
&&  cp imagemagick-policy.xml /etc/ImageMagick-6/policy.xml \
&&  cp .htaccess /var/www/html/.htaccess \
&&  cp database.ini /var/www/html/config/ \
&&  cp local.config.php /var/www/html/config/ \
&&  cp -pr files/apache2/httpd.conf /etc/apache2 \
&&  echo "ServerName localhost" >> /etc/apache2/httpd.conf \
&&  chown -R www-data:www-data /var/www/html/ \
&&  chown -R www-data:www-data /var/log/apache2/ \
&&  chown -R www-data:www-data /run/apache2/ \
&&  chmod 600 /var/www/html/config/database.ini \
&&  chmod 600 /var/www/html/config/local.config.php \
&&  chmod 600 /var/www/html/.htaccess \
&&  rm -rf /build 

WORKDIR /var/www/html

USER www-data
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
