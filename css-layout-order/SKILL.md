---
name: css-layout-order
description: Enforce CSS/LESS/SCSS declaration order for readability. Use when editing or reviewing style files where property order matters, especially when the user requires layout-affecting properties first and wants display followed immediately by width and height.
---

# CSS Layout Order

## Rule

- Put layout-impact declarations at the top of each selector block.
- Keep `position` and `display` first.
- Place `width` and `height` immediately after `display`.
- Reorder declarations only; do not change values, selectors, nesting, or comments.

## Canonical Order

1. `position`
2. `display`
3. `width`
4. `height`
5. Other layout declarations (`top/right/bottom/left`, `flex-*`, `overflow`, `margin`, `padding`)
6. Visual declarations (`background`, `border`, `box-shadow`, `opacity`)
7. Typography and interaction declarations (`font-*`, `line-height`, `color`, `transition`, `animation`)

## Workflow

1. Find selector blocks touched by the task.
2. Move `position`/`display` to the top when present.
3. Ensure `display -> width -> height` are adjacent in that order.
4. Keep the relative order of remaining declarations unless the user asks for a full sort.
5. Return concise notes that call out only selectors that were reordered.
