# Engineering Practices

## Table of Contents

- [Complexity Lens](#complexity-lens)
- [Strategic Programming](#strategic-programming)
- [Deep Modules and Simple Interfaces](#deep-modules-and-simple-interfaces)
- [Information Hiding and Knowledge Placement](#information-hiding-and-knowledge-placement)
- [Genericity and Special-Case Control](#genericity-and-special-case-control)
- [Layering and Pass-Through Avoidance](#layering-and-pass-through-avoidance)
- [Error Handling by Design](#error-handling-by-design)
- [Comments, Names, Consistency, and Readability](#comments-names-consistency-and-readability)
- [Modifying Existing Code](#modifying-existing-code)
- [Performance Without Complexity](#performance-without-complexity)
- [Design Questions](#design-questions)

## Complexity Lens

Treat complexity as the primary design constraint.

- Watch for three symptoms:
  - change amplification: a simple change touches many places
  - cognitive load: a change requires too much hidden knowledge
  - unknown unknowns: it is unclear what must be changed or checked
- Assume the root causes are usually:
  - too many dependencies
  - obscured or poorly exposed information
- Prefer designs that let a developer make a local change with confidence.

Questions to ask:

- What knowledge does someone need before changing this code safely?
- Which parts of that knowledge are currently hidden in callers, conventions, or scattered code?
- Can one local abstraction absorb that complexity?

## Strategic Programming

Optimize for long-term system quality, not only for the current ticket.

- "Working code" is not enough if it leaves the design worse.
- Make small, continuous design investments instead of rare giant rewrites.
- Resist the smallest-possible patch if it introduces a new special case, leak, or wrapper.
- When a change exposes a weak abstraction, fix the abstraction, not just the symptom.

Apply this in practice:

- Spend time comparing alternatives before coding.
- Leave the area cleaner after each change.
- Prefer one durable refactor over repeated tactical patches.

## Deep Modules and Simple Interfaces

The best modules hide a lot of functionality behind a small, easy-to-learn interface.

Prefer:

- fewer public entry points
- common-case defaults
- interfaces that describe what callers need, not how the module works
- modules whose interfaces are much simpler than their implementations

Avoid:

- shallow wrappers that only rename or forward behavior
- "many small classes" that add interfaces without reducing knowledge
- APIs that make every caller assemble the same sequence of low-level operations

Questions to ask:

- Does this abstraction remove meaningful work from callers?
- Would the interface documentation be nearly as long as the implementation?
- Are we adding a public surface area without adding real leverage?

## Information Hiding and Knowledge Placement

Encapsulate design decisions so they live in one place.

Prefer:

- one module owning one body of knowledge
- data representation hidden behind behavior-oriented APIs
- defaults and derived values computed inside the module

Avoid:

- exposing internal maps, arrays, or state containers
- forcing callers to know storage format, parsing rules, sequencing rules, or config rules
- time-based decomposition where read/parse/write or fetch/transform/store all duplicate the same knowledge

Refactor moves:

- merge classes that share too much hidden knowledge
- extract a new owner for duplicated knowledge
- move caller-specific knowledge back up to the caller
- move mechanism-specific knowledge down into the mechanism

## Genericity and Special-Case Control

Generic mechanisms are often simpler and deeper than specialized APIs.

Prefer:

- range-based, position-based, or data-oriented APIs over UI-action-shaped APIs
- one reusable operation over many one-off variants
- code paths that handle empty, boundary, or rare cases naturally

Avoid:

- one method per user action when the underlying operation is the same
- mixing generic framework code with use-case-specific policy
- explicit "no value", "no selection", or other flags when the normal representation can cover the case

Heuristics:

- Separate generic code from specialized code.
- Push specialized code up into product logic or down into adapters/drivers.
- Eliminate special cases by redefining the normal case when possible.

## Layering and Pass-Through Avoidance

Adjacent layers should operate at different abstraction levels.

Prefer:

- each layer changing the framing of the problem
- dispatchers or adapters that add real selection/translation behavior
- context objects when shared global state would otherwise become pass-through parameters

Avoid:

- pass-through methods with nearly identical signatures
- decorators that add tiny behavior but copy a large API
- passing the same variable through long call chains when intermediates do not use it
- interfaces that mirror internal representation too closely

Questions to ask:

- What new abstraction does this layer add?
- If this class vanished, what complexity would return to callers?
- Is a context object cleaner than repeated parameter plumbing?

## Error Handling by Design

The cleanest exception handling is often to remove the exception from the API.

Prefer:

- defining semantics so common edge cases are valid operations
- masking recoverable low-level failures inside the module
- aggregating many similar failures at one high-leverage boundary
- crashing fast for truly unrecoverable states when recovery would be fake complexity

Avoid:

- defensive APIs that raise errors for routine cleanup or harmless boundary cases
- catching the same error repeatedly in many leaf handlers
- pushing an error upward when callers do not have better recovery options

Questions to ask:

- Can the API define this case as valid instead of exceptional?
- Where is the single best layer to handle this class of failure?
- Does this exception expose important information, or just internal mechanics?

## Comments, Names, Consistency, and Readability

Documentation and naming are part of the design, not afterthoughts.

Comments:

- Write interface comments that define abstractions, constraints, side effects, invariants, and error semantics.
- Write implementation comments to explain what a block is doing and why, not to narrate syntax.
- Keep interface documentation separate from implementation details.
- Write comments early; difficulty writing a clean comment is a signal that the design is weak.

Names:

- Choose precise names that create a correct mental model.
- Use the same name for the same concept everywhere.
- Do not use one name for multiple subtly different concepts.
- Treat "hard to name" as a design smell.

Consistency:

- Follow local naming, formatting, ordering, and behavioral conventions.
- Keep similar things similar and different things different.
- Do not introduce a "better" convention unless the team will migrate the old one too.

Readability:

- Optimize for ease of reading rather than ease of typing.
- Avoid generic containers or vague aliases when a small domain type would clarify intent.
- Document surprising control flow, asynchronous behavior, or hidden thread/process effects.

## Modifying Existing Code

When changing old code, stay strategic.

- Aim for the result to look as if the new requirement had been part of the original design.
- Improve local structure while making the requested change.
- Update comments near the code they describe.
- Do not rely on commit messages as the only design record.
- Avoid duplicate documentation; keep one canonical explanation and reference it.
- Review the final diff before commit specifically for stale comments and accidental complexity.

Good default behavior:

- if you touched a weak abstraction, strengthen it
- if you found duplicated knowledge, centralize it
- if you introduced a new option, question whether it can be a default instead

## Performance Without Complexity

Simple design and good performance are compatible.

Prefer:

- naturally efficient data structures and algorithms
- measuring before optimizing
- redesigning around the critical path when performance truly matters
- removing special-case checks and extra layers from hot paths

Avoid:

- intuition-only micro-optimizations
- preserving complex performance code that has no measured benefit
- scattering performance hacks across the codebase

Performance workflow:

1. Measure the current system.
2. Identify the real hot path.
3. Imagine the minimum code needed for the common case.
4. Redesign toward that path while preserving a clean abstraction.
5. Re-measure and revert complexity that does not pay off.

## Design Questions

Use these prompts during review or refactoring:

- Which module should own this knowledge?
- Can the common case become simpler without making rare cases impossible?
- Are we exposing implementation or only the needed abstraction?
- Should these two pieces be merged, split, or moved to different layers?
- Is this method generic enough to cover nearby cases without becoming awkward?
- Is the interface easier to understand than the implementation?
- Could the error semantics be simplified by definition, masking, or aggregation?
- What would make a new reader guess correctly on first read?
- If this code is hard to describe briefly, is the abstraction wrong?
