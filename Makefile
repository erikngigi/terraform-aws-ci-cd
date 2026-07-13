# Variables
PLAN_FILE := terraform.tfplan

# Default target
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: ## Initialize providers and modules
	@echo "Initializing Terraform..."
	terraform init

.PHONY: upgrade
upgrade: ## Initialize providers upgrade
	@echo "Upgrading Terraform Providers..."
	terraform init -upgrade

.PHONY: fmt
fmt: ## Recursive formatting of all .tf files
	@echo "Formatting code..."
	terraform fmt --recursive

.PHONY: validate
validate: ## Check syntax and internal consistency
	@echo "Validating configuration..."
	terraform validate

.PHONY: plan
plan: validate ## Generate and show an execution plan
	@echo "Generating plan..."
	terraform plan -out=$(PLAN_FILE)

.PHONY: apply
apply: ## Apply the generated plan
	@if [ -f $(PLAN_FILE) ]; then \
		echo "Applying plan..."; \
		terraform apply $(PLAN_FILE); \
		rm $(PLAN_FILE); \
	else \
		echo "Error: No plan file found. Run 'make plan' first."; \
		exit 1; \
	fi

.PHONY: destroy
destroy: ## Destroy all infrastructure managed by this project
	@echo "WARNING: This will destroy your infrastructure."
	terraform destroy

.PHONY: output
output: ## Display all the infrastructure outputs managed in this project
	@echo "Generating outputs..."
	terraform output

.PHONY: breakdown
breakdown: ## Generate a JSON breakdown of the Architecture using infracost
	@echo "Generating cost breakdown using Infracost in JSON..."
	infracost breakdown --format json --out-file infracost.json

.PHONY: breakdown-terminal
breakdown-terminal: ## Generate a cost breakdown of the Terraform Architecture using infracost in the terminal
	@echo "Generating cost breakdown using Infracost in the terminal."
	infracost breakdown --path . --show-skipped

.PHONY: report
report: breakdown ## Generate and convert Infracost JSON to HTML
	@echo "Generating cost breakdown using Infracost in HTML..."
	infracost output --format html --out-file report.html && xdg-open report.html

.PHONY: clean
clean: ## Remove local cache and plan files
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
	rm -f *.tfplan
