# PixelUI.CheckBox

*Extends: PixelUI.Widget*

A checkbox widget with support for checked, unchecked, and indeterminate states. Provides visual feedback and change callbacks.

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Label text displayed next to the checkbox |
| checked | `boolean` | Whether the checkbox is checked |
| indeterminate | `boolean` | Whether the checkbox is in an indeterminate state |
| allowIndeterminate | `boolean` | Whether the indeterminate state is allowed |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| onChange | `fun(self:PixelUI.CheckBox,` |  |

## Methods

### new

```lua
new()
```

### _notifyChange

```lua
_notifyChange()
```

### _setState

```lua
_setState()
```

### setLabel

```lua
setLabel()
```

### setOnChange

```lua
setOnChange()
```

### setAllowIndeterminate

```lua
setAllowIndeterminate()
```

### setChecked

```lua
setChecked()
```

### isChecked

```lua
isChecked()
```

### setIndeterminate

```lua
setIndeterminate()
```

### isIndeterminate

```lua
isIndeterminate()
```

### toggle

```lua
toggle()
```

### _activate

```lua
_activate()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

