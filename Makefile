#Defaults
include .env
export #exports the .env variables

#Set DOCKER_IMAGE_VERSION in the .env file OR by passing in
PROJECT_NAME ?= tul_omeka-s
VERSION ?= $(DOCKER_IMAGE_VERSION)
IMAGE ?= tulibraries/$(PROJECT_NAME)
HARBOR ?= harbor.k8s.temple.edu
CLEAR_CACHES ?= no
CI ?= false
OMEKA_DB_HOST ?= host.docker.internal
OMEKA_DB_NAME ?= omeka
OMEKA_DB_USER ?= omeka
OMEKA_DB_PASSWORD ?= omeka
MARIADB_ROOT_PASSWORD ?= omeka
BUILD_PROGRESS ?= auto
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
    --rm -it

showenv:
	@echo "OMEKA_DB_HOST: $(OMEKA_DB_HOST)"
	@echo "OMEKA_DB_NAME: $(OMEKA_DB_NAME)"
	@echo "OMEKA_DB_USER: $(OMEKA_DB_USER)"
	@echo "VERSION: $(VERSION)"

build: pull_db build_app

build_app:
	@docker build \
		--tag $(HARBOR)/$(IMAGE):$(VERSION) \
		--tag $(HARBOR)/$(IMAGE):latest \
		--file .docker/app/Dockerfile \
		--progress=$(BUILD_PROGRESS) \
		--no-cache .

build_src:
	@docker build \
		--tag $(HARBOR)/$(IMAGE):$(VERSION) \
		--tag $(HARBOR)/$(IMAGE):latest \
		--file .docker/app/Dockerfile.src \
		--progress=$(BUILD_PROGRESS) \
		--no-cache .

build_dev:
	@docker build \
		--progress plain \
		--tag $(IMAGE):$(VERSION)-dev \
		--tag $(IMAGE):dev \
		--file .docker/app/Dockerfile.dev \
		--progress=$(BUILD_PROGRESS) \
		--no-cache .

pull_db:
	@docker pull bitnami/mariadb:latest

up: run_db init-app run_app

init-app:
	@docker run --name=$(PROJECT_NAME) \
 		--entrypoint=/bin/sh \
		$(DEFAULT_RUN_ARGS) \
		$(HARBOR)/$(IMAGE):$(VERSION) -c '/tmp/install-plugins.sh'

run: init-app
	@docker run --name=$(PROJECT_NAME) -d -p 127.0.0.1:80:80/tcp \
		$(DEFAULT_RUN_ARGS) \
		$(HARBOR)/$(IMAGE):$(VERSION)

run_dev:
	@docker run --name=$(PROJECT_NAME)-dev -d -p 127.0.0.1:80:80/tcp \
		$(DEFAULT_RUN_ARGS) \
		--mount type=bind,source=$(PWD),target=/build \
		$(IMAGE):dev sleep infinity

run_db:
	@docker run --name=$(PROJECT_NAME)-db -d -p 127.0.0.1:3306:3306 \
	  -e MARIADB_ROOT_PASSWORD=omeka \
    -e MARIADB_DATABASE=omeka \
    -e MARIADB_USER=omeka \
    -e MARIADB_PASSWORD=omeka \
		--mount type=bind,source=$(PWD)/data/db,target=/lib/mysql \
		bitnami/mariadb:latest

shell_app:
	@docker exec -u root -it $(PROJECT_NAME) bash -l

log_app:
	@docker exec -u root -it $(PROJECT_NAME) tail -f /var/log/apache2/error.log

shell_dev:
	@docker exec -u root -it $(PROJECT_NAME)-dev bash -l

shell_db:
	@docker exec -u root -it $(PROJECT_NAME)-db bash -l

stop_dev:
	@docker stop $(PROJECT_NAME)-dev

reload_dev: stop_dev run_dev

start: start_db run_app

start_app:
	@docker start $(PROJECT_NAME)

start_db:
	@docker start $(PROJECT_NAME)-db

stop: stop_app stop_db

stop_app:
	@docker stop $(PROJECT_NAME)

stop_db:
	@docker stop $(PROJECT_NAME)-db

reload: stop_app run_app

down: down_app down_db 

down_app:
	@docker stop $(PROJECT_NAME)

down_db:
	@docker stop $(PROJECT_NAME)-db
	@docker rm $(PROJECT_NAME)-db

lint:
	@if [ $(CI) == false ]; \
		then \
			hadolint .docker/app/Dockerfile; \
		fi

shell:
	@docker run --rm -it \
		$(DEFAULT_RUN_ARGS) \
		--entrypoint=sh --user=root \
		$(HARBOR)/$(IMAGE):$(VERSION)

scan_dev:
	trivy image $(IMAGE):dev; \

scan:
	@if [ $(CLEAR_CACHES) == yes ]; \
		then \
			trivy $(HARBOR)/$(IMAGE):$(VERSION); \
		fi
	@if [ $(CI) == false ]; \
		then \
			trivy image $(HARBOR)/$(IMAGE):$(VERSION); \
		fi

deploy: scan lint
	@docker push $(HARBOR)/$(IMAGE):$(VERSION) \
	# This "if" statement needs to be a one liner or it will fail.
	# Do not edit indentation
	@if [ $(VERSION) != latest ]; \
		then \
			docker push $(HARBOR)/$(IMAGE):latest; \
		fi
