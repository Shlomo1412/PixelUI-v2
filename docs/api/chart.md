# PixelUI.Chart

*Extends: PixelUI.Widget*

A data visualization widget supporting bar and line charts. Displays numeric data with optional labels and interactive selection.

## Properties

| Name | Type | Description |
|------|------|-------------|
| data | `number[]` | Array of numeric values to display |
| labels | `string[]` | Labels for each data point |
| chartType | `"bar"\|"line"` | Type of chart visualization |
| minValue | `number?` | Minimum value for the Y axis (auto-calculated if not set) |
| maxValue | `number?` | Maximum value for the Y axis (auto-calculated if not set) |
| showAxis | `boolean` | Whether to show axis lines |
| showLabels | `boolean` | Whether to show data point labels |
| placeholder | `string?` | Text to show when no data is available |
| barColor | `PixelUI.Color` | Color for bars or line |
| highlightColor | `PixelUI.Color` | Color for highlighted/selected elements |
| axisColor | `PixelUI.Color` | Color for axis lines |
| lineColor | `PixelUI.Color` | Color for line charts |
| rangePadding | `number` | Padding percentage for the value range |
| selectable | `boolean` | Whether the chart allows selecting data points |
| selectedIndex | `integer?` | Currently selected data point index |
| onSelect | `fun(self:PixelUI.Chart,` |  |

## Methods

### new

```lua
new()
```

### _emitSelect

```lua
_emitSelect()
```

### _clampSelection

```lua
_clampSelection()
```

### setData

```lua
setData()
```

### getData

```lua
getData()
```

### setLabels

```lua
setLabels()
```

### getLabels

```lua
getLabels()
```

### getLabel

```lua
getLabel()
```

### setChartType

```lua
setChartType()
```

### setShowAxis

```lua
setShowAxis()
```

### setShowLabels

```lua
setShowLabels()
```

### setPlaceholder

```lua
setPlaceholder()
```

### setSelectable

```lua
setSelectable()
```

### setRange

```lua
setRange()
```

### setRangePadding

```lua
setRangePadding()
```

### setOnSelect

```lua
setOnSelect()
```

### setSelectedIndex

```lua
setSelectedIndex()
```

### getSelectedIndex

```lua
getSelectedIndex()
```

### getSelectedValue

```lua
getSelectedValue()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _indexFromPoint

```lua
_indexFromPoint()
```

### _moveSelection

```lua
_moveSelection()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

## Examples

### Disable interactive selection

```lua
local chart = app:createChart({
	width = 26,
	height = 7,
	data = { 12, 18, 9, 21, 15 },
	labels = { "Mon", "Tue", "Wed", "Thu", "Fri" },
	selectable = false,
})

-- Re-enable selection later without triggering onSelect
chart:setSelectable(true, true)
```

