# PixelUI.RadioButton

*Extends: PixelUI.Widget*

A radio button widget for exclusive selection within a group. Only one radio button in a group can be selected at a time.

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Label text displayed next to the radio button |
| value | `any` | Value associated with this radio button |
| group | `string?` | Group identifier for exclusive selection |
| selected | `boolean` | Whether this radio button is selected |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| onChange | `fun(self:PixelUI.RadioButton,` |  |

## Methods

### new

```lua
new()
```

### _registerWithGroup

```lua
_registerWithGroup()
```

### _unregisterFromGroup

```lua
_unregisterFromGroup()
```

### _notifyChange

```lua
_notifyChange()
```

### _applySelection

```lua
_applySelection()
```

### setLabel

```lua
setLabel()
```

### setValue

```lua
setValue()
```

### getValue

```lua
getValue()
```

### setGroup

```lua
setGroup()
```

### getGroup

```lua
getGroup()
```

### setOnChange

```lua
setOnChange()
```

### setSelected

```lua
setSelected()
```

### isSelected

```lua
isSelected()
```

### _activate

```lua
_activate()
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

-- Radio button group
local radio1 = app:radiobutton({
    x = 2, y = 2,
    label = "Option A",
    value = "a",
    group = "options",
    selected = true
})

local radio2 = app:radiobutton({
    x = 2, y = 4,
    label = "Option B",
    value = "b",
    group = "options"
})

app.root:addChild(radio1)
app.root:addChild(radio2)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Radio buttons with change handler and styling
local selectionLabel = app:label({
    x = 2, y = 10,
    text = "Selected: Small",
    fg = colors.white
})

local sizes = {
    { label = "Small", value = "sm" },
    { label = "Medium", value = "md" },
    { label = "Large", value = "lg" },
    { label = "Extra Large", value = "xl" }
}

for i, size in ipairs(sizes) do
    local radio = app:radiobutton({
        x = 2, y = 1 + (i * 2),
        label = size.label,
        value = size.value,
        group = "size",
        selected = (i == 1),
        focusBg = colors.blue,
        focusFg = colors.white,
        onChange = function(self, selected, value)
            if selected then
                selectionLabel:setText("Selected: " .. self.label)
            end
        end
    })
    app.root:addChild(radio)
end

app.root:addChild(selectionLabel)

app:run()
```

</details>

