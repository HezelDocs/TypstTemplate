#!/usr/bin/env bash
set -e

TEMPLATES=(report practicalWork minutesMeeting minutesAgenda specification)
TEMPLATE="${1:-}"
DEST="${2:-}"

usage() {
  echo "Usage: $0 <template> <destination>"
  echo ""
  echo "Available templates:"
  for t in "${TEMPLATES[@]}"; do echo "  $t"; done
  exit 1
}

[[ -z "$TEMPLATE" || -z "$DEST" ]] && usage

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_DIR/src/$TEMPLATE"

if [ ! -d "$SRC" ]; then
  echo "Unknown template: $TEMPLATE"
  usage
fi

if [ -e "$DEST" ]; then
  echo "Destination already exists: $DEST"
  exit 1
fi

cp -r "$SRC" "$DEST"

# Remove compiled output from the copy
find "$DEST" -name "*.pdf" -delete

echo "Created new '$TEMPLATE' project at $DEST"
echo ""
echo "Next steps:"
case "$TEMPLATE" in
report | practicalWork)
  echo "  1. Edit $DEST/data/metadata.typ"
  echo "  2. Add your logo to $DEST/asset/logos/"
  ;;
minutesMeeting)
  echo "  1. Edit $DEST/data/minute_data.typ"
  echo "  2. Add your logo to $DEST/asset/"
  ;;
minutesAgenda)
  echo "  1. Edit $DEST/data/agenda_data.typ"
  echo "  2. Add your logo to $DEST/asset/"
  ;;
specification)
  echo "  1. Edit $DEST/values/metadata.typ"
  echo "  2. Add your logo to $DEST/assets/"
  ;;
esac
echo "  3. Run: typst compile $DEST/main.typ"
echo ""
echo "Compiling..."
typst compile "$DEST/main.typ"
echo "Done: $DEST/main.pdf"
