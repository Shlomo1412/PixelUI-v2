# PixelUI.Frame

*Extends: PixelUI.Widget*

A container widget that can hold child widgets. Serves as the base for layout organization and hierarchy.

## Properties

| Name | Type | Description |
|------|------|-------------|
| private | `_children` |  |
| private | `_orderCounter` |  |
| title | `string?` | Optional frame title |

## Methods

### new

```lua
new()
```

### addChild

*Since: 0.1.0*

```lua
addChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

### removeChild

```lua
removeChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

### getChildren

*Since: 0.1.0*

```lua
getChildren()
```

**Returns:**

- `PixelUI.Widget[]`

### setTitle

*Since: 0.1.0*

```lua
setTitle(title)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| title | `string?` |  |

### draw

```lua
draw(textLayer, pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| textLayer | `Layer` |  |
| pixelLayer | `Layer` |  |

### handleEvent

*Since: 0.1.0*

```lua
handleEvent(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

