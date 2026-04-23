COMMIT_MSG  ?= Deploy latest changes

.PHONY: help
.PHONY: init validate fmt lint docs plan check
.PHONY: stage commit push ship apply
.PHONY: deploy

help:
	@echo "Development cycle targets (run in order):"
	@echo ""
	@echo "  make check   init-upgrade, validate, fmt, lint, docs, plan"
	@echo "  make ship    stage, commit, push"
	@echo ""
	@echo "Roll-ups:"
	@echo "  make deploy  check + ship + apply"
	@echo ""
	@echo "Individual steps:"
	@echo "  init      terraform init -upgrade"
	@echo "  validate  terraform validate"
	@echo "  fmt       terraform fmt --recursive"
	@echo "  lint      tflint --recursive --format=compact"
	@echo "  docs      terraform-docs ."
	@echo "  plan      terraform plan"
	@echo "  stage     git add ."
	@echo "  commit    git commit -m '\$$(COMMIT_MSG)'"
	@echo "  push      git push"
	@echo "  apply     terraform apply"
	@echo ""
	@echo "Override: COMMIT_MSG=<message>"

init:
	terraform init -upgrade

validate:
	terraform validate

fmt:
	terraform fmt --recursive
	shfmt -i 2 -ci -w templates/user-data.sh.tftpl

lint:
	tflint --recursive --format=compact

docs: init
	terraform-docs .

plan:
	terraform plan

check: init validate fmt lint docs plan

stage:
	git add .

commit: stage
	git commit -m '$(COMMIT_MSG)'

push:
	git push

ship: commit push

apply:
	terraform apply

deploy: check ship apply
	@echo ""
	@echo "Deploy triggered."
