#!/usr/bin/env sh


if [ $OMEKA_VERSION = "" ];
then
  OMEKA_VERSION=4.0.4
fi

echo "BUILDING OMEKA (VERSION $OMEKA_VERSION)"
wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v${OMEKA_VERSION}/omeka-s-${OMEKA_VERSION}.zip" -O latest_omeka_s.zip

unzip -q latest_omeka_s.zip -d /var/www/
rm latest_omeka_s.zip
rm -rf /var/www/html/
mv /var/www/omeka-s/ /var/www/html/

cp -f -p files/omeka/application/src/Form/LoginForm.php /var/www/html/application/src/Form/
cp -f -p files/omeka/application/config/application.config.php /var/www/html/application/config/
cp -f -p files/omeka/application/view/omeka/index/index.phtml /var/www/html/application/view/omeka/index/

mkdir -p /var/www/html/config/
mkdir -p /var/www/html/files/
mkdir -p /var/www/html/modules/
mkdir -p /var/www/html/themes/
mkdir -p /var/log/
mkdir -p /etc/ImageMagick-6/

chown -R nobody:nobody /var/log/apache2/

cp imagemagick-policy.xml /etc/ImageMagick-6/policy.xml
cp .htaccess /var/www/html/.htaccess
cp database.ini /var/www/html/config/
cp local.config.php /var/www/html/config/
cp -pr files/apache2/httpd.conf /etc/apache2
cp -pr files/local/install-plugins.sh /var/www/html

echo "ServerName localhost" >> /etc/apache2/httpd.conf

chown -R nobody:nobody /var/www/html/
chown -R nobody:nobody /run/apache2/
chmod 600 /var/www/html/config/database.ini
chmod 600 /var/www/html/config/local.config.php
chmod 600 /var/www/html/.htaccess
chmod 700 /var/www/html/install-plugins.sh
rm -rf /build

echo "INSTALLING OMEKA PLUGINGS"
cd /var/www/html
su -s /bin/sh nobody -c '/var/www/html/install-plugins.sh'
