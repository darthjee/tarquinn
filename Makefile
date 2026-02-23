.PHONY: build dev test rubocop yard logs stop

## Build the Docker image
build:
	docker compose build base_build

## Start an interactive bash session inside the container
dev:
	docker compose run --rm tarquinn /bin/bash

## Run RSpec tests inside the container
test:
	docker compose run --rm tarquinn /bin/bash -c 'rspec'

## Run RuboCop inside the container
rubocop:
	docker compose run --rm tarquinn /bin/bash -c 'rubocop'

## Run the full CI-equivalent check suite (tests + YARD coverage)
test_all:
	docker compose run --rm test_all

## Stop all running containers
stop:
	docker compose down

## Show logs for running containers
logs:
	docker compose logs -f
