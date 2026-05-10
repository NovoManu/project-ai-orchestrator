# ==============================================================================
# PHONY TARGETS
# ==============================================================================
.PHONY: add clean-tmp init-submodules switch-to-master pull-all update-submodules \
	generate-doc-diffs reset-all check-copilot \
	execute-skill-scaffold-submodule \
	execute-skill-update-documentation \
	execute-skill-review-and-update-documentation \
	execute-skill-create-skill \
	execute-skill-investigate-codebase \
	execute-skill-code-review \
	execute-skill-implement-feature \
	execute-skill-generate-pr-description

# ==============================================================================
# GIT OPERATIONS
# ==============================================================================

# Git add all files except submodule folders
# CUSTOMIZE: add ':!your-submodule-name' entries for each submodule you add
add:
	git add --all

# Remove all files inside tmp/ while keeping the directory itself
clean-tmp:
	@find ./tmp -mindepth 1 -not -name '.gitkeep' -delete
	@echo "✅ tmp/ cleaned."

# ==============================================================================
# SUBMODULE MANAGEMENT
# ==============================================================================

# Initialize and update all Git submodules recursively
init-submodules:
	git submodule update --init --recursive

# Switch all submodules to their master or main branch
switch-to-master:
	git submodule foreach 'git checkout master || git checkout main'

# Pull latest changes for parent repo and all submodules
pull-all:
	git pull --no-rebase || true
	git submodule foreach 'git checkout master || git checkout main; git pull --no-rebase'

# Update all submodules to latest commits on master/main
update-submodules:
	git submodule foreach 'git checkout master || git checkout main; git pull --no-rebase'

# Fetch origin/master for all submodules (or one via SERVICE=<name>), diff each
# against its doc-refs.yaml baseline, save diffs to tmp/diffs/, and advance doc-refs.yaml.
#   make generate-doc-diffs
#   make generate-doc-diffs SERVICE=service-a
generate-doc-diffs:
	@./tools/generate_diffs.sh $(SERVICE)

# Hard reset all submodules to HEAD (requires confirmation)
reset-all:
	@echo "WARNING: This will hard reset ALL submodules to HEAD, discarding any uncommitted changes."
	@read -p "Are you sure you want to continue? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		git submodule foreach 'git reset --hard HEAD'; \
	else \
		echo "Aborted."; \
	fi

# ==============================================================================
# AI AGENT SKILLS (GitHub Copilot CLI)
# ==============================================================================
# make execute-skill-* runs `copilot -i "..."`. Install: brew install copilot-cli
# or npm install -g @github/copilot — see README. Override: make COPILOT=/path/to/copilot …
COPILOT ?= copilot

# Fail fast with install hints when `copilot` is missing (Error 127)
check-copilot:
	@command -v $(COPILOT) >/dev/null 2>&1 || { \
		printf '%s\n' \
			"error: $(COPILOT) (GitHub Copilot CLI) not found." \
			"" \
			"Install (pick one):" \
			"  brew install copilot-cli" \
			"  npm install -g @github/copilot" \
			"  curl -fsSL https://gh.io/copilot-install | bash" \
			"" \
			"Docs: https://docs.github.com/copilot/how-tos/use-cli/install-copilot-cli" \
			"" \
			"Without the CLI, use plain Git and the skill checklist:" \
			"  git submodule add <repo-url> <folder>" \
			"  See .github/skills/scaffold-submodule/SKILL.md" >&2; \
		exit 127; \
	}

# ==============================================================================
# AI AGENT SKILLS - SUBMODULE SCAFFOLDING
# ==============================================================================

# Add a new GitHub repo as a submodule and generate its documentation
execute-skill-scaffold-submodule: check-copilot
	$(COPILOT) -i "Execute the scaffold-submodule skill"

# ==============================================================================
# AI AGENT SKILLS - DOCUMENTATION
# ==============================================================================

# Execute the update-documentation skill via Copilot CLI
execute-skill-update-documentation: check-copilot
	$(COPILOT) -i "Execute the update-documentation skill"

# Execute the review-and-update-documentation skill via Copilot CLI
execute-skill-review-and-update-documentation: check-copilot
	$(COPILOT) -i "Execute the review-and-update-documentation skill"

# ==============================================================================
# AI AGENT SKILLS - DEVELOPMENT
# ==============================================================================

# Execute the create-skill skill via Copilot CLI
execute-skill-create-skill: check-copilot
	$(COPILOT) -i "Execute the create-skill skill"

# Execute the investigate-codebase skill via Copilot CLI
execute-skill-investigate-codebase: check-copilot
	$(COPILOT) -i "Execute the investigate-codebase skill"

# Execute the code-review skill via Copilot CLI
execute-skill-code-review: check-copilot
	$(COPILOT) -i "Execute the code-review skill"

# Execute the implement-feature skill via Copilot CLI
execute-skill-implement-feature: check-copilot
	$(COPILOT) -i "Execute the implement-feature skill"

# Execute the generate-pr-description skill via Copilot CLI
execute-skill-generate-pr-description: check-copilot
	$(COPILOT) -i "Execute the generate-pr-description skill"
