# PixelUI.Widget

## Fields

### app

- **Type:** `PixelUI.App`

### parent

- **Type:** `PixelUI.Frame?`

### x

- **Type:** `integer`

### y

- **Type:** `integer`

### width

- **Type:** `integer`

### height

- **Type:** `integer`

### bg

- **Type:** `PixelUI.Color`

### fg

- **Type:** `PixelUI.Color`

### _orderIndex

- **Type:** `integer?`

### visible

- **Type:** `boolean`

### z

- **Type:** `number`

### border

- **Type:** `PixelUI.NormalizedBorderConfig?`

### id

- **Type:** `string?`

### focusable

- **Type:** `boolean`

### draw

- **Type:** `fun(self:PixelUI.Widget, textLayer:Layer, pixelLayer:Layer)`

### handleEvent

- **Type:** `fun(self:PixelUI.Widget, event:string, ...:any):boolean`

### setFocused

- **Type:** `fun(self:PixelUI.Widget, focused:boolean)`

### isFocused

- **Type:** `fun(self:PixelUI.Widget):boolean`

## Methods

### setPosition

**Parameters:**

- `y` (`integer`)

### setZ

*Since: 0.1.0*

**Parameters:**

- `z` (`number`)

### setBorder

*Since: 0.1.0*

**Parameters:**

- `borderConfig` (`PixelUI.BorderConfig|boolean|nil`)

### isFocused

*Since: 0.1.0*

**Returns:**

- `boolean`

### setFocused

*Since: 0.1.0*

**Parameters:**

- `focused` (`boolean`)

### onFocusChanged

*Since: 0.1.0*

**Parameters:**

- `_focused` (`boolean`)

### getAbsoluteRect

*Since: 0.1.0*

**Returns:**

- `integer` x
- `integer` y
- `integer` width
- `integer` height

### containsPoint

*Since: 0.1.0*

**Parameters:**

- `px` (`integer`)
- `py` (`integer`)

**Returns:**

- `boolean`

### draw

*Since: 0.1.0*

**Parameters:**

- `_textLayer` (`Layer`)
- `_pixelLayer` (`Layer`)

### handleEvent

*Since: 0.1.0*

**Parameters:**

- `_event` (`string`)

**Returns:**

- `boolean` consumed

