---
name: software-design-philosophy
description: Apply A Philosophy of Software Design principles to code review, refactoring, API/module design, and maintainability work. Use when requests focus on reducing complexity, deep vs shallow modules, information hiding, generic vs specialized code, abstraction boundaries, error handling, comments, naming, consistency, readability, or performance design.
---

# Software Design Philosophy

## Goal

Review, refactor, or design software with complexity reduction as the primary goal, using the book's principles as practical engineering heuristics.

## Scope

- Use for `review`, `refactor`, `design`, and `guidance` tasks.
- Work across languages; prioritize module boundaries, APIs, error semantics, names, comments, consistency, and readability over language-specific style.
- Preserve behavior unless the user explicitly asks for semantic change.

## Workflow

1. Classify the task as `review`, `refactor`, `design`, or `guidance`.
2. Start with the complexity lens:
   - Does this area increase change amplification?
   - Does it raise cognitive load?
   - Does it create "unknown unknowns"?
3. Scan for danger signals before proposing fixes.
4. Prefer high-leverage changes:
   - simplify interfaces
   - hide design decisions
   - remove special cases
   - merge shallow abstractions
   - separate generic code from specialized code
5. If the design is unclear, compare at least two approaches before choosing one.
6. Keep the output concrete: findings, refactor moves, or design rules tied to files, modules, and APIs.

## Decision Rules

- Optimize for simple interfaces, not simple implementations.
- Prefer deep modules over many shallow wrappers.
- Avoid time-ordered decomposition when the same knowledge is needed in multiple places.
- Keep adjacent layers at different abstraction levels; remove pass-through methods and pass-through variables when possible.
- Define away avoidable errors; otherwise mask or aggregate exceptions at the highest-leverage point.
- Write comments for abstractions, invariants, constraints, and rationale, not to narrate obvious code.
- Choose precise names and preserve local conventions.
- Design code to be easy to read, not merely easy to write.
- When touching existing code, leave the design better than you found it.
- For performance work, measure first and simplify the critical path instead of scattering micro-optimizations.

## Reference Usage

Detailed content lives in:

- `references/engineering-practices.md`
- `references/danger-signals.md`

Load only the relevant sections instead of reading everything.

Quick locate commands:

```bash
rg -n '^## ' references/engineering-practices.md
rg -n '^## ' references/danger-signals.md
```

Useful section patterns:

- Complexity lens: `^## Complexity Lens`
- Strategic design: `^## Strategic Programming`
- Modules and APIs: `^## Deep Modules and Simple Interfaces`
- Information hiding: `^## Information Hiding and Knowledge Placement`
- Genericity: `^## Genericity and Special-Case Control`
- Layering: `^## Layering and Pass-Through Avoidance`
- Errors: `^## Error Handling by Design`
- Docs and names: `^## Comments, Names, Consistency, and Readability`
- Existing code: `^## Modifying Existing Code`
- Performance: `^## Performance Without Complexity`
- Signal lookup: `^## Abstraction Signals`, `^## Knowledge Leakage Signals`, `^## Documentation and Readability Signals`

## Output Contract

- For `review`: list findings first, ordered by severity, and tie each finding to a danger signal or principle.
- For `refactor`: make the smallest high-leverage edits first and explain what complexity was removed.
- For `design`: compare at least two options when architecture is uncertain, then recommend one.
- For `guidance`: answer with concise rules, tradeoffs, and practical refactor directions.
- Always mention residual risks or missing verification when relevant.
