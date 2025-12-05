# PixelUI.ComboBox

*Extends: PixelUI.Widget*

A dropdown selection widget (combo box) for choosing from a list of options. Opens a dropdown menu when clicked.

## Properties

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` | Array of selectable items |
| selectedIndex | `integer` | Index of currently selected item |
| dropdownBg | `PixelUI.Color` | Background color for dropdown menu |
| dropdownFg | `PixelUI.Color` | Foreground color for dropdown menu |
| highlightBg | `PixelUI.Color` | Background color for highlighted item |
| highlightFg | `PixelUI.Color` | Foreground color for highlighted item |
| placeholder | `string?` | Text shown when no item is selected |
| onChange | `fun(self:PixelUI.ComboBox,` |  |

## Methods

### new

```lua
new()
```

### _normalizeSelection

```lua
_normalizeSelection()
```

### setItems

```lua
setItems()
```

### getSelectedItem

```lua
getSelectedItem()
```

### setSelectedIndex

```lua
setSelectedIndex()
```

### setOnChange

```lua
setOnChange()
```

### _notifyChange

```lua
_notifyChange()
```

### _setOpen

```lua
_setOpen()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _isPointInDropdown

```lua
_isPointInDropdown()
```

### _indexFromPoint

```lua
_indexFromPoint()
```

### _handlePress

```lua
_handlePress()
```

### draw

```lua
draw()
```

### _drawDropdown

```lua
_drawDropdown()
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

-- Simple dropdown selection
local combo = app:combobox({
    x = 2, y = 2,
    width = 15, height = 1,
    items = { "Small", "Medium", "Large" },
    placeholder = "Select size",
    onChange = function(self, item, index)
        -- Handle selection change
    end
})
app.root:addChild(combo)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Styled combobox with dynamic updates
local selectedLabel = app:label({
    x = 2, y = 5,
    text = "Color: none",
    fg = colors.white
})

local combo = app:combobox({
    x = 2, y = 2,
    width = 18, height = 1,
    items = { "Red", "Green", "Blue", "Yellow", "Purple" },
    selectedIndex = 0,
    placeholder = "Choose color",
    dropdownBg = colors.gray,
    dropdownFg = colors.white,
    highlightBg = colors.blue,
    highlightFg = colors.white,
    onChange = function(self, item, index)
        selectedLabel:setText("Color: " .. (item or "none"))
        local colorMap = {
            Red = colors.red,
            Green = colors.green,
            Blue = colors.blue,
            Yellow = colors.yellow,
            Purple = colors.purple
        }
        if item and colorMap[item] then
            selectedLabel.fg = colorMap[item]
        end
    end
})

app.root:addChild(combo)
app.root:addChild(selectedLabel)

app:run()
```

</details>

