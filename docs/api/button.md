# PixelUI.Button

*Extends: PixelUI.Widget*

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| onPress | `fun(self:PixelUI.Button,` |  |
| onRelease | `fun(self:PixelUI.Button,` |  |
| onClick | `fun(self:PixelUI.Button,` |  |
| clickEffect | `boolean` |  |
| private | `_pressed` |  |

## Methods

### new

```lua
new()
```

### setLabel

*Since: 0.1.0*

```lua
setLabel(text)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| text | `string` |  |

### setOnClick

*Since: 0.1.0*

```lua
setOnClick(handler)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| handler | `fun(self:PixelUI.Button,` | button:integer, x:integer, y:integer)? |

### draw

*Since: 0.1.0*

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

