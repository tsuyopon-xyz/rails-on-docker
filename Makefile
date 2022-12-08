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

byebug: ## run debugger(byebug) on a Docker container.
	docker attach rails-tutorial-v6-web-1

# https://zenn.dev/tzover/articles/docker_tz_220406#%E7%B7%A8%E9%9B%86%E3%81%97%E3%81%9F-docker-container-%E3%81%8B%E3%82%89%E6%96%B0%E3%81%97%E3%81%84-image-%E3%82%92-local-%E3%81%AB%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B
docker_commit: ## Run this after bundle install on docker container
	#docker commit {CONTAINER_ID} rails-tutorial-v6-web

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'