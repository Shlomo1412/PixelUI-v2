# PixelUI.Table

*Extends: PixelUI.Widget*

## Properties

| Name | Type | Description |
|------|------|-------------|
| columns | `PixelUI.TableColumn[]` |  |
| data | `table[]` |  |
| sortColumn | `string?` |  |
| sortDirection | `"asc"\|"desc"` |  |
| allowRowSelection | `boolean` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string` |  |
| onSelect | `fun(self:PixelUI.Table,` |  |
| onSort | `fun(self:PixelUI.Table,` |  |

## Methods

### new

```lua
new()
```

### _normalizeColumns

```lua
_normalizeColumns()
```

### _recomputeColumnMetrics

```lua
_recomputeColumnMetrics()
```

### _ensureColumnsForData

```lua
_ensureColumnsForData()
```

### setColumns

```lua
setColumns()
```

### getColumns

```lua
getColumns()
```

### setData

```lua
setData()
```

### getData

```lua
getData()
```

### _refreshRows

```lua
_refreshRows()
```

### _getColumnById

```lua
_getColumnById()
```

### _applySort

```lua
_applySort()
```

### setSort

```lua
setSort()
```

### getSort

```lua
getSort()
```

### setOnSort

```lua
setOnSort()
```

### setOnSelect

```lua
setOnSelect()
```

### getSelectedIndex

```lua
getSelectedIndex()
```

### getSelectedRow

```lua
getSelectedRow()
```

### setSelectedIndex

```lua
setSelectedIndex()
```

### _notifySelect

```lua
_notifySelect()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _getRowsVisible

```lua
_getRowsVisible()
```

### _clampScroll

```lua
_clampScroll()
```

### _ensureSelectionVisible

```lua
_ensureSelectionVisible()
```

### _rowFromPoint

```lua
_rowFromPoint()
```

### _columnFromPoint

```lua
_columnFromPoint()
```

### _formatCell

```lua
_formatCell()
```

### draw

```lua
draw()
```

### _handleTypeSearch

```lua
_handleTypeSearch()
```

### _searchForPrefix

```lua
_searchForPrefix()
```

### onFocusChanged

```lua
onFocusChanged()
```

### handleEvent

```lua
handleEvent()
```

