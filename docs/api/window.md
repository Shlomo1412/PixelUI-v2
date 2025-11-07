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

### _computeTitleLayout

```lua
_computeTitleLayout()
```

### _hitTestTitleButton

```lua
_hitTestTitleButton()
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

