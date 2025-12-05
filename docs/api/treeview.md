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
| scrollbar | `PixelUI.ScrollbarConfig?` | Optional scrollbar configuration |

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

### setScrollbar

```lua
setScrollbar()
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

### _computeLayoutMetrics

```lua
_computeLayoutMetrics()
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

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple tree view
local tree = app:treeview({
    x = 2, y = 2,
    width = 25, height = 10,
    onSelect = function(self, node, index)
        -- Handle node selection
    end
})

-- Add root nodes
tree:addNode({ label = "Documents" })
tree:addNode({ label = "Pictures" })
tree:addNode({ label = "Music" })

app.root:addChild(tree)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Hierarchical tree with nested nodes
local infoLabel = app:label({
    x = 30, y = 2,
    text = "Select a file",
    fg = colors.lightGray
})

local tree = app:treeview({
    x = 2, y = 2,
    width = 25, height = 12,
    indentWidth = 2,
    highlightBg = colors.blue,
    highlightFg = colors.white,
    scrollbar = { enabled = true },
    onSelect = function(self, node, index)
        if node then
            infoLabel:setText("File: " .. node.label)
        end
    end,
    onToggle = function(self, node, expanded)
        -- Handle expand/collapse
    end
})

-- Build file tree structure
local docs = tree:addNode({ label = "Documents", expanded = true })
tree:addChildNode(docs, { label = "report.txt", data = { size = 1024 } })
tree:addChildNode(docs, { label = "notes.md", data = { size = 512 } })

local pics = tree:addNode({ label = "Pictures", expanded = false })
tree:addChildNode(pics, { label = "photo1.png" })
tree:addChildNode(pics, { label = "photo2.png" })

app.root:addChild(tree)
app.root:addChild(infoLabel)

app:run()
```

</details>

