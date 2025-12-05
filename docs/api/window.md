# PixelUI.Window

*Extends: PixelUI.Frame*

A floating window widget with an optional title bar and dragging support. Extends Frame by adding chrome controls and layered ordering.

## Properties

| Name | Type | Description |
|------|------|-------------|
| draggable | `boolean` | Whether the window can be dragged by the title bar |
| resizable | `boolean` | Whether the window size can be adjusted via drag handles |
| closable | `boolean` | Whether the window shows a close button |
| maximizable | `boolean` | Whether the window shows a maximize/restore button |
| minimizable | `boolean` | Whether the window shows a minimize button |
| hideBorderWhenMaximized | `boolean` | Whether the border is hidden while maximized |
| minimizedHeight | `integer?` | Optional fixed height used when the window is minimized |
| private | `_titleBar` |  |
| private | `_titleLayoutCache` |  |
| private | `_titleButtonRects` |  |
| private | `_dragging` |  |
| private | `_dragSource` |  |
| private | `_dragIdentifier` |  |
| private | `_dragOffsetX` |  |
| private | `_dragOffsetY` |  |
| private | `_resizing` |  |
| private | `_resizeSource` |  |
| private | `_resizeIdentifier` |  |
| private | `_resizeEdges` |  |
| private | `_resizeStart` |  |
| private | `_isMaximized` |  |
| private | `_restoreRect` |  |

## Methods

### new

```lua
new()
```

### _refreshTitleBarState

```lua
_refreshTitleBarState()
```

### _invalidateTitleLayout

```lua
_invalidateTitleLayout()
```

### _isBorderVisible

```lua
_isBorderVisible()
```

### _computeInnerOffsets

```lua
_computeInnerOffsets()
```

### _resolveGeometryAnimation

```lua
_resolveGeometryAnimation()
```

### _stopGeometryAnimation

```lua
_stopGeometryAnimation()
```

### _applyGeometry

```lua
_applyGeometry()
```

### _transitionGeometry

```lua
_transitionGeometry()
```

### _computeTitleLayout

```lua
_computeTitleLayout()
```

### _hitTestTitleButton

```lua
_hitTestTitleButton()
```

### _drawTitleButton

```lua
_drawTitleButton()
```

### _fillTitleBarPixels

```lua
_fillTitleBarPixels()
```

### _hitTestResize

```lua
_hitTestResize()
```

### _beginResize

```lua
_beginResize()
```

### _updateResize

```lua
_updateResize()
```

### _endResize

```lua
_endResize()
```

### _restoreFromMaximize

```lua
_restoreFromMaximize()
```

### _computeMaximizedGeometry

```lua
_computeMaximizedGeometry()
```

### _computeMinimizedGeometry

```lua
_computeMinimizedGeometry()
```

### _captureRestoreRect

```lua
_captureRestoreRect()
```

### maximize

```lua
maximize()
```

### restore

```lua
restore()
```

### toggleMaximize

```lua
toggleMaximize()
```

### minimize

```lua
minimize()
```

### toggleMinimize

```lua
toggleMinimize()
```

### isMinimized

```lua
isMinimized()
```

### close

```lua
close()
```

### _getVisibleTitleBarHeight

```lua
_getVisibleTitleBarHeight()
```

### setTitleBar

```lua
setTitleBar()
```

### getTitleBar

```lua
getTitleBar()
```

### setDraggable

```lua
setDraggable()
```

### isDraggable

```lua
isDraggable()
```

### setResizable

```lua
setResizable()
```

### isResizable

```lua
isResizable()
```

### setClosable

```lua
setClosable()
```

### isClosable

```lua
isClosable()
```

### setMaximizable

```lua
setMaximizable()
```

### isMaximizable

```lua
isMaximizable()
```

### setMinimizable

```lua
setMinimizable()
```

### isMinimizable

```lua
isMinimizable()
```

### setHideBorderWhenMaximized

```lua
setHideBorderWhenMaximized()
```

### hidesBorderWhenMaximized

```lua
hidesBorderWhenMaximized()
```

### setMinimizedHeight

```lua
setMinimizedHeight()
```

### getMinimizedHeight

```lua
getMinimizedHeight()
```

### setGeometryAnimation

```lua
setGeometryAnimation()
```

### setOnMinimize

```lua
setOnMinimize()
```

### setTitle

```lua
setTitle()
```

### getContentOffset

```lua
getContentOffset()
```

### setSize

```lua
setSize()
```

### setBorder

```lua
setBorder()
```

### bringToFront

```lua
bringToFront()
```

### _pointInTitleBar

```lua
_pointInTitleBar()
```

### _beginDrag

```lua
_beginDrag()
```

### _updateDragPosition

```lua
_updateDragPosition()
```

### _endDrag

```lua
_endDrag()
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

-- Simple floating window
local window = app:window({
    x = 5, y = 3,
    width = 30, height = 12,
    title = "My Window",
    bg = colors.gray
})

window:addChild(app:label({
    x = 2, y = 2,
    text = "Window content here"
}))

app.root:addChild(window)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Feature-rich window with all controls
local window = app:window({
    x = 5, y = 3,
    width = 35, height = 15,
    title = "Advanced Window",
    draggable = true,
    resizable = true,
    closable = true,
    maximizable = true,
    minimizable = true,
    hideBorderWhenMaximized = true,
    bg = colors.black,
    border = { color = colors.gray }
})

-- Configure title bar
window:setTitleBar({
    enabled = true,
    height = 1,
    bg = colors.blue,
    fg = colors.white,
    align = "center"
})

-- Add window content
window:addChild(app:label({
    x = 2, y = 2,
    text = "Drag the title bar to move"
}))

window:addChild(app:label({
    x = 2, y = 4,
    text = "Drag corners to resize"
}))

-- Handle window events
window.onClose = function()
    return true  -- Allow close
end

window.onMaximize = function()
    -- Handle maximize
end

app.root:addChild(window)

app:run()
```

</details>

