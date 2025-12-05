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

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple data table
local table = app:table({
    x = 2, y = 2,
    width = 40, height = 10,
    columns = {
        { id = "name", title = "Name", key = "name" },
        { id = "age", title = "Age", key = "age" }
    },
    data = {
        { name = "Alice", age = 25 },
        { name = "Bob", age = 30 },
        { name = "Charlie", age = 35 }
    }
})
app.root:addChild(table)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Sortable table with selection and formatting
local table = app:table({
    x = 2, y = 2,
    width = 50, height = 12,
    columns = {
        { 
            id = "name", 
            title = "Product", 
            key = "name",
            width = 15,
            sortable = true
        },
        { 
            id = "price", 
            title = "Price", 
            key = "price",
            width = 10,
            align = "right",
            sortable = true,
            format = function(value)
                return string.format("$%.2f", value)
            end
        },
        { 
            id = "qty", 
            title = "Qty", 
            key = "quantity",
            width = 8,
            align = "center"
        }
    },
    data = {
        { name = "Widget", price = 9.99, quantity = 100 },
        { name = "Gadget", price = 24.99, quantity = 50 },
        { name = "Gizmo", price = 14.99, quantity = 75 }
    },
    allowRowSelection = true,
    highlightBg = colors.blue,
    highlightFg = colors.white,
    scrollbar = { enabled = true },
    onSelect = function(self, row, index)
        if row then
            -- Handle row selection
        end
    end,
    onSort = function(self, columnId, direction)
        -- Handle sort change
    end
})

app.root:addChild(table)

app:run()
```

</details>

