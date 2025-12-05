# PixelUI.Slider

*Extends: PixelUI.Widget*

A slider widget for selecting numeric values within a range. Supports single value or range selection mode.

## Properties

| Name | Type | Description |
|------|------|-------------|
| min | `number` | Minimum value |
| max | `number` | Maximum value |
| value | `number` | Current value (single mode) |
| range | `boolean` | Whether in range selection mode |
| lowerValue | `number?` | Lower bound value (range mode) |
| upperValue | `number?` | Upper bound value (range mode) |
| step | `number` | Step increment for value changes |
| showValue | `boolean` | Whether to display the current value |
| onChange | `fun(self:PixelUI.Slider,` |  |
| formatValue | `fun(self:PixelUI.Slider,` |  |

## Methods

### new

```lua
new()
```

### _clampValue

```lua
_clampValue()
```

### _applyStep

```lua
_applyStep()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _valueToPosition

```lua
_valueToPosition()
```

### _positionToValue

```lua
_positionToValue()
```

### _notifyChange

```lua
_notifyChange()
```

### setOnChange

```lua
setOnChange()
```

### _setSingleValue

```lua
_setSingleValue()
```

### setValue

```lua
setValue()
```

### getValue

```lua
getValue()
```

### _setLowerValue

```lua
_setLowerValue()
```

### _setUpperValue

```lua
_setUpperValue()
```

### setRangeValues

```lua
setRangeValues()
```

### getRangeValues

```lua
getRangeValues()
```

### setRangeLimits

```lua
setRangeLimits()
```

### setStep

```lua
setStep()
```

### setShowValue

```lua
setShowValue()
```

### setColors

```lua
setColors()
```

### _formatNumber

```lua
_formatNumber()
```

### _formatDisplayValue

```lua
_formatDisplayValue()
```

### _getStepForNudge

```lua
_getStepForNudge()
```

### _positionFromPoint

```lua
_positionFromPoint()
```

### _beginInteraction

```lua
_beginInteraction()
```

### _updateInteraction

```lua
_updateInteraction()
```

### _endInteraction

```lua
_endInteraction()
```

### _switchFocusedHandle

```lua
_switchFocusedHandle()
```

### _nudgeValue

```lua
_nudgeValue()
```

### onFocusChanged

```lua
onFocusChanged()
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

-- Simple value slider
local slider = app:slider({
    x = 2, y = 2,
    width = 25, height = 1,
    min = 0,
    max = 100,
    value = 50,
    showValue = true,
    onChange = function(self, value)
        -- Handle value change
    end
})
app.root:addChild(slider)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Range slider with custom formatting
local rangeLabel = app:label({
    x = 2, y = 5,
    text = "Range: $0 - $100",
    fg = colors.white
})

local slider = app:slider({
    x = 2, y = 2,
    width = 30, height = 1,
    min = 0,
    max = 1000,
    range = true,
    lowerValue = 200,
    upperValue = 800,
    step = 50,
    showValue = true,
    formatValue = function(self, lower, upper)
        return string.format("$%d - $%d", lower, upper)
    end,
    onChange = function(self, lower, upper)
        rangeLabel:setText(string.format("Range: $%d - $%d", lower, upper))
    end
})

app.root:addChild(slider)
app.root:addChild(rangeLabel)

app:run()
```

</details>

