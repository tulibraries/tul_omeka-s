FROM harbor.k8s.temple.edu/library/alpine:3.13

WORKDIR /build

COPY . .

USER root

RUN apk add -U --no-cache \
      bash=5.1.0-r0 \
      libxslt=1.1.34-r0 \
      tzdata=2021e-r0 \
      shared-mime-info=2.0-r0 \
      imagemagick=7.0.11.13-r0 \
      mariadb-connector-c=3.1.11-r0 \
&&  apk add -U --no-cache --virtual build-dependencies \
      git=2.30.2-r0 \
      build-base=0.5-r2 \
      libxslt-dev=1.1.34-r0 \
      mariadb-dev=10.5.12-r0 \
      mariadb-client=10.5.12-r0 \
      php7=7.4.25-r0 \
      wget=1.21.1-r1 \
      ghostscript=9.53.3-r1 \
      poppler-utils=20.12.1-r0 
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip" && unzip awscliv2.zip && aws/install 

RUN wget https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions 
RUN chmod +x install-php-extensions
RUN ./install-php-extensions gd xdebug

RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ 
RUN docker-php-ext-install -j"$(nproc)" iconv pdo pdo_mysql mysqli gd 
RUN yes | pecl install  mcrypt-1.0.3 || echo "pecl install encrypt: $?" 
RUN docker-php-ext-enable mcrypt || echo "docker-pop-ext-enable mcrypt: $?" 
RUN yes | pecl install imagick || echo "pecl install imagick $?" && docker-php-ext-enable imagick 
RUN wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v3.1.1/omeka-s-3.1.1.zip" -O /var/www/latest_omeka_s.zip \
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
