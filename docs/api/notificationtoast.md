# PixelUI.NotificationToast

*Extends: PixelUI.Widget*

A notification toast widget for displaying temporary messages. Supports different severity levels and auto-hide functionality.

## Properties

| Name | Type | Description |
|------|------|-------------|
| title | `string?` | Optional title text |
| message | `string` | The notification message content |
| severity | `string` | Severity level (e.g., "info", "success", "warning", "error") |
| autoHide | `boolean` | Whether to automatically hide after duration |
| duration | `number` | Duration in seconds before auto-hiding |
| dismissOnClick | `boolean` | Whether clicking dismisses the notification |

## Methods

### new

```lua
new()
```

### _applyPadding

```lua
_applyPadding()
```

### setPadding

```lua
setPadding()
```

### getAnchor

```lua
getAnchor()
```

### getAnchorMargins

```lua
getAnchorMargins()
```

### refreshAnchor

```lua
refreshAnchor()
```

### setAnchor

```lua
setAnchor()
```

### setAnchorMargin

```lua
setAnchorMargin()
```

### _computeAnchorPosition

```lua
_computeAnchorPosition()
```

### getAnchorTargetPosition

```lua
getAnchorTargetPosition()
```

### _applyAnchorPosition

```lua
_applyAnchorPosition()
```

### _getActiveBorder

```lua
_getActiveBorder()
```

### _refreshWrap

```lua
_refreshWrap()
```

### _getStyle

```lua
_getStyle()
```

### _cancelTimer

```lua
_cancelTimer()
```

### _scheduleHide

```lua
_scheduleHide()
```

### setTitle

```lua
setTitle()
```

### getTitle

```lua
getTitle()
```

### setMessage

```lua
setMessage()
```

### getMessage

```lua
getMessage()
```

### setSeverity

```lua
setSeverity()
```

### getSeverity

```lua
getSeverity()
```

### setIcon

```lua
setIcon()
```

### getIcon

```lua
getIcon()
```

### setAutoHide

```lua
setAutoHide()
```

### isAutoHide

```lua
isAutoHide()
```

### setDuration

```lua
setDuration()
```

### getDuration

```lua
getDuration()
```

### setDismissOnClick

```lua
setDismissOnClick()
```

### isDismissOnClick

```lua
isDismissOnClick()
```

### setOnDismiss

```lua
setOnDismiss()
```

### setVariants

```lua
setVariants()
```

### setStyle

```lua
setStyle()
```

### present

```lua
present()
```

### show

```lua
show()
```

### hide

```lua
hide()
```

### setSize

```lua
setSize()
```

### setBorder

```lua
setBorder()
```

### _renderLine

```lua
_renderLine()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

### onFocusChanged

```lua
onFocusChanged()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple notification toast
local toast = app:notificationtoast({
    x = 2, y = 2,
    width = 30, height = 3,
    message = "File saved successfully",
    severity = "success",
    autoHide = true,
    duration = 3
})
app.root:addChild(toast)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Multiple notification types
local function showNotification(msg, severity, y)
    local toast = app:notificationtoast({
        x = 2, y = y,
        width = 35, height = 4,
        title = severity:upper(),
        message = msg,
        severity = severity,
        autoHide = true,
        duration = 5,
        dismissOnClick = true
    })
    app.root:addChild(toast)
end

showNotification("Information message", "info", 2)
showNotification("Operation successful", "success", 7)
showNotification("Warning: Low memory", "warning", 12)
showNotification("Error: Connection failed", "error", 17)

app:run()
```

</details>

