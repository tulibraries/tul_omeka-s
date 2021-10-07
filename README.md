# tul_omeka-s

*DRAFT*

# Mounted Volumes for Persistence

- Rancher Workload
- Edit workload
- Volumes >> Add Volume
	- Add a new persistent volume (claim)
	- Name: Name the volume. e.g. "tul-omeka-prototype-volume"
		- Note: Use alphanumerics separated by hyphens. Underscores not accepted
	- Add a description (Optional)
	- Source: Select "Use a Storage Class to provision a new persistent volume"
	- Storage Class: "Use the default class"
	- Request Storage: e.g. 2 GiB
	- Access Mode: " Single Node Read-Write"
	- >> Define
		- Volume name: As defined above
		- Mount Point: /var/www/html/files
		- Subpath in Volume: files
	- >> Add Mount (if needed)
		- Volume name: As defined above
		- Mount Point:/var/www/html/modules
		- Subpath in Volume: modules
	- >> Add Mount (if needed)
		- Volume name: As defined above
		- Mount Point: /var/www/html/themes
		- Subpath in Volume: themes
	- >> Save (bottom of form)
- Workload will update, Status: "updating workload"
- Rancho Workload Dashboard
- Scroll to tul-omeka-s workload
- Click on menu (Three dots on right)
- Verify mounted volumes `ls`
	- Note mounted volumes are owned by `root`
- Change owner and group of mounted volumes

```
$ chown -R www-data:www-data files modules themes
$ exit
```

# Install Extensions

1. In browser, visit the Rancho Workload Dashboard
2. Scroll to tul-omeka-s workload
3. Click on menu (Three dots on right)
4. Select "Execute Shell"
5. To Install Modules
	1. `cd modules`
	2. `wget [module url]`
	3. `unzip [downloaded zip file]`
	4. `chown -R www-data:www-data [unzipped directory]`
	5. `rm [downloaded zip file]`
6. To Install Themes
	1. `cd themes`
	2. `wget [theme url]`
	3. `unzip [downloaded zip file]`
	4. `chown -R www-data:www-data [unzipped directory]`
	5. `rm [downloaded zip file]`
7. `exit`

As an administrative user on the Omeka Web Application, modules are activated and configured
from the Admin menu on the left side of the administration dashboard.  Themes are selected
and configured from the Sites menu item on the left side of the administrative dashboard.

## Module List

- https://github.com/omeka-s-modules/Mapping/releases/download/v1.4.1/Mapping-1.4.1.zip"
- https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.3.5.4/OaiPmhRepository-3.3.5.4.zip"
- https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.7.3/ImageServer-3.6.7.3.zip
- https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.5.3/IiifServer-3.6.5.3.zip" 
- https://github.com/omeka-s-modules/CSVImport/releases/download/v2.2.1/CSVImport-2.2.1.zip
- https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.12.4/BulkEdit-3.3.12.4.zip
- https://github.com/zerocrates/AltText/releases/download/v1.2.1/AltText-1.2.1.zip
- https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.0/CSSEditor-1.3.0.zip

## Themes List

- https://github.com/omeka-s-themes/default/releases/download/v1.6.1/theme-default-v1.6.1.zip
- https://github.com/omeka-s-themes/papers/releases/download/v1.3.1/theme-papers-v1.3.1.zip
- https://github.com/omeka-s-themes/centerrow/releases/download/v1.6.0/theme-centerrow-v1.6.0.zip
- https://github.com/omeka-s-themes/cozy/releases/download/v1.5.1/theme-cozy-v1.5.1.zip
- https://github.com/omeka-s-themes/foundation-s/releases/download/v1.1.0/theme-foundation-s-v1.1.0.zip
- https://github.com/omeka-s-themes/thanksroy/releases/download/v1.0.0/theme-thanksroy-v1.0.0.zip
- https://github.com/omeka-s-themes/thedaily/releases/download/v1.6.1/theme-thedaily-v1.6.1.zip
