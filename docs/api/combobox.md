# PixelUI.ComboBox

*Extends: PixelUI.Widget*

A dropdown selection widget (combo box) for choosing from a list of options. Opens a dropdown menu when clicked.

## Properties

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` | Array of selectable items |
| selectedIndex | `integer` | Index of currently selected item |
| dropdownBg | `PixelUI.Color` | Background color for dropdown menu |
| dropdownFg | `PixelUI.Color` | Foreground color for dropdown menu |
| highlightBg | `PixelUI.Color` | Background color for highlighted item |
| highlightFg | `PixelUI.Color` | Foreground color for highlighted item |
| placeholder | `string?` | Text shown when no item is selected |
| onChange | `fun(self:PixelUI.ComboBox,` |  |

## Methods

### new

```lua
new()
```

### _normalizeSelection

```lua
_normalizeSelection()
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

### setOnChange

```lua
setOnChange()
```

### _notifyChange

```lua
_notifyChange()
```

### _setOpen

```lua
_setOpen()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _isPointInDropdown

```lua
_isPointInDropdown()
```

### _indexFromPoint

```lua
_indexFromPoint()
```

### _handlePress

```lua
_handlePress()
```

### draw

```lua
draw()
```

### _drawDropdown

```lua
_drawDropdown()
```

### handleEvent

```lua
handleEvent()
```

