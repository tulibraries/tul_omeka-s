#! /usr/bin/env sh

cd /tmp

# Remove unused Directories
if [ -d "/var/www/html/modules/AltText" ]; then
  rm -rf /var/www/html/modules/AltText
fi

# Install Modules
wget --no-verbose "https://github.com/omeka-s-modules/Mapping/releases/download/v1.4.1/Mapping-1.4.1.zip" && unzip -o Mapping-1.4.1.zip -d /var/www/html/modules/ && rm Mapping-1.4.1.zip 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.3.5.4/OaiPmhRepository-3.3.5.4.zip" && unzip -o OaiPmhRepository-3.3.5.4.zip -d /var/www/html/modules/ && rm OaiPmhRepository-3.3.5.4.zip 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.7.3/ImageServer-3.6.7.3.zip" && unzip -o ImageServer-3.6.7.3.zip -d /var/www/html/modules/ && rm ImageServer-3.6.7.3.zip 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.5.3/IiifServer-3.6.5.3.zip" && unzip -o IiifServer-3.6.5.3.zip -d /var/www/html/modules/ && rm IiifServer-3.6.5.3.zip 
wget --no-verbose "https://github.com/omeka-s-modules/CSVImport/releases/download/v2.2.1/CSVImport-2.2.1.zip" && unzip -o CSVImport-2.2.1.zip -d /var/www/html/modules/ && rm CSVImport-2.2.1.zip 
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.12.4/BulkEdit-3.3.12.4.zip" && unzip -o BulkEdit-3.3.12.4.zip -d /var/www/html/modules/ && rm BulkEdit-3.3.12.4.zip 
wget --no-verbose "https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.0/CSSEditor-1.3.0.zip" && unzip -o CSSEditor-1.3.0.zip -d /var/www/html/modules/ && rm CSSEditor-1.3.0.zip 

# Install Themes
wget --no-verbose "https://github.com/omeka-s-themes/default/releases/download/v1.6.1/theme-default-v1.6.1.zip" && unzip -o theme-default-v1.6.1.zip -d /var/www/html/themes/ && rm theme-default-v1.6.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/papers/releases/download/v1.3.1/theme-papers-v1.3.1.zip" && unzip -o theme-papers-v1.3.1.zip -d /var/www/html/themes/ && rm theme-papers-v1.3.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/centerrow/releases/download/v1.6.0/theme-centerrow-v1.6.0.zip" && unzip -o theme-centerrow-v1.6.0.zip -d /var/www/html/themes/&& rm theme-centerrow-v1.6.0.zip 
wget --no-verbose "https://github.com/omeka-s-themes/cozy/releases/download/v1.5.1/theme-cozy-v1.5.1.zip" && unzip -o theme-cozy-v1.5.1.zip -d /var/www/html/themes/ && rm theme-cozy-v1.5.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/foundation-s/releases/download/v1.1.0/theme-foundation-s-v1.1.0.zip" && unzip -o theme-foundation-s-v1.1.0.zip -d /var/www/html/themes/ && rm theme-foundation-s-v1.1.0.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.0.0/theme-thanksroy-v1.0.0.zip" && unzip -o theme-thanksroy-v1.0.0.zip -d /var/www/html/themes/ && rm theme-thanksroy-v1.0.0.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thedaily/releases/download/v1.6.1/theme-thedaily-v1.6.1.zip" && unzip -o theme-thedaily-v1.6.1.zip -d /var/www/html/themes/ && rm theme-thedaily-v1.6.1.zip 

# Secure plugins and custom modifications
chown -R nobody:nobody /var/www/html/modules
chown -R nobody:nobody /var/www/html/themes
chown -R nobody:nobody /var/www/html/files
