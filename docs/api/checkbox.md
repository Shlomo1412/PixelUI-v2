# PixelUI.CheckBox

*Extends: PixelUI.Widget*

A checkbox widget with support for checked, unchecked, and indeterminate states. Provides visual feedback and change callbacks.

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Label text displayed next to the checkbox |
| checked | `boolean` | Whether the checkbox is checked |
| indeterminate | `boolean` | Whether the checkbox is in an indeterminate state |
| allowIndeterminate | `boolean` | Whether the indeterminate state is allowed |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| onChange | `fun(self:PixelUI.CheckBox,` |  |

## Methods

### new

```lua
new()
```

### _notifyChange

```lua
_notifyChange()
```

### _setState

```lua
_setState()
```

### setLabel

```lua
setLabel()
```

### setOnChange

```lua
setOnChange()
```

### setAllowIndeterminate

```lua
setAllowIndeterminate()
```

### setChecked

```lua
setChecked()
```

### isChecked

```lua
isChecked()
```

### setIndeterminate

```lua
setIndeterminate()
```

### isIndeterminate

```lua
isIndeterminate()
```

### toggle

```lua
toggle()
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

-- Simple checkbox
local checkbox = app:checkbox({
    x = 2, y = 2,
    label = "Enable feature",
    checked = false,
    onChange = function(self, checked)
        -- Handle state change
    end
})
app.root:addChild(checkbox)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Checkbox with indeterminate state and focus styling
local parentCheck = app:checkbox({
    x = 2, y = 2,
    label = "Select All",
    checked = false,
    allowIndeterminate = true,
    focusBg = colors.blue,
    focusFg = colors.white
})

local child1 = app:checkbox({ x = 4, y = 4, label = "Option 1" })
local child2 = app:checkbox({ x = 4, y = 6, label = "Option 2" })

-- Sync parent state with children
local function updateParent()
    local c1, c2 = child1.checked, child2.checked
    if c1 and c2 then
        parentCheck:setChecked(true)
        parentCheck:setIndeterminate(false)
    elseif not c1 and not c2 then
        parentCheck:setChecked(false)
        parentCheck:setIndeterminate(false)
    else
        parentCheck:setIndeterminate(true)
    end
end

child1.onChange = function() updateParent() end
child2.onChange = function() updateParent() end

app.root:addChild(parentCheck)
app.root:addChild(child1)
app.root:addChild(child2)

app:run()
```

</details>

