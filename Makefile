COMMIT_MSG  ?= Deploy latest changes

.PHONY: help
.PHONY: init validate fmt lint docs check
.PHONY: stage commit push ship
.PHONY: deploy

help:
	@echo "Development cycle targets (run in order):"
	@echo ""
	@echo "  make check   init-upgrade, validate, fmt, lint, docs"
	@echo "  make ship    stage, commit, push"
	@echo ""
	@echo "Roll-ups:"
	@echo "  make deploy  check + ship"
	@echo ""
	@echo "Individual steps:"
	@echo "  init      terraform init -upgrade"
	@echo "  validate  terraform validate"
	@echo "  fmt       terraform fmt --recursive"
	@echo "  lint      tflint --recursive --format=compact"
	@echo "  docs      terraform-docs ."
	@echo "  stage     git add ."
	@echo "  commit    git commit -m '\$$(COMMIT_MSG)'"
	@echo "  push      git push"
	@echo ""
	@echo "Override: COMMIT_MSG=<message>"

init:
	terraform init -upgrade

validate:
	terraform validate

fmt:
	terraform fmt --recursive

lint:
	tflint --recursive --format=compact

docs: init
	terraform-docs .

check: init validate fmt lint docs

stage:
	git add .

commit: stage
	git commit -m '$(COMMIT_MSG)'

push:
	git push

ship: commit push

deploy: check ship
	@echo ""
	@echo "Deploy triggered."
