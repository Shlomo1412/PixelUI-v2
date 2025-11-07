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
| trackColorDisabled | `PixelUI.Color` | Track color when disabled |
| thumbColor | `PixelUI.Color` | Color of the sliding thumb |
| knobColorDisabled | `PixelUI.Color` | Thumb color when disabled |
| onLabelColor | `PixelUI.Color?` | Text color for "on" label |
| offLabelColor | `PixelUI.Color?` | Text color for "off" label |
| focusBg | `PixelUI.Color?` | Background color when focused |
| focusFg | `PixelUI.Color?` | Foreground color when focused |
| focusOutline | `PixelUI.Color?` | Outline color when focused |
| showLabel | `boolean` | Whether to show the label text |
| disabled | `boolean` | Whether the toggle is disabled |
| knobMargin | `integer` | Horizontal inner margin for the knob travel |
| knobWidth | `integer?` | Optional fixed knob width |
| transitionDuration | `number` | Seconds for knob transition animation |
| transitionEasing | `fun(t:number):number` | Easing function for knob transition |
| private | `_thumbProgress` |  |
| private | `_animationHandle` |  |
| onChange | `fun(self:PixelUI.Toggle,` |  |

## Methods

### new

```lua
new()
```

### _cancelAnimation

```lua
_cancelAnimation()
```

### _setThumbProgress

```lua
_setThumbProgress()
```

### _animateThumb

```lua
_animateThumb()
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

### setTransition

```lua
setTransition()
```

### setKnobStyle

```lua
setKnobStyle()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

