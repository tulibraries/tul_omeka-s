#! /usr/bin/env sh

cd /tmp

# Install Modules
wget --no-verbose "https://github.com/omeka-s-modules/Mapping/releases/download/v1.4.1/Mapping-1.4.1.zip" && unzip Mapping-1.4.1.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.3.5.4/OaiPmhRepository-3.3.5.4.zip" && unzip OaiPmhRepository-3.3.5.4.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.7.3/ImageServer-3.6.7.3.zip" && unzip ImageServer-3.6.7.3.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.5.3/IiifServer-3.6.5.3.zip" && unzip IiifServer-3.6.5.3.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/omeka-s-modules/CSVImport/releases/download/v2.2.1/CSVImport-2.2.1.zip" && unzip CSVImport-2.2.1.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.12.4/BulkEdit-3.3.12.4.zip" && unzip BulkEdit-3.3.12.4.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/zerocrates/AltText/releases/download/v1.2.1/AltText-1.2.1.zip" && unzip AltText-1.2.1.zip -d /var/www/html/modules/ 
wget --no-verbose "https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.0/CSSEditor-1.3.0.zip" && unzip CSSEditor-1.3.0.zip -d /var/www/html/modules/ 

# Install Themes
wget --no-verbose "https://github.com/omeka-s-themes/default/releases/download/v1.6.1/theme-default-v1.6.1.zip" && unzip theme-default-v1.6.1.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/papers/releases/download/v1.3.1/theme-papers-v1.3.1.zip" && unzip theme-papers-v1.3.1.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/centerrow/releases/download/v1.6.0/theme-centerrow-v1.6.0.zip" && unzip theme-centerrow-v1.6.0.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/cozy/releases/download/v1.5.1/theme-cozy-v1.5.1.zip" && unzip theme-cozy-v1.5.1.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/foundation-s/releases/download/v1.1.0/theme-foundation-s-v1.1.0.zip" && unzip theme-foundation-s-v1.1.0.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.0.0/theme-thanksroy-v1.0.0.zip" && unzip theme-thanksroy-v1.0.0.zip -d /var/www/html/themes/
wget --no-verbose "https://github.com/omeka-s-themes/thedaily/releases/download/v1.6.1/theme-thedaily-v1.6.1.zip" && unzip theme-thedaily-v1.6.1.zip -d /var/www/html/themes/

rm *.zip
