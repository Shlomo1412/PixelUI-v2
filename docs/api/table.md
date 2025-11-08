# PixelUI.Table

*Extends: PixelUI.Widget*

A data table widget with sorting and selection capabilities. Displays tabular data with customizable columns and row selection.

## Properties

| Name | Type | Description |
|------|------|-------------|
| columns | `PixelUI.TableColumn[]` | Array of column definitions |
| data | `table[]` | Array of row data objects |
| sortColumn | `string?` | ID of currently sorted column |
| sortDirection | `"asc"\|"desc"` | Sort direction (ascending or descending) |
| allowRowSelection | `boolean` | Whether rows can be selected |
| highlightBg | `PixelUI.Color` | Background color for selected row |
| highlightFg | `PixelUI.Color` | Foreground color for selected row |
| placeholder | `string` | Text shown when table is empty |
| onSelect | `fun(self:PixelUI.Table,` |  |
| onSort | `fun(self:PixelUI.Table,` |  |
| scrollbar | `PixelUI.ScrollbarConfig?` | Optional scrollbar configuration |

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

### setScrollbar

```lua
setScrollbar()
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

### _computeLayoutMetrics

```lua
_computeLayoutMetrics()
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

