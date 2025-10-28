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

