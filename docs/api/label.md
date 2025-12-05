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

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple text label
local label = app:label({
    x = 2, y = 2,
    text = "Hello World!",
    fg = colors.yellow,
    bg = colors.black
})
app.root:addChild(label)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Multi-line label with wrapping and alignment
local label = app:label({
    x = 2, y = 2,
    width = 25,
    height = 5,
    text = "This is a long text that will wrap automatically to fit within the bounds.",
    wrap = true,
    align = "center",
    verticalAlign = "middle",
    fg = colors.white,
    bg = colors.gray,
    border = { color = colors.lightGray }
})
app.root:addChild(label)

-- Update label dynamically
label:setText("New text content")

app:run()
```

</details>

