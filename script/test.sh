#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES=(report practicalWork minutesMeeting minutesAgenda specification)
PASS=0
FAIL=0
FAILED_TEMPLATES=()

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

TMPDIR_OUT=$(mktemp -d)
trap 'rm -rf "$TMPDIR_OUT"' EXIT

# Always re-install so tests reflect current source
echo -e "${YELLOW}Installing package...${NC}"
bash "$SCRIPT_DIR/install.sh" >/dev/null

echo ""
echo "Running template compilation tests..."
echo "--------------------------------------"

for template in "${TEMPLATES[@]}"; do
  main="$REPO_DIR/scaffolds/$template/main.typ"

  if [ ! -f "$main" ]; then
    echo -e "  ${YELLOW}SKIP${NC}  $template  (no main.typ)"
    continue
  fi

  out="$TMPDIR_OUT/$template.pdf"
  output=$(typst compile "$main" "$out" 2>&1)
  exit_code=$?

  # Ignore deprecation warnings — only actual errors count
  errors=$(echo "$output" | grep -E "^error:" || true)

  if [ $exit_code -ne 0 ] || [ -n "$errors" ]; then
    echo -e "  ${RED}FAIL${NC}  $template"
    echo "$output" | grep -v "^warning:" | grep -v "^$" | sed 's/^/        /'
    FAILED_TEMPLATES+=("$template")
    FAIL=$((FAIL + 1))
  else
    echo -e "  ${GREEN}PASS${NC}  $template"
    PASS=$((PASS + 1))
  fi
done

echo "--------------------------------------"
echo -e "Results: ${GREEN}${PASS} passed${NC}, ${RED}${FAIL} failed${NC}"

if [ ${#FAILED_TEMPLATES[@]} -gt 0 ]; then
  echo ""
  echo -e "${RED}Failed: ${FAILED_TEMPLATES[*]}${NC}"
  exit 1
fi

exit 0
