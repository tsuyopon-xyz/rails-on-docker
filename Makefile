.PHONY: help build build-local up down logs ps test
.DEFAULT_GOAL := help

up: ## Do docker compose up with hot reload
	docker compose up -d

down: ## Do docker compose down
	docker compose down

logs: ## Tail docker compose logs
	docker compose logs -f

ps: ## Check container status
	docker compose ps

build: ## build docker compose
	docker compose build

dbcreate: ## run rails db:create in docker container
	docker compose run web --rm bin/rails db:create

dbmigrate: ## run "bin/rails db:migrate"
	docker compose run web --rm bin/rails db:migrate

test: ## run "bin/rails test"
	docker compose run --rm web bin/rails test

console: ## run rails console in web(rails) container
	docker compose run --rm  web bin/rails console

webpacker_install: ## run "rails webpacker:install"
	docker compose run --rm  web bin/rails webpacker:install

login: ## login docker container of web(rails env)
	docker compose run --rm  web bash

bundle_install: ## run bundle install
	docker compose run --rm web bundle install

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'