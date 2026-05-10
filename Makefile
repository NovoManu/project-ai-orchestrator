# ==============================================================================
# PHONY TARGETS
# ==============================================================================
.PHONY: add clean-tmp init-submodules switch-to-master pull-all update-submodules \
	generate-doc-diffs reset-all \
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
# AI AGENT SKILLS - SUBMODULE SCAFFOLDING
# ==============================================================================

# Add a new GitHub repo as a submodule and generate its documentation
execute-skill-scaffold-submodule:
	copilot -i "Execute the scaffold-submodule skill"

# ==============================================================================
# AI AGENT SKILLS - DOCUMENTATION
# ==============================================================================

# Execute the update-documentation skill via Copilot CLI
execute-skill-update-documentation:
	copilot -i "Execute the update-documentation skill"

# Execute the review-and-update-documentation skill via Copilot CLI
execute-skill-review-and-update-documentation:
	copilot -i "Execute the review-and-update-documentation skill"

# ==============================================================================
# AI AGENT SKILLS - DEVELOPMENT
# ==============================================================================

# Execute the create-skill skill via Copilot CLI
execute-skill-create-skill:
	copilot -i "Execute the create-skill skill"

# Execute the investigate-codebase skill via Copilot CLI
execute-skill-investigate-codebase:
	copilot -i "Execute the investigate-codebase skill"

# Execute the code-review skill via Copilot CLI
execute-skill-code-review:
	copilot -i "Execute the code-review skill"

# Execute the implement-feature skill via Copilot CLI
execute-skill-implement-feature:
	copilot -i "Execute the implement-feature skill"

# Execute the generate-pr-description skill via Copilot CLI
execute-skill-generate-pr-description:
	copilot -i "Execute the generate-pr-description skill"
