# PixelUI.MsgBox

*Extends: PixelUI.Dialog*

## Properties

| Name | Type | Description |
|------|------|-------------|
| autoClose | `boolean` | Whether the dialog should close automatically after a button press |
| buttonAlign | `"left"\|"center"\|"right"` | Horizontal alignment of the button row |

## Methods

### new

```lua
new()
```

### setMessage

```lua
setMessage()
```

### getMessage

```lua
getMessage()
```

### setOnResult

```lua
setOnResult()
```

### _createButtonEntry

```lua
_createButtonEntry()
```

### setButtons

```lua
setButtons()
```

### _handleButtonSelection

```lua
_handleButtonSelection()
```

### setButtonAlign

```lua
setButtonAlign()
```

### setAutoClose

```lua
setAutoClose()
```

### setButtonGap

```lua
setButtonGap()
```

### _updateLayout

```lua
_updateLayout()
```

### setSize

```lua
setSize()
```

### setBorder

```lua
setBorder()
```

### setTitleBar

```lua
setTitleBar()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple message box
local msgbox = app:msgbox({
    x = 10, y = 5,
    width = 30, height = 8,
    title = "Info",
    message = "Operation completed!"
})

app.root:addChild(msgbox)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Message box with custom buttons and callbacks
local msgbox = app:msgbox({
    x = 10, y = 5,
    width = 35, height = 10,
    title = "Confirm Action",
    message = "Do you want to save changes before closing?",
    autoClose = true,
    buttonAlign = "center",
    buttons = {
        {
            id = "save",
            label = "Save",
            bg = colors.green,
            fg = colors.white,
            onSelect = function(self, id, button)
                -- Save logic here
            end
        },
        {
            id = "discard",
            label = "Discard",
            bg = colors.red,
            fg = colors.white
        },
        {
            id = "cancel",
            label = "Cancel",
            autoClose = false,  -- Don't close on this button
            onSelect = function(self, id, button)
                -- Stay open
            end
        }
    }
})

app.root:addChild(msgbox)

app:run()
```

</details>

