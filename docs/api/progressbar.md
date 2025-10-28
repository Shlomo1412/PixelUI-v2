# PixelUI.ProgressBar

*Extends: PixelUI.Widget*

A progress indicator widget showing completion status. Supports determinate and indeterminate modes with optional labels.

## Properties

| Name | Type | Description |
|------|------|-------------|
| value | `number` | Current progress value |
| min | `number` | Minimum progress value |
| max | `number` | Maximum progress value |
| indeterminate | `boolean` | Whether to show an animated indeterminate state |
| label | `string?` | Optional label text to display |
| showPercent | `boolean` | Whether to show percentage text |
| trackColor | `PixelUI.Color` | Background track color |
| fillColor | `PixelUI.Color` | Foreground fill color |
| textColor | `PixelUI.Color` | Color for text (label and percentage) |

## Methods

### new

```lua
new()
```

### _clampValue

```lua
_clampValue()
```

### _stopIndeterminateAnimation

```lua
_stopIndeterminateAnimation()
```

### _startIndeterminateAnimation

```lua
_startIndeterminateAnimation()
```

### setRange

```lua
setRange()
```

### getRange

```lua
getRange()
```

### setValue

```lua
setValue()
```

### getValue

```lua
getValue()
```

### getPercent

```lua
getPercent()
```

### setIndeterminate

```lua
setIndeterminate()
```

### isIndeterminate

```lua
isIndeterminate()
```

### setLabel

```lua
setLabel()
```

### setShowPercent

```lua
setShowPercent()
```

### setColors

```lua
setColors()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

