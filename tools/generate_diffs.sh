#!/bin/bash
set -e

# Usage:
#   ./tools/generate_diffs.sh [service-name]
#
# Without arguments: processes all submodules.
# With a service name: processes only that submodule.

# Directory to store diffs
DIFF_DIR="tmp/diffs"
DOC_REFS="doc-refs.yaml"
mkdir -p "$DIFF_DIR"

TARGET_SERVICE="${1:-}"

if [ -n "$TARGET_SERVICE" ]; then
    echo "Cleaning old diff for $TARGET_SERVICE in $DIFF_DIR..."
    rm -f "$DIFF_DIR/${TARGET_SERVICE}.diff"
    SUBMODULES="$TARGET_SERVICE"
else
    echo "Cleaning old diffs in $DIFF_DIR..."
    rm -f "$DIFF_DIR"/*.diff
    SUBMODULES=$(git submodule --quiet foreach 'echo $name')
fi

# Read the documentation baseline commit for a submodule from doc-refs.yaml.
get_doc_ref() {
    local name="$1"
    grep "^${name}:" "$DOC_REFS" 2>/dev/null | awk '{print $2}'
}

for submodule in $SUBMODULES; do
    # Get the path of the submodule
    path=$(git config -f .gitmodules submodule."$submodule".path)

    # Fetch latest default branch from remote (supports both master and main).
    echo "  Fetching $path..."
    (cd "$path" && git fetch origin master --quiet 2>/dev/null || git fetch origin main --quiet)

    # Get the latest remote default branch commit.
    NEW_SHA=$(cd "$path" && {
        if git show-ref --verify --quiet refs/remotes/origin/master; then
            git rev-parse origin/master
        elif git show-ref --verify --quiet refs/remotes/origin/main; then
            git rev-parse origin/main
        else
            git rev-parse HEAD
        fi
    })
    if [ -z "$NEW_SHA" ]; then
        echo "Skipping $path: not initialized"
        continue
    fi

    # Get the documentation baseline commit from doc-refs.yaml
    OLD_SHA=$(get_doc_ref "$submodule")

    # If the service has no entry yet, seed it with NEW_SHA and move on
    # (no diff to generate; the key is now present for future runs).
    if ! grep -q "^${submodule}:" "$DOC_REFS"; then
        echo "  $submodule not in doc-refs.yaml — seeding with $NEW_SHA"
        echo "${submodule}: ${NEW_SHA}" >> "$DOC_REFS"
        continue
    fi

    if [ "$OLD_SHA" = "$NEW_SHA" ]; then
        echo "No change for $path (both at $OLD_SHA)"
        continue
    fi

    if [ -n "$OLD_SHA" ]; then
        echo "  Generating diff from $OLD_SHA to $NEW_SHA..."

        # Generate the diff file with a summary and full diff.
        (cd "$path" && \
         echo "Diff for $path ($OLD_SHA -> $NEW_SHA)" > "../$DIFF_DIR/${path}.diff" && \
         echo "==================================================" >> "../$DIFF_DIR/${path}.diff" && \
         git diff --stat "$OLD_SHA..$NEW_SHA" >> "../$DIFF_DIR/${path}.diff" && \
         echo "" >> "../$DIFF_DIR/${path}.diff" && \
         git diff "$OLD_SHA..$NEW_SHA" >> "../$DIFF_DIR/${path}.diff")

        echo "  Saved to $DIFF_DIR/${path}.diff"

        # Advance the documentation baseline to the new commit.
        sed -i.bak "s|^${submodule}: .*|${submodule}: ${NEW_SHA}|" "$DOC_REFS"
        rm -f "${DOC_REFS}.bak"
    else
        echo "  Could not determine baseline commit for $path, skipping"
    fi
done

echo "Diff generation complete. Check $DIFF_DIR/. doc-refs.yaml advanced for all processed services."
