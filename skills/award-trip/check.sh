#!/bin/sh
# Checks skills/award-trip/SKILL.md: no owner name, no em dash, and the
# required section headings. Portable POSIX sh; runs from any directory.
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) || exit 2
skill="$dir/SKILL.md"
fail=0

if [ ! -f "$skill" ]; then
  echo "FAIL: $skill not found"
  exit 1
fi

if grep -q "Gavin" "$skill"; then
  echo "FAIL: SKILL.md contains \"Gavin\" (use \"the owner\" or \"the user\"):"
  grep -n "Gavin" "$skill"
  fail=1
fi

emdash=$(printf '\342\200\224')
if grep -q "$emdash" "$skill"; then
  echo "FAIL: SKILL.md contains an em dash (U+2014):"
  grep -n "$emdash" "$skill"
  fail=1
fi

for h in "## Connections and profile" "## Coverage" "## Advisor mode" "## Party planning" "## Admin"; do
  if ! grep -q "^$h\$" "$skill"; then
    echo "FAIL: SKILL.md is missing the heading \"$h\""
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  exit 1
fi
echo "PASS: SKILL.md has no owner name, no em dash, and all required headings"
