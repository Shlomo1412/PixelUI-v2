# PixelUI.Frame

*Extends: PixelUI.Widget*

A container widget that can hold child widgets. Serves as the base for layout organization and hierarchy.

## Properties

| Name | Type | Description |
|------|------|-------------|
| private | `_children` |  |
| private | `_orderCounter` |  |
| title | `string?` | Optional frame title |

## Methods

### new

```lua
new()
```

### addChild

*Since: 0.1.0*

```lua
addChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

### _applyConstraintsToChildren

```lua
_applyConstraintsToChildren()
```

### setSize

```lua
setSize()
```

### setOnSizeChange

```lua
setOnSizeChange()
```

### removeChild

```lua
removeChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

### getChildren

*Since: 0.1.0*

```lua
getChildren()
```

**Returns:**

- `PixelUI.Widget[]`

### setTitle

*Since: 0.1.0*

```lua
setTitle(title)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| title | `string?` |  |

### draw

```lua
draw(textLayer, pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| textLayer | `Layer` |  |
| pixelLayer | `Layer` |  |

### handleEvent

*Since: 0.1.0*

```lua
handleEvent(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Create a simple frame container
local frame = app:frame({
    x = 5, y = 3,
    width = 20, height = 8,
    bg = colors.blue,
    border = { color = colors.white }
})
app.root:addChild(frame)

-- Add a label inside the frame
frame:addChild(app:label({
    x = 2, y = 2,
    text = "Inside frame"
}))

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Create nested frames with constraints
local outerFrame = app:frame({
    x = 2, y = 2,
    width = 40, height = 15,
    bg = colors.gray,
    border = { color = colors.lightGray, thickness = 2 }
})
app.root:addChild(outerFrame)

-- Inner frame with percentage-based sizing
local innerFrame = app:frame({
    constraints = {
        centerX = true,
        centerY = true,
        widthPercent = 0.8,
        heightPercent = 0.6
    },
    bg = colors.black
})
outerFrame:addChild(innerFrame)

-- Add title to outer frame
outerFrame.title = "Nested Frames"

app:run()
```

</details>

