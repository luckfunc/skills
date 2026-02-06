---
name: clean-code-javascript
description: Apply Clean Code principles to JavaScript and TypeScript reviews/refactors. Use when requests focus on readability, naming, function design, duplication, side effects, SOLID, error handling, comments, formatting, or clean-code style guidance.
---

# Clean Code JavaScript

## Goal

Refactor or review JS/TS code with clean-code principles while preserving behavior and project conventions.

## Scope

- Work on JavaScript and TypeScript files/snippets.
- Handle three request types: `review`, `refactor`, and `guidance`.
- Respect existing lint/format/project rules. Do not impose unrelated style changes.

## Workflow

1. Classify the task as `review`, `refactor`, or `guidance`.
2. Scan for hotspots: vague naming, long functions, flag arguments, deep nesting, side effects, duplicate logic, magic numbers, dead code, ignored errors.
3. Apply smallest safe improvements first.
4. Keep external behavior unchanged unless user explicitly asks for behavioral change.
5. State risks and verification points when a change can affect runtime behavior.

## Decision Rules

- Prefer descriptive names and consistent domain vocabulary.
- Keep functions focused; avoid many parameters (prefer object params when appropriate).
- Replace boolean flag parameters with explicit functions when feasible.
- Reduce branching complexity with guard clauses and extracted intent.
- Make side effects explicit and avoid hidden global mutations.
- Prefer composition over inheritance unless inheritance is already the required pattern.
- Handle errors explicitly; do not silently swallow caught/rejected errors.
- Remove dead code and stale commented-out code unless user asks to keep it.

## Reference Usage

Detailed content lives in `references/clean-code-javascript.md`.
Load only relevant sections instead of reading the full file.

Quick locate commands:

```bash
rg -n '^## ' references/clean-code-javascript.md
rg -n '^### ' references/clean-code-javascript.md
```

Useful section patterns:

- Variables: `^## \*\*Variables\*\*`
- Functions: `^## \*\*Functions\*\*`
- Objects/Data structures: `^## \*\*Objects and Data Structures\*\*`
- Classes: `^## \*\*Classes\*\*`
- SOLID: `^## \*\*SOLID\*\*`
- Testing: `^## \*\*Testing\*\*`
- Concurrency: `^## \*\*Concurrency\*\*`
- Error handling: `^## \*\*Error Handling\*\*`
- Formatting: `^## \*\*Formatting\*\*`
- Comments: `^## \*\*Comments\*\*`

## Output Contract

- For `review`: list concrete findings first, ordered by severity, with file/line and fix direction.
- For `refactor`: summarize concrete edits and why they improve maintainability.
- For `guidance`: provide concise rules with small, practical examples.
- If no major issue exists, state that explicitly and mention remaining risks/testing gaps.
