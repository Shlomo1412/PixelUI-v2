# PixelUI.TreeView

*Extends: PixelUI.Widget*

A hierarchical tree view widget for displaying nested data. Supports expand/collapse and selection of nodes.

## Properties

| Name | Type | Description |
|------|------|-------------|
| indentWidth | `integer` | Width of indentation per level |
| highlightBg | `PixelUI.Color` | Background color for selected node |
| highlightFg | `PixelUI.Color` | Foreground color for selected node |
| placeholder | `string?` | Text shown when tree is empty |
| onSelect | `fun(self:PixelUI.TreeView,` |  |
| onToggle | `fun(self:PixelUI.TreeView,` |  |

## Methods

### new

```lua
new()
```

### setOnSelect

```lua
setOnSelect()
```

### setOnToggle

```lua
setOnToggle()
```

### _copyNodes

```lua
_copyNodes()
```

### setNodes

```lua
setNodes()
```

### getSelectedNode

```lua
getSelectedNode()
```

### setSelectedNode

```lua
setSelectedNode()
```

### expandNode

```lua
expandNode()
```

### collapseNode

```lua
collapseNode()
```

### toggleNode

```lua
toggleNode()
```

### _rebuildFlatNodes

```lua
_rebuildFlatNodes()
```

### _findVisibleIndex

```lua
_findVisibleIndex()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _getInnerHeight

```lua
_getInnerHeight()
```

### _ensureSelectionVisible

```lua
_ensureSelectionVisible()
```

### _setSelectedIndex

```lua
_setSelectedIndex()
```

### _selectNode

```lua
_selectNode()
```

### _moveSelection

```lua
_moveSelection()
```

### _scrollBy

```lua
_scrollBy()
```

### _rowFromPoint

```lua
_rowFromPoint()
```

### _toggleNode

```lua
_toggleNode()
```

### _notifySelect

```lua
_notifySelect()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _searchForPrefix

```lua
_searchForPrefix()
```

### _handleTypeSearch

```lua
_handleTypeSearch()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

