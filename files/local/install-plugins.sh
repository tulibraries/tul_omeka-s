#! /usr/bin/env sh

cd /tmp

# Remove unused zip files
if [ -d "/tmp/*.zip*" ]; then
  rm -rf /tmp/*.zip*
fi

# Install Modules
wget --no-verbose "https://github.com/omeka-s-modules/Mapping/releases/download/v1.8.0/Mapping-1.8.0.zip" -O Mapping.zip && unzip -q -o Mapping.zip -d /var/www/html/modules/ && rm Mapping.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.4.6/OaiPmhRepository-3.4.6.zip" -O OaiPmhRepository.zip && unzip -q -o OaiPmhRepositoryzip -d /var/www/html/modules/ && rm OaiPmhRepository.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.12.4/ImageServer-3.6.12.4.zip" -O ImageServer.zip && unzip -q -o ImageServer.zip -d /var/www/html/modules/ && rm ImageServer.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.9/IiifServer-3.6.9.zip" -O IiifServer.zip && unzip -q -o IiifServer.zip -d /var/www/html/modules/ && rm IiifServer.zip
wget --no-verbose "https://github.com/omeka-s-modules/CSVImport/releases/download/v2.4.1/CSVImport-2.4.1.zip" -O CSVImport.zip && unzip -q -o CSVImport.zip -d /var/www/html/modules/ && rm CSVImport.zip
wget --no-verbose "https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.4.18/BulkEdit-3.4.18.zip" -O BulkEdit.zip && unzip -q -o BulkEdit.zip -d /var/www/html/modules/ && rm BulkEdit.zip
wget --no-verbose "https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.1/CSSEditor-1.3.1.zip" -O CSSEditor.zip && unzip -q -o CSSEditor.zip -d /var/www/html/modules/ && rm CSSEditor.zip
wget --no-verbose "https://github.com/omeka-s-modules/Omeka2Importer/releases/download/v1.5.1/Omeka2Importer-1.5.1.zip" -O Omeka2Importer.zip && unzip -q -o Omeka2Importer.zip -d /var/www/html/modules/ && rm Omeka2Importer.zip

# Install Themes
wget --no-verbose "https://github.com/omeka-s-themes/default/releases/download/v1.7.1/default-1.7.1.zip" -O default.zip && unzip -q -o default.zip -d /var/www/html/themes/ && rm default.zip 
wget --no-verbose "https://github.com/omeka-s-themes/papers/releases/download/v1.4.1/papers-1.4.1.zip" -O papers.zip && unzip -q -o papers.zip -d /var/www/html/themes/ && rm papers.zip 
wget --no-verbose "https://github.com/omeka-s-themes/centerrow/releases/download/v1.8.1/centerrow-1.8.1.zip" -O centerrow.zip && unzip -q -o centerrow.zip -d /var/www/html/themes/&& rm centerrow.zip 
wget --no-verbose "https://github.com/omeka-s-themes/cozy/releases/download/v1.6.0/theme-cozy-v1.6.0.zip" -O theme-cozy.zip && unzip -q -o theme-cozy.zip -d /var/www/html/themes/ && rm theme-cozy.zip 
wget --no-verbose "https://github.com/omeka-s-themes/foundation/releases/download/v1.3.3/foundation-1.3.3.zip" -O foundation.zip && unzip -q -o foundation.zip -d /var/www/html/themes/ && rm foundation.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.1.1/thanksroy-1.1.1.zip" -O thanksroy.zip && unzip -q -o thanksroy.zip -d /var/www/html/themes/ && rm thanksroy.zip 
wget --no-verbose "https://github.com/omeka-s-themes/thedaily/releases/download/v1.7.0/theme-thedaily-v1.7.0.zip" -O theme-thedaily.zip && unzip -q -o theme-thedaily.zip -d /var/www/html/themes/ && rm theme-thedaily.zip 
wget --no-verbose "https://github.com/tulibraries/centerrow-temple/archive/refs/tags/v0.2.zip" -O centerrow-temple.zip && unzip -q -o centerrow-temple.zip -d /var/www/html/themes/ && rm centerrow-temple.zip 
