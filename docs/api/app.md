# PixelUI.App

Main application class managing the UI and event loop. Handles rendering, events, animations, and threading.

## Properties

| Name | Type | Description |
|------|------|-------------|
| window | `table` | The terminal window object |
| box | `ShrekBox` | ShrekBox rendering instance |
| layer | `Layer` | Text rendering layer |
| pixelLayer | `Layer` | Pixel rendering layer |
| background | `PixelUI.Color` | Root background color |
| root | `PixelUI.Frame` | Root frame container |
| running | `boolean` | Whether the application is running |
| _autoWindow | `boolean` | Whether window was auto-created |
| _parentTerminal | `table?` | Original terminal before window creation |
| _focusWidget | `PixelUI.Widget?` | Currently focused widget |
| _popupWidgets | `PixelUI.Widget[]` | Active popup widgets |
| _popupLookup | `table&lt;PixelUI.Widget,` |  |
| _animations | `table` | Active animations |
| _animationTimer | `integer?` | Animation timer ID |
| _animationInterval | `number` | Animation update interval |
| _radioGroups | `table&lt;string,` |  |

## Methods

### getRoot

*Since: 0.1.0*

```lua
getRoot()
```

**Returns:**

- `PixelUI.Frame`

### setBackground

*Since: 0.1.0*

```lua
setBackground(color)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color` |  |

### getLayer

*Since: 0.1.0*

```lua
getLayer()
```

**Returns:**

- `Layer`

### getPixelLayer

*Since: 0.1.0*

```lua
getPixelLayer()
```

**Returns:**

- `Layer`

### createFrame

*Since: 0.1.0*

```lua
createFrame(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Frame`

### createWindow

```lua
createWindow(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Window`

### createButton

*Since: 0.1.0*

```lua
createButton(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Button`

### createLabel

*Since: 0.1.0*

```lua
createLabel(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Label`

### createCheckBox

*Since: 0.1.0*

```lua
createCheckBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.CheckBox`

### createToggle

*Since: 0.1.0*

```lua
createToggle(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Toggle`

### createTextBox

*Since: 0.1.0*

```lua
createTextBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.TextBox`

### createComboBox

*Since: 0.1.0*

```lua
createComboBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.ComboBox`

### createTabControl

```lua
createTabControl(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.TabControl`

### createContextMenu

*Since: 0.1.0*

```lua
createContextMenu(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.ContextMenu`

### createList

*Since: 0.1.0*

```lua
createList(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.List`

### createTable

*Since: 0.1.0*

```lua
createTable(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Table`

### createTreeView

*Since: 0.1.0*

```lua
createTreeView(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.TreeView`

### createChart

*Since: 0.1.0*

```lua
createChart(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Chart`

### createRadioButton

*Since: 0.1.0*

```lua
createRadioButton(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.RadioButton`

### createProgressBar

*Since: 0.1.0*

```lua
createProgressBar(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.ProgressBar`

### createNotificationToast

```lua
createNotificationToast(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.NotificationToast`

### createLoadingRing

```lua
createLoadingRing(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.LoadingRing`

### createFreeDraw

```lua
createFreeDraw(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.FreeDraw`

### createSlider

*Since: 0.1.0*

```lua
createSlider(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Slider`

### _ensureAnimationTimer

```lua
_ensureAnimationTimer()
```

### _updateAnimations

```lua
_updateAnimations()
```

### _clearAnimations

```lua
_clearAnimations()
```

### animate

*Since: 0.1.0*

```lua
animate(options)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| options | `PixelUI.AnimationOptions` |  |

**Returns:**

- `PixelUI.AnimationHandle`

### _ensureThreadPump

```lua
_ensureThreadPump()
```

### _cleanupThread

```lua
_cleanupThread()
```

### _resumeThread

```lua
_resumeThread()
```

### _serviceThreads

```lua
_serviceThreads()
```

### _shutdownThreads

```lua
_shutdownThreads()
```

### spawnThread

```lua
spawnThread()
```

### getThreads

```lua
getThreads()
```

### _registerPopup

```lua
_registerPopup()
```

### _unregisterPopup

```lua
_unregisterPopup()
```

### _drawPopups

```lua
_drawPopups()
```

### _registerRadioButton

```lua
_registerRadioButton()
```

### _unregisterRadioButton

```lua
_unregisterRadioButton()
```

### _selectRadioInGroup

```lua
_selectRadioInGroup()
```

### setFocus

*Since: 0.1.0*

```lua
setFocus(widget)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| widget | `PixelUI.Widget?` |  |

### getFocus

*Since: 0.1.0*

```lua
getFocus()
```

**Returns:**

- `PixelUI.Widget?`

### render

*Since: 0.1.0*

```lua
render()
```

### step

*Since: 0.1.0*

```lua
step(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

### run

*Since: 0.1.0*

```lua
run()
```

### stop

*Since: 0.1.0*

```lua
stop()
```

