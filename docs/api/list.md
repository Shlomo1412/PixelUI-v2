# PixelUI.List

*Extends: PixelUI.Widget*

A scrollable list widget for displaying and selecting items. Supports keyboard and mouse navigation.

## Properties

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` | Array of items to display |
| selectedIndex | `integer` | Index of currently selected item |
| highlightBg | `PixelUI.Color` | Background color for selected item |
| highlightFg | `PixelUI.Color` | Foreground color for selected item |
| placeholder | `string?` | Text shown when list is empty |
| onSelect | `fun(self:PixelUI.List,` |  |
| scrollbar | `PixelUI.ScrollbarConfig?` | Optional scrollbar configuration |

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

### _computeLayoutMetrics

```lua
_computeLayoutMetrics()
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

### setScrollbar

```lua
setScrollbar()
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

