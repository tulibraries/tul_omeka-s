#!/usr/bin/env sh
set -e

echo "BUILDING OMEKA"
git config --global --add safe.directory /build
git submodule init
git submodule update --recursive --force

cd ./omeka-s
echo "APPLY OMEKA SECURITY PATCHES"
npm audit fix --omit dev
npm install
npm install ckeditor4@4.25.0
npx gulp init

# TODO look into why omeka-s devs install ckeditor twice in two different fashions.
rm -fR ./application/asset/vendor/ckeditor
cp -fR ./node_modules/ckeditor4 ./application/asset/vendor/ckeditor


echo "UNINSTALL ALL OMEKA DEV DEPENDENCIES"
npm uninstall $(jq -r '.devDependencies | keys | join(" ")' < package.json) --save-dev
cd -

rm -rf /var/www/html/
mv ./omeka-s/ /var/www/html/

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

echo "ServerName localhost" >> /etc/apache2/httpd.conf

echo "INSTALLING OMEKA MODULES"
for dir in $(ls ./modules); do
  mv ./modules/$dir /var/www/html/modules/$dir
done


echo "INSTALLING OMEKA THEMES"
for dir in $(ls ./themes); do
  mv ./themes/$dir /var/www/html/themes/$dir
done

echo "CLEANING UP"
chown -R nobody:nobody /var/www/html/
chown -R nobody:nobody /run/apache2/
chmod 600 /var/www/html/config/database.ini
chmod 600 /var/www/html/config/local.config.php
chmod 600 /var/www/html/.htaccess

rm -rf /build
apk del build-dependencies
