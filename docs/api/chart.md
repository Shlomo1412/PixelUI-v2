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

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple bar chart
local chart = app:chart({
    x = 2, y = 2,
    width = 30, height = 10,
    data = { 10, 25, 15, 30, 20 },
    labels = { "A", "B", "C", "D", "E" },
    chartType = "bar",
    barColor = colors.blue
})
app.root:addChild(chart)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Interactive chart with selection and dynamic updates
local infoLabel = app:label({
    x = 2, y = 14,
    text = "Click a bar to select",
    fg = colors.lightGray
})

local chart = app:chart({
    x = 2, y = 2,
    width = 40, height = 10,
    data = { 45, 72, 38, 95, 60, 28 },
    labels = { "Jan", "Feb", "Mar", "Apr", "May", "Jun" },
    chartType = "bar",
    showAxis = true,
    showLabels = true,
    barColor = colors.cyan,
    highlightColor = colors.yellow,
    axisColor = colors.gray,
    selectable = true,
    minValue = 0,
    maxValue = 100,
    onSelect = function(self, index, value)
        if index then
            local label = self.labels[index]
            infoLabel:setText(label .. ": " .. value)
        else
            infoLabel:setText("Click a bar to select")
        end
    end
})

-- Toggle chart type
local typeToggle = app:button({
    x = 2, y = 16,
    width = 15, height = 1,
    label = "Toggle Line",
    onClick = function()
        chart.chartType = chart.chartType == "bar" and "line" or "bar"
    end
})

app.root:addChild(chart)
app.root:addChild(infoLabel)
app.root:addChild(typeToggle)

app:run()
```

</details>

