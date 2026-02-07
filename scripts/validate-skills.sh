#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
errors=0
skills_found=0

read_frontmatter_field() {
  local file="$1"
  local field="$2"
  awk -v key="$field" '
    BEGIN { in_frontmatter = 0 }
    /^---[[:space:]]*$/ {
      if (in_frontmatter == 0) {
        in_frontmatter = 1
        next
      }
      exit
    }
    in_frontmatter == 1 && $0 ~ ("^" key ":[[:space:]]*") {
      sub("^" key ":[[:space:]]*", "", $0)
      gsub(/[[:space:]]+$/, "", $0)
      print
      exit
    }
  ' "$file"
}

for skill_md in "$ROOT_DIR"/*/SKILL.md; do
  if [[ ! -f "$skill_md" ]]; then
    continue
  fi

  skills_found=$((skills_found + 1))
  skill_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_dir")"
  metadata_name="$(read_frontmatter_field "$skill_md" "name")"
  metadata_description="$(read_frontmatter_field "$skill_md" "description")"
  agent_file="$skill_dir/agents/openai.yaml"

  if [[ -z "$metadata_name" ]]; then
    echo "[ERROR] $skill_name: missing frontmatter field 'name' in SKILL.md"
    errors=$((errors + 1))
  elif [[ "$metadata_name" != "$skill_name" ]]; then
    echo "[ERROR] $skill_name: frontmatter name '$metadata_name' does not match directory"
    errors=$((errors + 1))
  fi

  if [[ -z "$metadata_description" ]]; then
    echo "[ERROR] $skill_name: missing frontmatter field 'description' in SKILL.md"
    errors=$((errors + 1))
  fi

  if [[ ! -f "$agent_file" ]]; then
    echo "[ERROR] $skill_name: missing agents/openai.yaml"
    errors=$((errors + 1))
    continue
  fi

  if ! rg -q '^[[:space:]]*display_name:' "$agent_file"; then
    echo "[ERROR] $skill_name: agents/openai.yaml missing interface.display_name"
    errors=$((errors + 1))
  fi
  if ! rg -q '^[[:space:]]*short_description:' "$agent_file"; then
    echo "[ERROR] $skill_name: agents/openai.yaml missing interface.short_description"
    errors=$((errors + 1))
  fi
  if ! rg -q '^[[:space:]]*default_prompt:' "$agent_file"; then
    echo "[ERROR] $skill_name: agents/openai.yaml missing interface.default_prompt"
    errors=$((errors + 1))
  fi
done

if [[ "$skills_found" -eq 0 ]]; then
  echo "[ERROR] no skills found under $ROOT_DIR"
  exit 1
fi

if [[ "$errors" -gt 0 ]]; then
  echo "Validation failed with $errors error(s)."
  exit 1
fi

echo "Validation passed for $skills_found skill(s)."
