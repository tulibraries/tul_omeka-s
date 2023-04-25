#!/usr/bin/env bash

install_plugin () {
  is_temple_theme=$(is_temple_theme $1)
  theme_version=$(theme_version $1)
  theme_name=$(theme_name $1)

  wget --no-verbose $1 -O plugin.zip
  unzip -q -o plugin.zip -d $2
  rm plugin.zip
  sleep 10
  if [[ $is_temple_theme -eq 1 ]]; then
    mv $theme_version $theme_name
  fi
}

is_temple_theme () {
  if [[ $1 =~ "crnc" ]] || [[ $1 =~ "still" ]]; then
    echo 1
  else
    echo 0
  fi
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
)

rm -rf /var/www/html/modules/{*,.*}
for module_url in ${module_git_urls[@]}; do
  install_plugin $module_url "/var/www/html/modules/"
done

# Install themes
theme_git_urls+=( \
  "https://github.com/omeka-s-themes/default/releases/download/v1.7.1/default-1.7.1.zip" \
  "https://github.com/omeka-s-themes/papers/releases/download/v1.4.1/papers-1.4.1.zip" \
  "https://github.com/omeka-s-themes/centerrow/releases/download/v1.8.1/centerrow-1.8.1.zip" \
  "https://github.com/omeka-s-themes/cozy/releases/download/v1.6.0/theme-cozy-v1.6.0.zip" \
  "https://github.com/omeka-s-themes/foundation/releases/download/v1.3.3/foundation-1.3.3.zip" \
  "https://github.com/omeka-s-themes/thanksroy/releases/download/v1.1.1/thanksroy-1.1.1.zip" \
  "https://github.com/omeka-s-themes/thedaily/releases/download/v1.7.0/theme-thedaily-v1.7.0.zip" \
  "https://github.com/tulibraries/crnc-theme/releases/download/v0.6/crnc-theme-0.6.zip" \
  "https://github.com/tulibraries/still-theme/releases/download/v0.2/still-theme-0.2.zip" \
)

rm -rf /var/www/html/themes/{*,.*}
for theme_url in ${theme_git_urls[@]}; do
    install_plugin $theme_url "/var/www/html/themes/"
done
