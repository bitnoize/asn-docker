
.PHONY: help build rebuild push pull up down logs ps

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull up down logs ps"

build:
	docker compose build

rebuild:
	docker compose build --pull --no-cache

push:
	docker compose push

pull:
	docker compose pull

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs --tail=100 -f

ps:
	docker compose ps

