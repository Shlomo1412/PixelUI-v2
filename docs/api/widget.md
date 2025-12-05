# PixelUI.Widget

Base class for all UI widgets. Provides common properties and behavior for positioning, sizing, styling, and event handling.

## Properties

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` | The application instance that owns this widget |
| parent | `PixelUI.Frame?` | The parent frame containing this widget |
| x | `integer` | X position relative to parent |
| y | `integer` | Y position relative to parent |
| width | `integer` | Width in characters |
| height | `integer` | Height in characters |
| bg | `PixelUI.Color` | Background color |
| fg | `PixelUI.Color` | Foreground/text color |
| _orderIndex | `integer?` | Internal ordering index |
| visible | `boolean` | Whether the widget is visible |
| z | `number` | Z-order for layering (higher values appear on top) |
| border | `PixelUI.NormalizedBorderConfig?` | Border configuration |
| id | `string?` | Optional unique identifier |
| focusable | `boolean` | Whether the widget can receive focus |
| constraints | `PixelUI.NormalizedConstraintConfig?` | Optional size constraints |
| draw | `fun(self:PixelUI.Widget,` |  |
| handleEvent | `fun(self:PixelUI.Widget,` |  |
| setFocused | `fun(self:PixelUI.Widget,` |  |
| isFocused | `fun(self:PixelUI.Widget):boolean` | Check if widget has focus |

## Methods

### _init_base

```lua
_init_base()
```

### setSize

```lua
setSize()
```

### _applyConstraintLayout

```lua
_applyConstraintLayout()
```

### _applySizeConstraints

```lua
_applySizeConstraints()
```

### setConstraints

```lua
setConstraints()
```

### getConstraints

```lua
getConstraints()
```

### setPosition

```lua
setPosition(y)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| y | `integer` |  |

### setZ

*Since: 0.1.0*

```lua
setZ(z)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| z | `number` |  |

### setBorder

*Since: 0.1.0*

```lua
setBorder(borderConfig)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| borderConfig | `PixelUI.BorderConfig\|boolean\|nil` |  |

### isFocused

*Since: 0.1.0*

```lua
isFocused()
```

**Returns:**

- `boolean`

### setFocused

*Since: 0.1.0*

```lua
setFocused(focused)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| focused | `boolean` |  |

### onFocusChanged

*Since: 0.1.0*

```lua
onFocusChanged(_focused)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _focused | `boolean` |  |

### getAbsoluteRect

*Since: 0.1.0*

```lua
getAbsoluteRect()
```

**Returns:**

- `integer` - x
- `integer` - y
- `integer` - width
- `integer` - height

### getSize

*Since: 0.1.0*

```lua
getSize()
```

**Returns:**

- `integer` - width
- `integer` - height

### containsPoint

```lua
containsPoint(px, py)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| px | `integer` |  |
| py | `integer` |  |

**Returns:**

- `boolean`

### draw

*Since: 0.1.0*

```lua
draw(_textLayer, _pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _textLayer | `Layer` |  |
| _pixelLayer | `Layer` |  |

### handleEvent

*Since: 0.1.0*

```lua
handleEvent(_event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _event | `string` |  |

**Returns:**

- `boolean` - consumed

