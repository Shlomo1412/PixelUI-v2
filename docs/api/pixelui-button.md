# PixelUI.Button

Extends: [`PixelUI.Widget`](./pixelui-widget.md)

## Fields

### label

- **Type:** `string`

### onPress

- **Type:** `fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?`

### onRelease

- **Type:** `fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?`

### onClick

- **Type:** `fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?`

### clickEffect

- **Type:** `boolean`

## Methods

### setLabel

*Since: 0.1.0*

**Parameters:**

- `text` (`string`)

### setOnClick

*Since: 0.1.0*

**Parameters:**

- `handler` (`fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?`)

### draw

*Since: 0.1.0*

**Parameters:**

- `textLayer` (`Layer`)
- `pixelLayer` (`Layer`)

### handleEvent

*Since: 0.1.0*

**Parameters:**

- `event` (`string`)

