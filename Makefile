#Defaults
include .env
export #exports the .env variables

#Set DOCKER_IMAGE_VERSION in the .env file OR by passing in an environment variable
PROJECT_NAME ?= tul_omeka-s
VERSION ?= $(DOCKER_IMAGE_VERSION)
IMAGE ?= tulibraries/$(PROJECT_NAME)
HARBOR ?= harbor.k8s.temple.edu
CLEAR_CACHES ?= no
OMEKA_DB_HOST ?= host.docker.internal
OMEKA_DB_NAME ?= omeka
OMEKA_DB_USER ?= omeka
OMEKA_DB_PASSWORD ?= omeka
MARIADB_ROOT_PASSWORD ?= omeka
MAIL_SERVER_NAME ?= "Gmail"
MAIL_SERVER ?= "smtp.gmail.com"
MAIL_ADDRESS ?= "omeka@example.com"
MAIL_PASSWORD ?= replace_me

DEFAULT_RUN_ARGS ?= -e "EXECJS_RUNTIME=Disabled" \
    -e "K8=yes" \
    -e "OMEKA_DB_HOST=$(OMEKA_DB_HOST)" \
    -e "OMEKA_DB_NAME=$(OMEKA_DB_NAME)" \
    -e "OMEKA_DB_USER=$(OMEKA_DB_USER)" \
    -e "OMEKA_DB_PASSWORD=$(OMEKA_DB_PASSWORD)" \
    -e "MAIL_SERVER_NAME=$(MAIL_SERVER_NAME)" \
    -e "MAIL_SERVER=$(MAIL_SERVER)" \
    -e "MAIL_ADDRESS=$(MAIL_ADDRESS)" \
    -e "MAIL_PASSWORD=$(MAIL_PASSWORD)" \
    --mount type=bind,source="$(shell pwd)/volume/files",target=/var/www/html/files \
    --mount type=bind,source="$(shell pwd)/volume/modules",target=/var/www/html/modules \
    --mount type=bind,source="$(shell pwd)/volume/themes",target=/var/www/html/themes \
    --read-only \
    --mount type=bind,source="$(shell pwd)/tmpfs/log",target=/var/log/apache2 \
    --mount type=bind,source="$(shell pwd)/tmpfs/run",target=/run/apache2 \
    --mount type=bind,source="$(shell pwd)/tmpfs/tmp",target=/tmp \
    --rm -it

build: pull-db 
	@docker build \
		--tag $(HARBOR)/$(IMAGE):$(VERSION) \
		--tag $(HARBOR)/$(IMAGE):latest \
		--file .docker/app/Dockerfile \
		--no-cache .

pull-db:
	@docker pull bitnami/mariadb:latest

init-container:
	@docker run --name=$(PROJECT_NAME) -p 127.0.0.1:80:80/tcp \
		$(DEFAULT_RUN_ARGS) \
		$(HARBOR)/$(IMAGE):$(VERSION) -c '/var/www/html/install-plugins.sh'

clean-plugins:
	rm -rf volume/themes/* volume/modules/*

up: run-db run

run:
	@docker run --name=$(PROJECT_NAME) -d -p 127.0.0.1:80:80/tcp \
		$(DEFAULT_RUN_ARGS) \
		$(HARBOR)/$(IMAGE):$(VERSION)

run-db:
	@docker run --name=$(PROJECT_NAME)-db -d -p 127.0.0.1:3306:3306 \
	  -e MARIADB_ROOT_PASSWORD=omeka \
    -e MARIADB_DATABASE=omeka \
    -e MARIADB_USER=omeka \
    -e MARIADB_PASSWORD=omeka \
		--mount type=bind,source=$(PWD)/data/db,target=/lib/mysql \
		bitnami/mariadb:latest

shell-app:
	@docker exec -u root -it $(PROJECT_NAME) bash -l

shell-db:
	@docker exec -u root -it $(PROJECT_NAME)-db bash -l

stop: stop-app stop-db

stop-app:
	@docker stop $(PROJECT_NAME)

stop-db:
	@docker stop $(PROJECT_NAME)-db

reload: stop-app run

lint:
	hadolint .docker/app/Dockerfile; \

scan:
	@if [ $(CLEAR_CACHES) == yes ]; \
		then \
			trivy $(HARBOR)/$(IMAGE):$(VERSION); \
		fi
		trivy image $(HARBOR)/$(IMAGE):$(VERSION); \

deploy: scan lint
	@docker push $(HARBOR)/$(IMAGE):$(VERSION) \
	# This "if" statement needs to be a one liner or it will fail.
	# Do not edit indentation
	@if [ $(VERSION) != latest ]; \
		then \
			docker push $(HARBOR)/$(IMAGE):latest; \
		fi
