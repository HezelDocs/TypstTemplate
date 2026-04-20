#!/usr/bin/env bash
set -e

PACKAGE_DIR="$HOME/.local/share/typst/packages/local/hezel-templates/0.1.0"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing hezel-templates 0.1.0 to $PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"

# Sync package source files only (exclude template scaffolds and legacy)
rsync -a --delete \
  --include="typst.toml" \
  --include="lib.typ" \
  --include="common/" \
  --include="common/**" \
  --include="templates/" \
  --include="templates/**" \
  --exclude="*" \
  "$REPO_DIR/" "$PACKAGE_DIR/"

echo "Done. Import in any Typst file with:"
echo '  #import "@local/hezel-templates:0.1.0": ...'
