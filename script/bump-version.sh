#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST="$REPO_DIR/typst.toml"

NEW_VERSION="${1:-}"
# Where to look for external projects that might pin this package.
# Defaults to the parent of this repo (~/Documents), override with $2.
SEARCH_ROOT="${2:-$(dirname "$REPO_DIR")}"

if [[ -z "$NEW_VERSION" ]]; then
  echo "Usage: $0 <new-version> [search-root]"
  echo ""
  echo "  new-version   e.g. 0.2.0"
  echo "  search-root   directory to scan for external projects pinning the"
  echo "                package (default: $(dirname "$REPO_DIR"))"
  exit 1
fi

OLD_VERSION=$(grep -m1 '^version' "$MANIFEST" | sed -E 's/version *= *"(.*)"/\1/')

if [[ "$OLD_VERSION" == "$NEW_VERSION" ]]; then
  echo "Already at version $NEW_VERSION — nothing to do."
  exit 0
fi

echo "Bumping hezel-templates: $OLD_VERSION -> $NEW_VERSION"
echo ""

# 1. Bump the manifest
sed -i "s/^version = \".*\"/version = \"$NEW_VERSION\"/" "$MANIFEST"
echo "  updated $MANIFEST"

# 2. Bump every scaffold's own main.typ — these live in this repo, so no
#    confirmation needed, they must always track the current version.
OLD_IMPORT="@local/hezel-templates:$OLD_VERSION"
NEW_IMPORT="@local/hezel-templates:$NEW_VERSION"

mapfile -t SCAFFOLD_FILES < <(grep -rl "$OLD_IMPORT" "$REPO_DIR/scaffolds" 2>/dev/null || true)
for f in "${SCAFFOLD_FILES[@]}"; do
  sed -i "s#$OLD_IMPORT#$NEW_IMPORT#g" "$f"
  echo "  updated ${f#"$REPO_DIR"/}"
done

# 3. Find external projects (outside this repo) still pinning the old
#    version, and offer to bump them too — these are separate git repos,
#    so each change needs its own confirmation.
mapfile -t EXTERNAL_FILES < <(
  grep -rl "$OLD_IMPORT" "$SEARCH_ROOT" 2>/dev/null | grep -v "^$REPO_DIR/" || true
)

echo ""
if [[ ${#EXTERNAL_FILES[@]} -eq 0 ]]; then
  echo "No external projects under $SEARCH_ROOT pin $OLD_IMPORT."
else
  echo "Found ${#EXTERNAL_FILES[@]} external file(s) still pinning $OLD_IMPORT:"
  for f in "${EXTERNAL_FILES[@]}"; do echo "  - $f"; done
  echo ""
  read -r -p "Bump these too to $NEW_VERSION? [y/N] " REPLY
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    for f in "${EXTERNAL_FILES[@]}"; do
      sed -i "s#$OLD_IMPORT#$NEW_IMPORT#g" "$f"
      echo "  updated $f"
    done
  else
    echo "Skipped — those projects stay pinned to $OLD_VERSION (still works, since"
    echo "old installed package versions are never deleted)."
  fi
fi

# 4. Reinstall + test
echo ""
bash "$SCRIPT_DIR/install.sh"
bash "$SCRIPT_DIR/test.sh"
