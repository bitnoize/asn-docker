
IMAGENAME := ghcr.io/bitnoize/asn

.PHONY: help build rebuild push pull

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull"

#build: export BUILD_OPTS := ...
build: .build-bullseye

rebuild: export BUILD_OPTS := --pull --no-cache
rebuild: .build-bullseye

.build-bullseye:
	docker build $(BUILD_OPTS) \
		-t "$(IMAGENAME):bullseye" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bullseye \
		.

#push: export PUSH_OPTS := ...
push: .push-bullseye

.push-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

#pull: export PULL_OPTS := ...
pull: .pull-bullseye

.pull-bullseye:
	docker pull $(PULL_OPTS) "$(IMAGENAME):bullseye"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

