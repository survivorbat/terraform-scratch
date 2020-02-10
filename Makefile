SHELL := /bin/bash

MAKEFLAGS := --no-print-directory

.DEFAULT_GOAL := help

.PHONY := help build

help: ## Show the list of commands
	@echo "Please use 'make <target>' where <target> is one of"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9\._-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the image locally
	docker build . -t survivorbat/terraform-scratch:development
	docker build . -t survivorbat/terraform-scratch:development-alpine --target alpine
