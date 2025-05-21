# Load environment variables from .env file
include .env

HELM = microk8s helm3

.PHONY: help
help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: deploy_keel
deploy_keel: ## https://keel.sh/docs/#environment-variables
	@$(HELM) repo add keel https://charts.keel.sh; \
	$(HELM) repo update; \
	$(HELM) upgrade --install keel keel/keel -n keel --create-namespace