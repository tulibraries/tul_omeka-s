FROM harbor.k8s.temple.edu/library/httpd:2.4-alpine

WORKDIR /build

COPY . .

USER root

ENV PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkgconfig re2c"

RUN apk add -U --no-cache \
      bash=5.2.21-r0 \
      libxslt=1.1.39-r0 \
      tzdata=2023d-r0 \
      shared-mime-info=2.4-r0 \
      imagemagick=7.1.1.22-r0 \
      mariadb-connector-c=3.3.8-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      git=2.43.0-r0 \
      build-base=0.5-r3 \
      dpkg=1.22.1-r0 \
      libxslt-dev=1.1.39-r0 \
      mariadb-dev=10.11.5-r3 \
      mariadb-client=10.11.5-r3 \
      wget=1.21.4-r0 \
      curl=8.5.0-r0 \
      ghostscript=10.02.1-r0 \
      poppler-utils=23.10.0-r0 \
      libpng-dev=1.6.40-r0 \
      libjpeg-turbo-dev=3.0.1-r0 \
      freetype-dev=2.13.2-r0 \
      imagemagick-libs=7.1.1.22-r0 \
      imagemagick-dev=7.1.1.22-r0 \
      libxpm-dev=3.5.17-r0 \
      libwebp-dev=1.3.2-r0 \
      php81=8.1.27-r0 \
      php81-apache2=8.1.27-r0 \
      php81-dev=8.1.27-r0 \
      php81-pear=8.1.27-r0 \
      php81-session=8.1.27-r0 \
      php81-ctype=8.1.27-r0 \
      php81-pdo=8.1.27-r0 \
      php81-iconv=8.1.27-r0 \
      php81-gd=8.1.27-r0 \
      php81-openssl=8.1.27-r0 \
      php81-mysqlnd=8.1.27-r0 \
      php81-mysqli=8.1.27-r0 \
      php81-pdo_mysql=8.1.27-r0 \
      php81-fileinfo=8.1.27-r0 \
      php81-mbstring=8.1.27-r0 \
      php81-phar=8.1.27-r0 \
      php81-tokenizer=8.1.27-r0 \
      php81-pecl-imagick=3.7.0-r4 \
&&  wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v4.0.4/omeka-s-4.0.4.zip" -O latest_omeka_s.zip \
&&  unzip -q latest_omeka_s.zip -d /var/www/ \
&&  rm latest_omeka_s.zip \
&&  rm -rf /var/www/html/ \
&&  mv /var/www/omeka-s/ /var/www/html/ \
&&  cp -f -p files/omeka/application/src/Form/LoginForm.php /var/www/html/application/src/Form/ \
&&  cp -f -p files/omeka/application/config/application.config.php /var/www/html/application/config/ \
&&  cp -f -p files/omeka/application/view/omeka/index/index.phtml /var/www/html/application/view/omeka/index/ \
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
