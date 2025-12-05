# PixelUI.Dialog

*Extends: PixelUI.Window*

## Properties

| Name | Type | Description |
|------|------|-------------|
| modal | `boolean` | Whether the dialog should block interaction with other widgets |
| backdropColor | `PixelUI.Color?` | Optional fill color drawn behind the dialog when modal |
| backdropPixelColor | `PixelUI.Color?` | Pixel layer color for the backdrop when modal |
| closeOnBackdrop | `boolean` | Whether clicking the backdrop should close the dialog |
| closeOnEscape | `boolean` | Whether pressing escape closes the dialog |

## Methods

### new

```lua
new()
```

### setModal

```lua
setModal()
```

### isModal

```lua
isModal()
```

### setBackdropColor

```lua
setBackdropColor()
```

### getBackdropColor

```lua
getBackdropColor()
```

### setCloseOnBackdrop

```lua
setCloseOnBackdrop()
```

### setCloseOnEscape

```lua
setCloseOnEscape()
```

### draw

```lua
draw()
```

### _consumeModalEvent

```lua
_consumeModalEvent()
```

### handleEvent

```lua
handleEvent()
```

### close

```lua
close()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple modal dialog
local dialog = app:dialog({
    x = 10, y = 5,
    width = 30, height = 10,
    title = "Confirm",
    modal = true
})

dialog:addChild(app:label({
    x = 2, y = 2,
    text = "Are you sure?"
}))

app.root:addChild(dialog)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Modal dialog with backdrop and escape handling
local dialog = app:dialog({
    x = 10, y = 5,
    width = 35, height = 12,
    title = "Settings Dialog",
    modal = true,
    backdropColor = colors.black,
    backdropPixelColor = colors.gray,
    closeOnBackdrop = false,
    closeOnEscape = true,
    draggable = true,
    closable = true
})

dialog:addChild(app:checkbox({
    x = 2, y = 2,
    label = "Enable notifications"
}))

dialog:addChild(app:checkbox({
    x = 2, y = 4,
    label = "Auto-save"
}))

local saveBtn = app:button({
    x = 2, y = 7,
    width = 10, height = 1,
    label = "Save",
    onClick = function()
        dialog:close()
    end
})
dialog:addChild(saveBtn)

app.root:addChild(dialog)

app:run()
```

</details>

