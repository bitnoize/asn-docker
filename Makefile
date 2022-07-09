
.PHONY: help build push run stop logs ps

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build push run stop logs ps"

build:
	docker compose build --no-cache

push:
	docker compose push

run:
	docker compose up -d

stop:
	docker compose stop

logs:
	docker compose logs --tail=100 -f

ps:
	docker compose ps

