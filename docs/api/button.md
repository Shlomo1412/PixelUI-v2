# PixelUI.Button

*Extends: PixelUI.Widget*

A clickable button widget with press effects and event callbacks. Supports click, press, and release events with visual feedback.

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` | The text displayed on the button |
| onPress | `fun(self:PixelUI.Button,` |  |
| onRelease | `fun(self:PixelUI.Button,` |  |
| onClick | `fun(self:PixelUI.Button,` |  |
| clickEffect | `boolean` | Whether to show a visual press effect |
| private | `_pressed` |  |

## Methods

### new

```lua
new()
```

### setLabel

*Since: 0.1.0*

```lua
setLabel(text)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| text | `string` |  |

### setOnClick

*Since: 0.1.0*

```lua
setOnClick(handler)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| handler | `fun(self:PixelUI.Button,` | button:integer, x:integer, y:integer)? |

### draw

*Since: 0.1.0*

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

-- Create a simple clickable button
local button = app:button({
    x = 5, y = 3,
    width = 12, height = 3,
    label = "Click Me",
    bg = colors.blue,
    fg = colors.white,
    onClick = function(self)
        self:setLabel("Clicked!")
    end
})
app.root:addChild(button)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Button with all event callbacks and styling
local counter = 0
local countLabel = app:label({
    x = 5, y = 8,
    text = "Count: 0",
    fg = colors.white
})
app.root:addChild(countLabel)

local button = app:button({
    x = 5, y = 3,
    width = 15, height = 3,
    label = "Press & Hold",
    bg = colors.green,
    fg = colors.white,
    clickEffect = true,
    border = { color = colors.lime },
    onPress = function(self, btn, x, y)
        self.bg = colors.lime
    end,
    onRelease = function(self, btn, x, y)
        self.bg = colors.green
    end,
    onClick = function(self, btn, x, y)
        counter = counter + 1
        countLabel:setText("Count: " .. counter)
    end
})
app.root:addChild(button)

app:run()
```

</details>

