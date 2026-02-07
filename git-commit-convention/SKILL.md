---
name: git-commit-convention
description: Generate and review Git commit messages with a Conventional Commit style. Use when the user asks to write commit messages, define commit conventions, classify change types, or improve commit subject/scope clarity.
---

# Git Commit Convention

## Goal

Write clear and consistent commit messages in this format:

`<type>(<scope>): <subject>`

`<scope>` is optional.

## Allowed Types

- `feat`: Add a new feature.
- `fix`: Fix a bug.
- `docs`: Change documentation.
- `style`: Change formatting/style only, no logic change.
- `refactor`: Refactor code without changing intended behavior.
- `test`: Add or update tests.
- `chore`: Change tooling or maintenance tasks.
- `revert`: Revert a previous commit.
- `build`: Change build/packaging pipeline.

## Rules

1. Choose one type from the allowed list only.
2. Use `scope` when the affected area is clear, for example `users`, `popup`, `parser`, `build`.
3. Keep `subject` short and specific, target 50 characters or fewer.
4. Use an imperative verb in `subject` (for example: `add`, `fix`, `refactor`, `update`).
5. Avoid ending `subject` with a period.
6. Keep one logical change per commit message. If multiple logical changes exist, propose multiple commit messages.

## Workflow

1. Identify the primary intent of the change (feature, bug fix, docs, refactor, etc.).
2. Map that intent to one allowed type.
3. Infer a concise scope from touched files/modules when available.
4. Draft a subject that states what changed and why it matters.
5. Validate against format and rules before returning.

## Output Contract

- Return the final commit message first, wrapped in backticks.
- If ambiguity exists, provide 2-3 alternatives with brief differences.
- If multiple independent changes are present, output one commit message per change.

## Examples

- `feat(users): add login functionality`
- `fix(parser): handle trailing comma in JSON input`
- `docs(readme): add Chrome Web Store link`
- `refactor(theme): extract shared color tokens`
- `build(vite): split vendor chunk for faster startup`
