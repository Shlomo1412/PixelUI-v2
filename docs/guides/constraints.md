detailPanel:setConstraints({
detailPanel:setConstraints(nil)
# Constraint Layout

PixelUI constraints let a widget match its parent, size itself as a percentage, or stay centered as the terminal changes. Constraints are evaluated whenever a widget (or its parent) is resized, so dynamic layouts keep the correct proportions automatically.

## Matching Parent Metrics

Set `constraints.width` or `constraints.height` to reference a parent metric. The value can be a string such as `"parent.width"`, a boolean `true` (match the same axis), or a table with extra options.

```lua
local hero = app:createFrame({
  width = 18,
  height = 5,
  border = { color = colors.white },
  constraints = {
    width = "parent.width",
    centerX = true,
    centerY = { offset = 2 }
  }
})
```

In the snippet above `hero` always stretches to the full width of its parent and recenters itself whenever the parent resizes. `centerY` accepts an optional `offset` (positive pushes the widget down, negative pulls it up).

## Percent-Based Sizing

Use `widthPercent` and `heightPercent` to size a widget as a fraction of its parent. Values between `0` and `1` are treated as percentages (values above `1` are interpreted as `value / 100`).

```lua
local dialog = app:createFrame({
  constraints = {
    widthPercent = 0.6,     -- 60% of the parent width
    height = { percent = 0.45, of = "parent.height", offset = -1 },
    centerX = true,
    centerY = { offset = 2 }
  }
})
```

`PixelUI.DimensionConstraint` tables unlock additional control: supply `percent`, `of`, and an `offset` to compute a dimension relative to any supported parent metric.

## Centering and Offsets

`centerX` and `centerY` accept `true`, a string such as `"parent.centerX"`, or a table `{ reference = "parent.centerY", offset = 1 }`. Offsets are added after the alignment is calculated, so fine adjustments are easy:

```lua
widget:setConstraints({
  centerX = true,
  centerY = { reference = "parent.centerY", offset = 2 },
  offsetX = -1
})
```

Combine `offsetX`/`offsetY` with the per-axis alignment to nudge widgets without losing the relative behaviour.

## Minimum and Maximum Bounds

Old favourites `minWidth`, `maxWidth`, `minHeight`, and `maxHeight` still apply. After a dimension is calculated, PixelUI clamps it inside the range before updating the widget:

```lua
widget:setConstraints({
  widthPercent = 0.5,
  minWidth = 12,
  maxWidth = 24
})
```

If you only need hard bounds, you can continue to provide just the min/max keys.

## Updating and Clearing Constraints

Call `widget:setConstraints(table)` to replace the current rules or pass `nil`/`false` to remove them entirely. The widget immediately recomputes its size and alignment:

```lua
-- swap to a centered match-parent layout
panel:setConstraints({
  width = "parent.width",
  heightPercent = 0.6,
  centerX = true,
  centerY = { offset = 1 }
})

-- let the panel float freely again
panel:setConstraints(nil)
```

Query the active rules with `widget:getConstraints()`. The helper returns a copy in a human-friendly form (strings for parent references, tables for percent descriptors, raw numbers for min/max), so you can log or inspect the current layout.

## Demo

Run `example.lua` and visit step 17 of the wizard to see the presets in action:

- **60% Width** uses `widthPercent` and centered offsets.
- **Match Parent** mirrors the parent's width while remaining centred.
- **Offset Center** shows how relative percentages and alignment offsets can be composited.

Each preset prints the resolved size so you can confirm the constraints while resizing the terminal.
