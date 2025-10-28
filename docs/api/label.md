# PixelUI.Label

*Extends: PixelUI.Widget*

A text display widget with support for wrapping and alignment. Can display static or dynamic text with customizable alignment options.

## Properties

| Name | Type | Description |
|------|------|-------------|
| text | `string` | The text content to display |
| wrap | `boolean` | Whether to wrap text to fit within the widget bounds |
| align | `"left"\|"center"\|"right"` | Horizontal text alignment |
| verticalAlign | `"top"\|"middle"\|"bottom"` | Vertical text alignment |

## Methods

### new

```lua
new()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _wrapLine

```lua
_wrapLine()
```

### _updateLines

```lua
_updateLines()
```

### setText

```lua
setText()
```

### getText

```lua
getText()
```

### setWrap

```lua
setWrap()
```

### isWrapping

```lua
isWrapping()
```

### setHorizontalAlign

```lua
setHorizontalAlign()
```

### setVerticalAlign

```lua
setVerticalAlign()
```

### setSize

```lua
setSize()
```

### setBorder

```lua
setBorder()
```

### draw

```lua
draw()
```

