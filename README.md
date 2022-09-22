# Temple University Libary Exhibits (tul_omeka-s)

## Deployment
This application is deployed with a Helm Chart that is located in Temple Libraries private Gitlab repository.  Access to the repository and the QA application require the user to be logged in to the Temple VPN.

The QA site can be found at https://exhibits-qa.k8s.temple.edu.

## Getting Started
We defined a Makefile with many useful commands for local development. These commands replicate the process used to deploy in the Gitlab pipeline.

There are also some directories that you will need to create locally.  Directories that should not be committed to GitHub are included in the .gitignore file.
- `mkdir -p data/db`
- `mkdir -p files/apache2`
- `mkdir -p files/local`
- `mkdir -p volume/modules`
- `mkdir -p volume/themes`
- `mkdir -p volume/files`
- `mkdir -p volume/log`
- `mkdir -p tmpfs/tmp`
- `mkdir -p tmpfs/run/apache2`

To start up a local instance, run the following make commands. You will need to be logged into the Temple VPN in order to access the Harbor images.   
- `make build`
- `make up`

Once the application is running, it can be accessed at http://localhost:80. You will need to create a user in order to enter the application.

## Install Extensions

1. In browser, visit the Rancher Workload Dashboard
2. Scroll to tul-omeka-s workload
3. Click on menu (Three dots on right)
4. Select "Execute Shell"
5. To Install Modules
	1. `cd modules`
	2. `wget [module url]`
	3. `unzip [downloaded zip file]`
	4. `chown -R nobody:nobody [unzipped directory]`
	5. `rm [downloaded zip file]`
6. To Install Themes
	1. `cd themes`
	2. `wget [theme url]`
	3. `unzip [downloaded zip file]`
	4. `chown -R nobody:nobody [unzipped directory]`
	5. `rm [downloaded zip file]`
7. `exit`

As an administrative user on the Omeka Web Application, modules are activated and configured
from the Admin menu on the left side of the administration dashboard.  Themes are selected
and configured from the Sites menu item on the left side of the administrative dashboard.

### Module List

- https://github.com/omeka-s-modules/Mapping/releases/download/v1.4.1/Mapping-1.4.1.zip"
- https://github.com/Daniel-KM/Omeka-S-module-OaiPmhRepository/releases/download/3.3.5.4/OaiPmhRepository-3.3.5.4.zip"
- https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/3.6.7.3/ImageServer-3.6.7.3.zip
- https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/3.6.5.3/IiifServer-3.6.5.3.zip" 
- https://github.com/omeka-s-modules/CSVImport/releases/download/v2.2.1/CSVImport-2.2.1.zip
- https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.12.4/BulkEdit-3.3.12.4.zip
- https://github.com/zerocrates/AltText/releases/download/v1.2.1/AltText-1.2.1.zip
- https://github.com/omeka-s-modules/CSSEditor/releases/download/v1.3.0/CSSEditor-1.3.0.zip

### Themes List

- https://github.com/omeka-s-themes/default/releases/download/v1.6.1/theme-default-v1.6.1.zip
- https://github.com/omeka-s-themes/papers/releases/download/v1.3.1/theme-papers-v1.3.1.zip
- https://github.com/omeka-s-themes/centerrow/releases/download/v1.6.0/theme-centerrow-v1.6.0.zip
- https://github.com/omeka-s-themes/cozy/releases/download/v1.5.1/theme-cozy-v1.5.1.zip
- https://github.com/omeka-s-themes/foundation-s/releases/download/v1.1.0/theme-foundation-s-v1.1.0.zip
- https://github.com/omeka-s-themes/thanksroy/releases/download/v1.0.0/theme-thanksroy-v1.0.0.zip
- https://github.com/omeka-s-themes/thedaily/releases/download/v1.6.1/theme-thedaily-v1.6.1.zip



