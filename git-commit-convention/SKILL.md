---
name: git-commit-convention
description: Generate and review Git commit messages with a Conventional Commit style. Use when the user asks to write commit messages, define commit conventions, classify change types, or improve commit subject/scope clarity.
---

# Git Commit Convention

## Goal

Write clear and consistent commit messages in this format:

`<type>(<scope>): <subject>`

`<scope>` is optional. For breaking changes, use `<type>(<scope>)!: <subject>` or `<type>!: <subject>`.

## Allowed Types

- `feat`: Add a new feature.
- `fix`: Fix a bug.
- `docs`: Change documentation.
- `style`: Change code formatting only, no behavior change. Not a general type for UI styling changes.
- `refactor`: Refactor code without changing intended behavior.
- `perf`: Change code to improve performance. Do not claim unmeasured gains.
- `test`: Add or update tests.
- `chore`: Change tooling or maintenance tasks.
- `revert`: Revert a previous commit.
- `build`: Change build/packaging pipeline.
- `ci`: Change continuous integration configuration or workflows.

## Rules

1. Follow explicit project conventions and commitlint configuration before these defaults. Treat `git log` as context, not a mandatory rule.
2. Choose one allowed type by primary intent. Tests and documentation that accompany a feature or fix keep that primary type.
3. Use a stable module name for `scope`, for example `users`, `popup`, `parser`, `build`. Omit it when no clear scope fits.
4. Keep `subject` short and specific, target 50 characters or fewer without sacrificing clarity.
5. Use English by default unless the user explicitly requests another language or explicit project conventions require one.
6. Use an imperative verb in `subject` (for example: `add`, `fix`, `refactor`, `update`).
7. Avoid ending `subject` with a period.
8. Keep one logical change per commit message. Suggest splitting independent changes, but do not split or commit automatically.
9. For confirmed breaking changes, add `!` after the type or scope and a `BREAKING CHANGE:` footer with the actual impact and migration. Flag missing details instead of inventing them.

## Workflow

1. Inspect the actual diff within the user's specified scope. Otherwise, prefer staged changes. If nothing is staged, do not automatically include the whole working tree. Label any suggestion's inspected scope.
2. If only a description is available, use only its facts. Do not invent implementation details, test results, or performance gains.
3. Identify the primary intent of the change (feature, bug fix, docs, refactor, etc.).
4. Map that intent to one allowed type.
5. Infer a concise scope from touched files/modules when available.
6. Draft a subject that states what changed and why it matters, supported by the evidence.
7. Validate the scope, facts, format, and breaking-change details before returning.

Generating or reviewing a message does not authorize Git writes. Staging, committing, and pushing require explicit user authorization.

## Output Contract

- Return one recommended commit message by default, wrapped in backticks. Use a fenced code block for a multiline message.
- Add brief notes only for scope, suggested splits, or missing facts. Provide alternatives only when requested.
- For independent changes, suggest separate messages without executing the split.

## Examples

- `feat(users): add login functionality`
- `fix(parser): handle trailing comma in JSON input`
- `docs(readme): add Chrome Web Store link`
- `refactor(theme): extract shared color tokens`
- `build(vite): split vendor chunk`

For a confirmed response-field removal with a known replacement:

```text
feat(api)!: remove name from user responses

BREAKING CHANGE: User responses no longer include name. Use displayName instead.
```
