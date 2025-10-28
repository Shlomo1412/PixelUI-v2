# PixelUI.List

*Extends: PixelUI.Widget*

## Properties

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` |  |
| selectedIndex | `integer` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string?` |  |
| onSelect | `fun(self:PixelUI.List,` |  |

## Methods

### new

```lua
new()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _getInnerHeight

```lua
_getInnerHeight()
```

### _clampScroll

```lua
_clampScroll()
```

### _ensureSelectionVisible

```lua
_ensureSelectionVisible()
```

### _normalizeSelection

```lua
_normalizeSelection()
```

### getItems

```lua
getItems()
```

### setItems

```lua
setItems()
```

### getSelectedItem

```lua
getSelectedItem()
```

### setSelectedIndex

```lua
setSelectedIndex()
```

### getSelectedIndex

```lua
getSelectedIndex()
```

### setOnSelect

```lua
setOnSelect()
```

### setPlaceholder

```lua
setPlaceholder()
```

### setHighlightColors

```lua
setHighlightColors()
```

### _notifySelect

```lua
_notifySelect()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _itemIndexFromPoint

```lua
_itemIndexFromPoint()
```

### _moveSelection

```lua
_moveSelection()
```

### _scrollBy

```lua
_scrollBy()
```

### _handleTypeSearch

```lua
_handleTypeSearch()
```

### _searchForPrefix

```lua
_searchForPrefix()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

