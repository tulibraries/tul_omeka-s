#!/usr/bin/env bash

install_plugin () {
  wget --no-verbose $1 -O plugin.zip
  unzip -q -o plugin.zip -d $2
  rm plugin.zip
}

theme_version () {
  url="$1"
  echo $url | sed 's:.*/::' | sed 's/\.[^.]*$//'
}

theme_name () {
  url="$1"
  echo $url | sed 's:.*/::' | sed 's/-theme-.*$/-theme/'
}

cd /tmp

# Remove unused zip files
if [ -d "/tmp/*.zip*" ]; then
  rm -rf /tmp/*.zip*
fi

# Install Modules
module_git_urls+=( \
  "https://github.com/omeka-s-modules/Mapping/releases/download/v1.8.0/Mapping-1.8.0.zip" \
  "https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.4.6/OaiPmhRepository-3.4.6.zip" \
  "https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.12.4/ImageServer-3.6.12.4.zip" \
  "https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.9/IiifServer-3.6.9.zip" \
  "https://github.com/omeka-s-modules/CSVImport/releases/download/v2.4.1/CSVImport-2.4.1.zip" \
  "https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.4.18/BulkEdit-3.4.18.zip" \
  "https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.1/CSSEditor-1.3.1.zip" \
  "https://github.com/omeka-s-modules/Omeka2Importer/releases/download/v1.5.1/Omeka2Importer-1.5.1.zip" \
  "https://github.com/omeka-s-modules/CustomVocab/releases/download/v1.7.1/CustomVocab-1.7.1.zip" \
  "https://github.com/omeka-s-modules/FileSideload/releases/download/v1.7.1/FileSideload-1.7.1.zip" \
  "https://github.com/omeka-s-modules/MetadataBrowse/releases/download/v1.6.0/MetadataBrowse-1.6.0.zip" \
  "https://github.com/Libnamic/Omeka-S-GoogleAnalytics/releases/download/v1.3.1/GoogleAnalytics-1.3.1.zip" \
)

rm -rf /var/www/html/modules/{*,.*}
for module_url in ${module_git_urls[@]}; do
  install_plugin $module_url "/var/www/html/modules/"
done

# Prepare File Sideload directory
if [ ! -d "/var/www/html/files/sideload/" ]; then
  mkdir -p "/var/www/html/files/sideload"
fi

# Install themes
theme_git_urls+=(
  "https://github.com/omeka-s-themes/default/releases/download/v1.7.1/default-1.7.1.zip" \
  "https://github.com/omeka-s-themes/papers/releases/download/v1.4.1/papers-1.4.1.zip" \
  "https://github.com/omeka-s-themes/centerrow/releases/download/v1.8.1/centerrow-1.8.1.zip" \
  "https://github.com/omeka-s-themes/cozy/releases/download/v1.6.0/theme-cozy-v1.6.0.zip" \
  "https://github.com/omeka-s-themes/foundation/releases/download/v1.4.1/foundation-1.4.1.zip" \
  "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.1.1/thanksroy-1.1.1.zip" \
  "https://github.com/omeka-s-themes/thedaily/releases/download/v1.7.0/theme-thedaily-v1.7.0.zip" \
)

temple_themes+=(
  "https://github.com/tulibraries/crnc-theme/releases/download/v0.6/crnc-theme-0.6.zip" \
  "https://github.com/tulibraries/still-theme/releases/download/0.3/still-theme-0.3.zip" \
)

theme_urls+=("${theme_git_urls[@]}" "${temple_themes[@]}")

rm -rf /var/www/html/themes/{*,.*}
for theme_url in ${theme_urls[@]}; do
    install_plugin $theme_url "/var/www/html/themes/"
done

# Remove versions from temple themes

for theme in ${temple_themes[@]}; do
  theme_version=$(theme_version $theme)
  theme_name=$(theme_name $theme)
  cd /var/www/html/themes/
  mv $theme_version $theme_name
done
