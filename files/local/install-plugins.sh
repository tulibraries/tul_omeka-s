#! /usr/bin/env sh

cd /tmp

# Remove unused zip files
if [ -d "/tmp/*.zip*" ]; then
  rm -rf /tmp/*.zip*
fi

# Install Modules
wget --no-verbose "https://github.com/omeka-s-modules/Mapping/releases/download/v1.8.0/Mapping-1.8.0.zip" && unzip -o Mapping-1.8.0.zip -d /var/www/html/modules/ && rm Mapping-1.8.0.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.4.6/OaiPmhRepository-3.4.6.zip" && unzip -o OaiPmhRepository-3.4.6.zip -d /var/www/html/modules/ && rm OaiPmhRepository-3.4.6.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.12.4/ImageServer-3.6.12.4.zip" && unzip -o ImageServer-3.6.12.4.zip -d /var/www/html/modules/ && rm ImageServer-3.6.12.4.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.9/IiifServer-3.6.9.zip" && unzip -o IiifServer-3.6.9.zip -d /var/www/html/modules/ && rm IiifServer-3.6.9.zip
wget --no-verbose "https://github.com/omeka-s-modules/CSVImport/releases/download/v2.4.1/CSVImport-2.4.1.zip" && unzip -o CSVImport-2.4.1.zip -d /var/www/html/modules/ && rm CSVImport-2.4.1.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.4.18/BulkEdit-3.4.18.zip" && unzip -o BulkEdit-3.4.18.zip -d /var/www/html/modules/ && rm BulkEdit-3.4.18.zip
wget --no-verbose "https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.1/CSSEditor-1.3.1.zip" && unzip -o CSSEditor-1.3.1.zip -d /var/www/html/modules/ && rm CSSEditor-1.3.1.zip
wget --no-verbose "https://github.com/omeka-s-modules/Omeka2Importer/releases/download/v1.5.1/Omeka2Importer-1.5.1.zip" && unzip -o Omeka2Importer-1.5.1.zip -d /var/www/html/modules/ && rm Omeka2Importer-1.5.1.zip

# Install Themes
wget --no-verbose "https://github.com/omeka-s-themes/default/releases/download/v1.7.1/default-1.7.1.zip" && unzip -o default-1.7.1.zip -d /var/www/html/themes/ && rm default-1.7.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/papers/releases/download/v1.4.1/papers-1.4.1.zip" && unzip -o papers-1.4.1.zip -d /var/www/html/themes/ && rm papers-1.4.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/centerrow/releases/download/v1.8.1/centerrow-1.8.1.zip" && unzip -o centerrow-1.8.1.zip -d /var/www/html/themes/&& rm centerrow-1.8.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/cozy/releases/download/v1.6.0/theme-cozy-v1.6.0.zip" && unzip -o theme-cozy-v1.6.0.zip -d /var/www/html/themes/ && rm theme-cozy-v1.6.0.zip 
wget --no-verbose "https://github.com/omeka-s-themes/foundation/releases/download/v1.3.3/foundation-1.3.3.zip" && unzip -o foundation-1.3.3.zip -d /var/www/html/themes/ && rm foundation-1.3.3.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.1.1/thanksroy-1.1.1.zip" && unzip -o thanksroy-1.1.1.zip -d /var/www/html/themes/ && rm thanksroy-1.1.1.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thedaily/releases/download/v1.7.0/theme-thedaily-v1.7.0.zip" && unzip -o theme-thedaily-v1.7.0.zip -d /var/www/html/themes/ && rm theme-thedaily-v1.7.0.zip 
wget --no-verbose "https://github.com/tulibraries/centerrow-temple/archive/refs/tags/v0.2.zip" && unzip -o v0.2.zip -d /var/www/html/themes/ && rm v0.2.zip 
