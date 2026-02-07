#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"

"$ROOT_DIR/scripts/validate-skills.sh"

mkdir -p "$DIST_DIR"
find "$DIST_DIR" -maxdepth 1 -type f -name '*.skill' -delete

built=0
for skill_md in "$ROOT_DIR"/*/SKILL.md; do
  if [[ ! -f "$skill_md" ]]; then
    continue
  fi

  skill_name="$(basename "$(dirname "$skill_md")")"
  archive_path="$DIST_DIR/$skill_name.skill"

  (
    cd "$ROOT_DIR"
    zip -r -0 "$archive_path" "$skill_name" >/dev/null
  )

  echo "Built $archive_path"
  built=$((built + 1))
done

if [[ "$built" -eq 0 ]]; then
  echo "No skills were packaged."
  exit 1
fi

echo "Build complete: $built package(s)."
