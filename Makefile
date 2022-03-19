.DEFAULT_GOAL := help

image := misorobotics/buildpacks-google-cloud-sdk
context := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: help
help: ## Show usage information for this Makefile.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build the container locally for testing.
	pack buildpack package $(image)

.PHONY: deploy
deploy: ## Deploy the container to Docker Hub (requires authorization).
	docker push $(image)
