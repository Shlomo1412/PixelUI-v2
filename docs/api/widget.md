# PixelUI.Widget

## Properties

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` |  |
| parent | `PixelUI.Frame?` |  |
| x | `integer` |  |
| y | `integer` |  |
| width | `integer` |  |
| height | `integer` |  |
| bg | `PixelUI.Color` |  |
| fg | `PixelUI.Color` |  |
| _orderIndex | `integer?` |  |
| visible | `boolean` |  |
| z | `number` |  |
| border | `PixelUI.NormalizedBorderConfig?` |  |
| id | `string?` |  |
| focusable | `boolean` |  |
| draw | `fun(self:PixelUI.Widget,` |  |
| handleEvent | `fun(self:PixelUI.Widget,` |  |
| setFocused | `fun(self:PixelUI.Widget,` |  |
| isFocused | `fun(self:PixelUI.Widget):boolean` |  |

## Methods

### _init_base

```lua
_init_base()
```

### setSize

```lua
setSize()
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

