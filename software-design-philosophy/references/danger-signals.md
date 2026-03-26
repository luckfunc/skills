# Danger Signals

## Table of Contents

- [Abstraction Signals](#abstraction-signals)
- [Knowledge Leakage Signals](#knowledge-leakage-signals)
- [Documentation and Readability Signals](#documentation-and-readability-signals)
- [Evolution and Performance Signals](#evolution-and-performance-signals)

## Abstraction Signals

### Shallow module

What it looks like:

- the interface is almost as complicated as the implementation
- wrappers save little caller work
- documentation is long because the abstraction is weak

Default fix:

- merge the wrapper into a deeper owner
- raise the abstraction level of the API
- replace several narrow methods with one general operation

### Class explosion

What it looks like:

- many tiny classes or methods, each with little behavior
- lots of boilerplate and cross-object coordination
- users must learn many names to do simple tasks

Default fix:

- combine closely related responsibilities
- prefer one deeper class over several shallow shells

### Pass-through method

What it looks like:

- one method mostly forwards to another with the same shape
- the intermediate class adds little or no new abstraction

Default fix:

- delete the middle layer
- move the behavior to the real owner
- merge overlapping classes if responsibilities cannot be separated

### Pass-through variable

What it looks like:

- parameters travel through several frames without being used
- adding one new piece of global context forces many signature changes

Default fix:

- store shared state in a well-bounded context object
- attach the context to long-lived objects instead of threading values everywhere

## Knowledge Leakage Signals

### Information leakage

What it looks like:

- one design decision appears in multiple modules
- changing a format, rule, or invariant requires edits in several places

Default fix:

- centralize ownership of that knowledge
- expose a simpler API instead of the leaked representation

### Time-based decomposition

What it looks like:

- modules are split by execution order rather than by knowledge ownership
- read/parse/write or fetch/process/store layers duplicate the same decisions

Default fix:

- regroup code by what it knows, not by when it runs
- merge stages that share core knowledge

### Overexposed API

What it looks like:

- common callers must understand rare or advanced options
- defaults are weak, missing, or manual

Default fix:

- make the common case the default
- isolate advanced behavior behind separate entry points or overrides

### Generic/specialized mix

What it looks like:

- framework code contains product-specific branches
- domain-specific policy leaks into reusable mechanisms

Default fix:

- move specialized policy up into product logic or down into adapters
- keep the shared mechanism generic

### Duplication

What it looks like:

- similar behavior or rules appear in multiple modules
- the same sequence of low-level steps is recreated by many callers

Default fix:

- capture the repeated knowledge in one deeper abstraction
- centralize the policy or helper at the correct ownership level

### Tangled methods

What it looks like:

- understanding one method requires reading another method's body
- state and logic are interwoven across helpers

Default fix:

- rebalance responsibilities
- make helper contracts stronger and more explicit
- reduce shared mutable state

## Documentation and Readability Signals

### Comment repeats code

What it looks like:

- comments restate syntax, names, or obvious control flow
- readers gain no information beyond the adjacent line

Default fix:

- delete the comment
- replace it with abstraction, intent, invariant, or rationale

### Interface docs polluted by implementation

What it looks like:

- method docs explain internal algorithm details that callers do not need
- the abstraction and the mechanism are mixed together

Default fix:

- move mechanism notes inside the implementation
- keep interface docs focused on caller-visible behavior

### Vague name

What it looks like:

- names such as `data`, `info`, `manager`, `result`, `state`, `handle`
- the same word can mean several different things

Default fix:

- rename to the exact domain concept
- include distinguishing words when similar concepts coexist

### Hard-to-name entity

What it looks like:

- no short precise name seems to fit
- different readers describe it differently

Default fix:

- question the abstraction itself
- split mixed responsibilities or create a better domain model

### Hard-to-describe interface

What it looks like:

- complete documentation becomes long, subtle, or exception-heavy
- the method needs many caveats to be used correctly

Default fix:

- redesign the API
- remove hidden preconditions
- shift details out of the interface and into the implementation

### Hard-to-understand code

What it looks like:

- a quick read does not reveal control flow or meaning
- behavior depends on hidden conventions, events, or ambiguous containers

Default fix:

- improve names and local structure
- add comments for surprising behavior
- replace generic tuples/containers with domain-specific structures

## Evolution and Performance Signals

### Tactical patching

What it looks like:

- each bug fix adds another branch, flag, or special case
- local fixes accumulate but the structure never improves

Default fix:

- step back and repair the abstraction causing repeated patches
- leave the changed area cleaner than before

### Stale or duplicated documentation

What it looks like:

- code and comments disagree
- the same rule is documented in several places

Default fix:

- keep one canonical description near the owning code
- replace copies with short references when needed

### Unmeasured optimization

What it looks like:

- performance code exists without evidence it helps
- hot-path reasoning is based on intuition only

Default fix:

- measure first
- simplify the critical path
- remove complexity that does not produce a measurable win
