# PixelUI.Toggle

*Extends: PixelUI.Widget*

A toggle switch widget with on/off states and customizable appearance. Features a sliding thumb animation and optional labels.

## Properties

| Name | Type | Description |
|------|------|-------------|
| value | `boolean` | Current toggle state (true = on, false = off) |
| labelOn | `string` | Label text when toggle is on |
| labelOff | `string` | Label text when toggle is off |
| trackColorOn | `PixelUI.Color` | Track color when on |
| trackColorOff | `PixelUI.Color` | Track color when off |
| thumbColor | `PixelUI.Color` | Color of the sliding thumb |
| onLabelColor | `PixelUI.Color?` | Text color for "on" label |
| offLabelColor | `PixelUI.Color?` | Text color for "off" label |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| showLabel | `boolean` | Whether to show the label text |
| disabled | `boolean` | Whether the toggle is disabled |
| onChange | `fun(self:PixelUI.Toggle,` |  |

## Methods

### new

```lua
new()
```

### _emitChange

```lua
_emitChange()
```

### setOnChange

```lua
setOnChange()
```

### setValue

```lua
setValue()
```

### isOn

```lua
isOn()
```

### toggle

```lua
toggle()
```

### setLabels

```lua
setLabels()
```

### setShowLabel

```lua
setShowLabel()
```

### setDisabled

```lua
setDisabled()
```

### isDisabled

```lua
isDisabled()
```

### setColors

```lua
setColors()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

