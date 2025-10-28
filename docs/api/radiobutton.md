# PixelUI.RadioButton

*Extends: PixelUI.Widget*

A radio button widget for exclusive selection within a group. Only one radio button in a group can be selected at a time.

## Properties

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Label text displayed next to the radio button |
| value | `any` | Value associated with this radio button |
| group | `string?` | Group identifier for exclusive selection |
| selected | `boolean` | Whether this radio button is selected |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| onChange | `fun(self:PixelUI.RadioButton,` |  |

## Methods

### new

```lua
new()
```

### _registerWithGroup

```lua
_registerWithGroup()
```

### _unregisterFromGroup

```lua
_unregisterFromGroup()
```

### _notifyChange

```lua
_notifyChange()
```

### _applySelection

```lua
_applySelection()
```

### setLabel

```lua
setLabel()
```

### setValue

```lua
setValue()
```

### getValue

```lua
getValue()
```

### setGroup

```lua
setGroup()
```

### getGroup

```lua
getGroup()
```

### setOnChange

```lua
setOnChange()
```

### setSelected

```lua
setSelected()
```

### isSelected

```lua
isSelected()
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

