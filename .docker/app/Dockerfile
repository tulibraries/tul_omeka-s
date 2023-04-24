FROM harbor.k8s.temple.edu/library/httpd:2.4-alpine

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.2.15-r0 \
      libxslt=1.1.37-r1 \
      tzdata=2023c-r0 \
      shared-mime-info=2.2-r2 \
      imagemagick=7.1.0.62-r0 \
      mariadb-connector-c=3.3.3-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      git=2.38.4-r1 \
      build-base=0.5-r3 \
      dpkg=1.21.9-r0 \
      libxslt-dev=1.1.37-r1 \
      mariadb-dev=10.6.12-r0 \
      mariadb-client=10.6.12-r0 \
      wget=1.21.3-r2 \
      curl=8.0.1-r0 \
      ghostscript=10.01.1-r0 \
      poppler-utils=22.11.0-r0 \
      libpng-dev=1.6.38-r0 \
      libjpeg-turbo-dev=2.1.4-r0 \
      freetype-dev=2.12.1-r0 \
      imagemagick-libs=7.1.0.62-r0 \
      imagemagick-dev=7.1.0.62-r0 \
      libxpm-dev=3.5.15-r0 \
      libwebp-dev=1.2.4-r1 \
      php81=8.1.18-r0 \
      php81-apache2=8.1.18-r0 \
      php81-dev=8.1.18-r0 \
      php81-pear=8.1.18-r0 \
      php81-session=8.1.18-r0 \
      php81-ctype=8.1.18-r0 \
      php81-pdo=8.1.18-r0 \
      php81-iconv=8.1.18-r0 \
      php81-gd=8.1.18-r0 \
      php81-openssl=8.1.18-r0 \
      php81-mysqlnd=8.1.18-r0 \
      php81-mysqli=8.1.18-r0 \
      php81-pdo_mysql=8.1.18-r0 \
      php81-fileinfo=8.1.18-r0 \
      php81-mbstring=8.1.18-r0 \
      php81-phar=8.1.18-r0 \
      php81-tokenizer=8.1.18-r0 \
&&  pecl install -o -f imagick \
&&  wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v4.0.0/omeka-s-4.0.0.zip" -O latest_omeka_s.zip \
&&  unzip -q latest_omeka_s.zip -d /var/www/ \
&&  rm latest_omeka_s.zip \
&&  rm -rf /var/www/html/ \
&&  mv /var/www/omeka-s/ /var/www/html/ \
&&  mkdir -p /var/www/html/config/ && mkdir -p /var/www/html/files/ && mkdir -p /var/www/html/modules/ && mkdir -p /var/www/html/themes/  \
&&  mkdir -p /var/log/ \
&&  chown -R nobody:nobody /var/log/apache2/ \
&&  mkdir -p /etc/ImageMagick-6/ \
&&  cp imagemagick-policy.xml /etc/ImageMagick-6/policy.xml \
&&  cp .htaccess /var/www/html/.htaccess \
&&  cp database.ini /var/www/html/config/ \
&&  cp local.config.php /var/www/html/config/ \
&&  cp -pr files/apache2/httpd.conf /etc/apache2 \
&&  cp -pr files/local/install-plugins.sh /var/www/html \
&&  echo "ServerName localhost" >> /etc/apache2/httpd.conf \
&&  chown -R nobody:nobody /var/www/html/ \
&&  chown -R nobody:nobody /run/apache2/ \
&&  chmod 600 /var/www/html/config/database.ini \
&&  chmod 600 /var/www/html/config/local.config.php \
&&  chmod 600 /var/www/html/.htaccess \
&&  chmod 700 /var/www/html/install-plugins.sh \
&&  rm -rf /build

WORKDIR /var/www/html
ENTRYPOINT ["/bin/bash"]

USER nobody
CMD ["httpd-foreground", "-d", "/etc/apache2", "-f", "/etc/apache2/httpd.conf"]
