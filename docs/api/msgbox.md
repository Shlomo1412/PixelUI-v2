# PixelUI.MsgBox

*Extends: PixelUI.Dialog*

A specialised dialog that renders a message with a configurable set of action buttons. Buttons report a result identifier and can optionally keep the message box open.

## Properties

| Name | Type | Description |
|------|------|-------------|
| autoClose | `boolean` | Automatically close after a button press when the handler does not return `false`. |
| buttonAlign | `"left"|"center"|"right"` | Alignment for the button row. |

Message boxes inherit the dialog backdrop tinting (default `colors.gray`): modal overlays affect only the pixel layer so the base UI stays visible, and button/content rendering is clipped to the message box bounds.

## Methods

### new

```lua
local box = app:createMsgBox({
  title = "Unsaved Changes",
  message = "Save before closing?",
  buttons = {
    { id = "save", label = "Save" },
    { id = "discard", label = "Discard" },
    { id = "cancel", label = "Cancel", autoClose = true }
  }
})
```

### setMessage

```lua
box:setMessage("Overwrite the existing record?")
```
Update the message text and reflow the layout.

### getMessage

```lua
local text = box:getMessage()
```
Return the current message text.

### setOnResult

```lua
box:setOnResult(function(_, id)
  print("Pressed", id)
end)
```
Register a callback that receives the button identifier and widget instance.

### setButtons

```lua
box:setButtons({
  { id = "retry", label = "Retry" },
  { id = "cancel", label = "Cancel", autoClose = true }
})
```
Replace the button collection. Widths are normalised and the layout is refreshed.

### setButtonAlign

```lua
box:setButtonAlign("right")
```
Control horizontal alignment for the button bar.

### setAutoClose

```lua
box:setAutoClose(false)
```
Toggle the default auto-close behaviour applied to new buttons.

### setButtonGap

```lua
box:setButtonGap(1)
```
Adjust spacing between adjacent buttons.

## Example

```lua
local box = app:createMsgBox({
  title = "Delete",
  message = "This action cannot be undone.",
  buttonAlign = "right",
  buttons = {
    { id = "delete", label = "Delete", bg = colors.red, fg = colors.white },
    { id = "cancel", label = "Cancel", autoClose = true }
  }
})

box:setOnResult(function(_, id)
  if id == "delete" then
    performDeletion()
  end
end)

root:addChild(box)
```
