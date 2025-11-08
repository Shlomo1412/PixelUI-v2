# PixelUI.Dialog

*Extends: PixelUI.Window*

A modal window widget that optionally darkens the background and blocks interaction with the rest of the UI until it closes.

## Properties

| Name | Type | Description |
|------|------|-------------|
| modal | `boolean` | Whether the dialog is currently modal. |
| backdropColor | `PixelUI.Color?` | Default tint colour applied to the pixel layer when the dialog is modal (defaults to `colors.gray` when unset). |
| backdropPixelColor | `PixelUI.Color?` | Pixel-layer colour drawn behind the dialog while it is modal. |
| closeOnBackdrop | `boolean` | Close the dialog when the backdrop is clicked. |
| closeOnEscape | `boolean` | Close the dialog when the Escape key is pressed. |

Modal dialogs now tint only the pixel layer so the underlying background remains visible, and child widgets are clipped to the window bounds to prevent overflow.

## Methods

### new

```lua
local dialog = app:createDialog({
  title = "Confirm",
  width = 28,
  height = 9,
  modal = true,
  closeOnBackdrop = true
})
```

### setModal

```lua
dialog:setModal(true)
```
Toggle modal behaviour dynamically.

### isModal

```lua
local modal = dialog:isModal()
```
Return the current modal state.

### setBackdropColor

```lua
dialog:setBackdropColor(colors.gray, colors.gray)
```
Set the modal backdrop tint; pass `false` to disable shading for either argument.

### getBackdropColor

```lua
local color = dialog:getBackdropColor()
```
Retrieve the active character-layer backdrop color.

### setCloseOnBackdrop

```lua
dialog:setCloseOnBackdrop(true)
```
Enable or disable closing when the backdrop is clicked.

### setCloseOnEscape

```lua
dialog:setCloseOnEscape(true)
```
Enable or disable closing via the Escape key.

### handleEvent

```lua
local consumed = dialog:handleEvent(event, ...)
```
Process events; modal dialogs consume keyboard and pointer input outside their bounds.

### close

```lua
dialog:close()
```
Close the dialog and release modal capture.

## Example

```lua
local dialog = app:createDialog({
  title = "Example Dialog",
  width = 32,
  height = 10,
  modal = true,
  backdropColor = colors.gray,
  closeOnBackdrop = true
})

local offsetX, offsetY = dialog:getContentOffset()
local contentLabel = app:createLabel({
  x = offsetX + 1,
  y = offsetY + 1,
  width = dialog.width - offsetX - 1,
  height = dialog.height - offsetY - 2,
  wrap = true,
  text = "Dialogs block interaction outside of their bounds.",
  bg = colors.black,
  fg = colors.white
})

dialog:addChild(contentLabel)
root:addChild(dialog)
```
