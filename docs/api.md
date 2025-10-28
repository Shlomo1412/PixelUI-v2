# API Reference

## Classes

### Core

#### PixelUI.Widget

**Fields:**

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

#### PixelUI.App

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| window | `table` |  |
| box | `ShrekBox` |  |
| layer | `Layer` |  |
| pixelLayer | `Layer` |  |
| background | `PixelUI.Color` |  |
| root | `PixelUI.Frame` |  |
| running | `boolean` |  |
| _autoWindow | `boolean` |  |
| _parentTerminal | `table?` |  |
| _focusWidget | `PixelUI.Widget?` |  |
| _popupWidgets | `PixelUI.Widget[]` |  |
| _popupLookup | `table&lt;PixelUI.Widget,` |  |
| _animations | `table` |  |
| _animationTimer | `integer?` |  |
| _animationInterval | `number` |  |
| _radioGroups | `table&lt;string,` |  |

#### PixelUI.Frame

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| private | `_children` |  |
| private | `_orderCounter` |  |
| title | `string?` |  |

### Widgets

#### PixelUI.Button

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| onPress | `fun(self:PixelUI.Button,` |  |
| onRelease | `fun(self:PixelUI.Button,` |  |
| onClick | `fun(self:PixelUI.Button,` |  |
| clickEffect | `boolean` |  |
| private | `_pressed` |  |

#### PixelUI.Label

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| text | `string` |  |
| wrap | `boolean` |  |
| align | `"left"\|"center"\|"right"` |  |
| verticalAlign | `"top"\|"middle"\|"bottom"` |  |

#### PixelUI.CheckBox

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| checked | `boolean` |  |
| indeterminate | `boolean` |  |
| allowIndeterminate | `boolean` |  |
| focusBg | `PixelUI.Color?` |  |
| focusFg | `PixelUI.Color?` |  |
| onChange | `fun(self:PixelUI.CheckBox,` |  |

#### PixelUI.Toggle

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| value | `boolean` |  |
| labelOn | `string` |  |
| labelOff | `string` |  |
| trackColorOn | `PixelUI.Color` |  |
| trackColorOff | `PixelUI.Color` |  |
| thumbColor | `PixelUI.Color` |  |
| onLabelColor | `PixelUI.Color?` |  |
| offLabelColor | `PixelUI.Color?` |  |
| focusBg | `PixelUI.Color?` |  |
| focusFg | `PixelUI.Color?` |  |
| showLabel | `boolean` |  |
| disabled | `boolean` |  |
| onChange | `fun(self:PixelUI.Toggle,` |  |

#### PixelUI.Chart

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| data | `number[]` |  |
| labels | `string[]` |  |
| chartType | `"bar"\|"line"` |  |
| minValue | `number?` |  |
| maxValue | `number?` |  |
| showAxis | `boolean` |  |
| showLabels | `boolean` |  |
| placeholder | `string?` |  |
| barColor | `PixelUI.Color` |  |
| highlightColor | `PixelUI.Color` |  |
| axisColor | `PixelUI.Color` |  |
| lineColor | `PixelUI.Color` |  |
| rangePadding | `number` |  |
| selectedIndex | `integer?` |  |
| onSelect | `fun(self:PixelUI.Chart,` |  |

#### PixelUI.ProgressBar

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| value | `number` |  |
| min | `number` |  |
| max | `number` |  |
| indeterminate | `boolean` |  |
| label | `string?` |  |
| showPercent | `boolean` |  |
| trackColor | `PixelUI.Color` |  |
| fillColor | `PixelUI.Color` |  |
| textColor | `PixelUI.Color` |  |

#### PixelUI.NotificationToast

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| title | `string?` |  |
| message | `string` |  |
| severity | `string` |  |
| autoHide | `boolean` |  |
| duration | `number` |  |
| dismissOnClick | `boolean` |  |

#### PixelUI.LoadingRing

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| segmentCount | `integer` |  |
| thickness | `integer` |  |
| color | `PixelUI.Color` |  |
| secondaryColor | `PixelUI.Color?` |  |
| trailColor | `PixelUI.Color?` |  |
| tertiaryColor | `PixelUI.Color?` |  |
| speed | `number` |  |
| direction | `integer` |  |
| radiusPixels | `integer?` |  |
| trailPalette | `PixelUI.Color[]?` |  |
| fadeSteps | `integer` |  |
| autoStart | `boolean?` |  |

#### PixelUI.Slider

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| min | `number` |  |
| max | `number` |  |
| value | `number` |  |
| range | `boolean` |  |
| lowerValue | `number?` |  |
| upperValue | `number?` |  |
| step | `number` |  |
| showValue | `boolean` |  |
| onChange | `fun(self:PixelUI.Slider,` |  |
| formatValue | `fun(self:PixelUI.Slider,` |  |

#### PixelUI.TreeNode

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| data | `any` |  |
| children | `PixelUI.TreeNode[]` |  |
| expanded | `boolean` |  |

#### PixelUI.TreeView

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| indentWidth | `integer` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string?` |  |
| onSelect | `fun(self:PixelUI.TreeView,` |  |
| onToggle | `fun(self:PixelUI.TreeView,` |  |

#### PixelUI.List

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` |  |
| selectedIndex | `integer` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string?` |  |
| onSelect | `fun(self:PixelUI.List,` |  |

#### PixelUI.RadioButton

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| value | `any` |  |
| group | `string?` |  |
| selected | `boolean` |  |
| focusBg | `PixelUI.Color?` |  |
| focusFg | `PixelUI.Color?` |  |
| onChange | `fun(self:PixelUI.RadioButton,` |  |

#### PixelUI.ComboBox

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| items | `string[]` |  |
| selectedIndex | `integer` |  |
| dropdownBg | `PixelUI.Color` |  |
| dropdownFg | `PixelUI.Color` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string?` |  |
| onChange | `fun(self:PixelUI.ComboBox,` |  |

#### PixelUI.TextBox

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| text | `string` |  |
| placeholder | `string` |  |
| onChange | `fun(self:PixelUI.TextBox,` |  |
| maxLength | `integer?` |  |
| multiline | `boolean` |  |
| autocomplete | `string[]?` |  |
| syntax | `table?` |  |

#### PixelUI.TableColumn

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| id | `string` |  |
| title | `string` |  |
| key | `string?` |  |
| accessor | `fun(row:any):any` |  |
| width | `integer?` |  |
| align | `"left"\|"center"\|"right"?` |  |
| sortable | `boolean?` |  |
| format | `fun(value:any,` |  |
| comparator | `fun(a:any,` |  |

#### PixelUI.Table

*Extends: PixelUI.Widget*

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| columns | `PixelUI.TableColumn[]` |  |
| data | `table[]` |  |
| sortColumn | `string?` |  |
| sortDirection | `"asc"\|"desc"` |  |
| allowRowSelection | `boolean` |  |
| highlightBg | `PixelUI.Color` |  |
| highlightFg | `PixelUI.Color` |  |
| placeholder | `string` |  |
| onSelect | `fun(self:PixelUI.Table,` |  |
| onSort | `fun(self:PixelUI.Table,` |  |

### Configuration

#### PixelUI.BorderConfig

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color?` | Border color |
| sides | `("top"\|"right"\|"bottom"\|"left")[]\|table&lt;string,boolean&gt;?` | Enabled sides |
| thickness | `integer?` | Pixel thickness of the border (defaults to 1) |

#### PixelUI.AppOptions

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| window | `table?` | Target window; defaults to the current terminal |
| background | `PixelUI.Color?` | Root background color |
| rootBorder | `PixelUI.BorderConfig?` | Border applied to the root frame |
| animationInterval | `number?` | Animation tick interval in seconds (defaults to 0.05) |

#### PixelUI.NormalizedBorderConfig

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color` |  |
| top | `boolean` |  |
| right | `boolean` |  |
| bottom | `boolean` |  |
| left | `boolean` |  |
| thickness | `integer` |  |

#### PixelUI.ThreadOptions

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| name | `string?` |  |
| onStatus | `fun(handle:PixelUI.ThreadHandle,` |  |
| onMetadata | `fun(handle:PixelUI.ThreadHandle,` |  |

#### PixelUI.AnimationOptions

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| duration | `number?` |  |
| easing | `(fun(t:number):number)\|string?` |  |
| update | `fun(progress:number,` |  |
| onComplete | `fun(handle:PixelUI.AnimationHandle?)?` |  |
| onCancel | `fun(handle:PixelUI.AnimationHandle?)?` |  |

### Types

#### PixelUI.ThreadHandle

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` |  |
| getId | `fun(self:PixelUI.ThreadHandle):integer` |  |
| getName | `fun(self:PixelUI.ThreadHandle):string` |  |
| setName | `fun(self:PixelUI.ThreadHandle,` |  |
| getStatus | `fun(self:PixelUI.ThreadHandle):PixelUI.ThreadStatus` |  |
| isRunning | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| isFinished | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| cancel | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| isCancelled | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| getResult | `fun(self:PixelUI.ThreadHandle):...` |  |
| getResults | `fun(self:PixelUI.ThreadHandle):any[]?` |  |
| getError | `fun(self:PixelUI.ThreadHandle):any` |  |
| setMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getAllMetadata | `fun(self:PixelUI.ThreadHandle):table&lt;string,` |  |
| onStatusChange | `fun(self:PixelUI.ThreadHandle,` |  |
| onMetadataChange | `fun(self:PixelUI.ThreadHandle,` |  |

#### PixelUI.ThreadContext

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| sleep | `fun(self:PixelUI.ThreadContext,` |  |
| yield | `fun(self:PixelUI.ThreadContext)` |  |
| checkCancelled | `fun(self:PixelUI.ThreadContext)` |  |
| isCancelled | `fun(self:PixelUI.ThreadContext):boolean` |  |
| setMetadata | `fun(self:PixelUI.ThreadContext,` |  |
| setStatus | `fun(self:PixelUI.ThreadContext,` |  |
| setDetail | `fun(self:PixelUI.ThreadContext,` |  |
| setProgress | `fun(self:PixelUI.ThreadContext,` |  |
| getHandle | `fun(self:PixelUI.ThreadContext):PixelUI.ThreadHandle` |  |

#### PixelUI.AnimationHandle

**Fields:**

| Name | Type | Description |
|------|------|-------------|
| cancel | `fun(self:PixelUI.AnimationHandle)` |  |

## Functions

### NotificationToast

#### new

```lua
NotificationToast:new()
```

#### _applyPadding

```lua
NotificationToast:_applyPadding()
```

#### setPadding

```lua
NotificationToast:setPadding()
```

#### getAnchor

```lua
NotificationToast:getAnchor()
```

#### getAnchorMargins

```lua
NotificationToast:getAnchorMargins()
```

#### refreshAnchor

```lua
NotificationToast:refreshAnchor()
```

#### setAnchor

```lua
NotificationToast:setAnchor()
```

#### setAnchorMargin

```lua
NotificationToast:setAnchorMargin()
```

#### _computeAnchorPosition

```lua
NotificationToast:_computeAnchorPosition()
```

#### getAnchorTargetPosition

```lua
NotificationToast:getAnchorTargetPosition()
```

#### _applyAnchorPosition

```lua
NotificationToast:_applyAnchorPosition()
```

#### _getActiveBorder

```lua
NotificationToast:_getActiveBorder()
```

#### _refreshWrap

```lua
NotificationToast:_refreshWrap()
```

#### _getStyle

```lua
NotificationToast:_getStyle()
```

#### _cancelTimer

```lua
NotificationToast:_cancelTimer()
```

#### _scheduleHide

```lua
NotificationToast:_scheduleHide()
```

#### setTitle

```lua
NotificationToast:setTitle()
```

#### getTitle

```lua
NotificationToast:getTitle()
```

#### setMessage

```lua
NotificationToast:setMessage()
```

#### getMessage

```lua
NotificationToast:getMessage()
```

#### setSeverity

```lua
NotificationToast:setSeverity()
```

#### getSeverity

```lua
NotificationToast:getSeverity()
```

#### setIcon

```lua
NotificationToast:setIcon()
```

#### getIcon

```lua
NotificationToast:getIcon()
```

#### setAutoHide

```lua
NotificationToast:setAutoHide()
```

#### isAutoHide

```lua
NotificationToast:isAutoHide()
```

#### setDuration

```lua
NotificationToast:setDuration()
```

#### getDuration

```lua
NotificationToast:getDuration()
```

#### setDismissOnClick

```lua
NotificationToast:setDismissOnClick()
```

#### isDismissOnClick

```lua
NotificationToast:isDismissOnClick()
```

#### setOnDismiss

```lua
NotificationToast:setOnDismiss()
```

#### setVariants

```lua
NotificationToast:setVariants()
```

#### setStyle

```lua
NotificationToast:setStyle()
```

#### present

```lua
NotificationToast:present()
```

#### show

```lua
NotificationToast:show()
```

#### hide

```lua
NotificationToast:hide()
```

#### setSize

```lua
NotificationToast:setSize()
```

#### setBorder

```lua
NotificationToast:setBorder()
```

#### _renderLine

```lua
NotificationToast:_renderLine()
```

#### draw

```lua
NotificationToast:draw()
```

#### handleEvent

```lua
NotificationToast:handleEvent()
```

#### onFocusChanged

```lua
NotificationToast:onFocusChanged()
```

### Widget

#### _init_base

```lua
Widget:_init_base()
```

#### setSize

```lua
Widget:setSize()
```

#### setPosition

```lua
Widget:setPosition(y)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| y | `integer` |  |

#### setZ

*Since: 0.1.0*

```lua
Widget:setZ(z)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| z | `number` |  |

#### setBorder

*Since: 0.1.0*

```lua
Widget:setBorder(borderConfig)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| borderConfig | `PixelUI.BorderConfig\|boolean\|nil` |  |

#### isFocused

*Since: 0.1.0*

```lua
Widget:isFocused()
```

**Returns:**

- `boolean`

#### setFocused

*Since: 0.1.0*

```lua
Widget:setFocused(focused)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| focused | `boolean` |  |

#### onFocusChanged

*Since: 0.1.0*

```lua
Widget:onFocusChanged(_focused)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _focused | `boolean` |  |

#### getAbsoluteRect

*Since: 0.1.0*

```lua
Widget:getAbsoluteRect()
```

**Returns:**

- `integer` - x
- `integer` - y
- `integer` - width
- `integer` - height

#### containsPoint

```lua
Widget:containsPoint(px, py)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| px | `integer` |  |
| py | `integer` |  |

**Returns:**

- `boolean`

#### draw

*Since: 0.1.0*

```lua
Widget:draw(_textLayer, _pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _textLayer | `Layer` |  |
| _pixelLayer | `Layer` |  |

#### handleEvent

*Since: 0.1.0*

```lua
Widget:handleEvent(_event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| _event | `string` |  |

**Returns:**

- `boolean` - consumed

### Frame

#### new

```lua
Frame:new()
```

#### addChild

*Since: 0.1.0*

```lua
Frame:addChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

#### removeChild

```lua
Frame:removeChild(child)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| child | `PixelUI.Widget` |  |

#### getChildren

*Since: 0.1.0*

```lua
Frame:getChildren()
```

**Returns:**

- `PixelUI.Widget[]`

#### setTitle

*Since: 0.1.0*

```lua
Frame:setTitle(title)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| title | `string?` |  |

#### draw

```lua
Frame:draw(textLayer, pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| textLayer | `Layer` |  |
| pixelLayer | `Layer` |  |

#### handleEvent

*Since: 0.1.0*

```lua
Frame:handleEvent(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

### Button

#### new

```lua
Button:new()
```

#### setLabel

*Since: 0.1.0*

```lua
Button:setLabel(text)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| text | `string` |  |

#### setOnClick

*Since: 0.1.0*

```lua
Button:setOnClick(handler)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| handler | `fun(self:PixelUI.Button,` | button:integer, x:integer, y:integer)? |

#### draw

*Since: 0.1.0*

```lua
Button:draw(textLayer, pixelLayer)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| textLayer | `Layer` |  |
| pixelLayer | `Layer` |  |

#### handleEvent

*Since: 0.1.0*

```lua
Button:handleEvent(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

### Label

#### new

```lua
Label:new()
```

#### _getInnerMetrics

```lua
Label:_getInnerMetrics()
```

#### _wrapLine

```lua
Label:_wrapLine()
```

#### _updateLines

```lua
Label:_updateLines()
```

#### setText

```lua
Label:setText()
```

#### getText

```lua
Label:getText()
```

#### setWrap

```lua
Label:setWrap()
```

#### isWrapping

```lua
Label:isWrapping()
```

#### setHorizontalAlign

```lua
Label:setHorizontalAlign()
```

#### setVerticalAlign

```lua
Label:setVerticalAlign()
```

#### setSize

```lua
Label:setSize()
```

#### setBorder

```lua
Label:setBorder()
```

#### draw

```lua
Label:draw()
```

### CheckBox

#### new

```lua
CheckBox:new()
```

#### _notifyChange

```lua
CheckBox:_notifyChange()
```

#### _setState

```lua
CheckBox:_setState()
```

#### setLabel

```lua
CheckBox:setLabel()
```

#### setOnChange

```lua
CheckBox:setOnChange()
```

#### setAllowIndeterminate

```lua
CheckBox:setAllowIndeterminate()
```

#### setChecked

```lua
CheckBox:setChecked()
```

#### isChecked

```lua
CheckBox:isChecked()
```

#### setIndeterminate

```lua
CheckBox:setIndeterminate()
```

#### isIndeterminate

```lua
CheckBox:isIndeterminate()
```

#### toggle

```lua
CheckBox:toggle()
```

#### _activate

```lua
CheckBox:_activate()
```

#### draw

```lua
CheckBox:draw()
```

#### handleEvent

```lua
CheckBox:handleEvent()
```

### Toggle

#### new

```lua
Toggle:new()
```

#### _emitChange

```lua
Toggle:_emitChange()
```

#### setOnChange

```lua
Toggle:setOnChange()
```

#### setValue

```lua
Toggle:setValue()
```

#### isOn

```lua
Toggle:isOn()
```

#### toggle

```lua
Toggle:toggle()
```

#### setLabels

```lua
Toggle:setLabels()
```

#### setShowLabel

```lua
Toggle:setShowLabel()
```

#### setDisabled

```lua
Toggle:setDisabled()
```

#### isDisabled

```lua
Toggle:isDisabled()
```

#### setColors

```lua
Toggle:setColors()
```

#### draw

```lua
Toggle:draw()
```

#### handleEvent

```lua
Toggle:handleEvent()
```

### RadioButton

#### new

```lua
RadioButton:new()
```

#### _registerWithGroup

```lua
RadioButton:_registerWithGroup()
```

#### _unregisterFromGroup

```lua
RadioButton:_unregisterFromGroup()
```

#### _notifyChange

```lua
RadioButton:_notifyChange()
```

#### _applySelection

```lua
RadioButton:_applySelection()
```

#### setLabel

```lua
RadioButton:setLabel()
```

#### setValue

```lua
RadioButton:setValue()
```

#### getValue

```lua
RadioButton:getValue()
```

#### setGroup

```lua
RadioButton:setGroup()
```

#### getGroup

```lua
RadioButton:getGroup()
```

#### setOnChange

```lua
RadioButton:setOnChange()
```

#### setSelected

```lua
RadioButton:setSelected()
```

#### isSelected

```lua
RadioButton:isSelected()
```

#### _activate

```lua
RadioButton:_activate()
```

#### draw

```lua
RadioButton:draw()
```

#### handleEvent

```lua
RadioButton:handleEvent()
```

### ProgressBar

#### new

```lua
ProgressBar:new()
```

#### _clampValue

```lua
ProgressBar:_clampValue()
```

#### _stopIndeterminateAnimation

```lua
ProgressBar:_stopIndeterminateAnimation()
```

#### _startIndeterminateAnimation

```lua
ProgressBar:_startIndeterminateAnimation()
```

#### setRange

```lua
ProgressBar:setRange()
```

#### getRange

```lua
ProgressBar:getRange()
```

#### setValue

```lua
ProgressBar:setValue()
```

#### getValue

```lua
ProgressBar:getValue()
```

#### getPercent

```lua
ProgressBar:getPercent()
```

#### setIndeterminate

```lua
ProgressBar:setIndeterminate()
```

#### isIndeterminate

```lua
ProgressBar:isIndeterminate()
```

#### setLabel

```lua
ProgressBar:setLabel()
```

#### setShowPercent

```lua
ProgressBar:setShowPercent()
```

#### setColors

```lua
ProgressBar:setColors()
```

#### draw

```lua
ProgressBar:draw()
```

#### handleEvent

```lua
ProgressBar:handleEvent()
```

### Slider

#### new

```lua
Slider:new()
```

#### _clampValue

```lua
Slider:_clampValue()
```

#### _applyStep

```lua
Slider:_applyStep()
```

#### _getInnerMetrics

```lua
Slider:_getInnerMetrics()
```

#### _valueToPosition

```lua
Slider:_valueToPosition()
```

#### _positionToValue

```lua
Slider:_positionToValue()
```

#### _notifyChange

```lua
Slider:_notifyChange()
```

#### setOnChange

```lua
Slider:setOnChange()
```

#### _setSingleValue

```lua
Slider:_setSingleValue()
```

#### setValue

```lua
Slider:setValue()
```

#### getValue

```lua
Slider:getValue()
```

#### _setLowerValue

```lua
Slider:_setLowerValue()
```

#### _setUpperValue

```lua
Slider:_setUpperValue()
```

#### setRangeValues

```lua
Slider:setRangeValues()
```

#### getRangeValues

```lua
Slider:getRangeValues()
```

#### setRangeLimits

```lua
Slider:setRangeLimits()
```

#### setStep

```lua
Slider:setStep()
```

#### setShowValue

```lua
Slider:setShowValue()
```

#### setColors

```lua
Slider:setColors()
```

#### _formatNumber

```lua
Slider:_formatNumber()
```

#### _formatDisplayValue

```lua
Slider:_formatDisplayValue()
```

#### _getStepForNudge

```lua
Slider:_getStepForNudge()
```

#### _positionFromPoint

```lua
Slider:_positionFromPoint()
```

#### _beginInteraction

```lua
Slider:_beginInteraction()
```

#### _updateInteraction

```lua
Slider:_updateInteraction()
```

#### _endInteraction

```lua
Slider:_endInteraction()
```

#### _switchFocusedHandle

```lua
Slider:_switchFocusedHandle()
```

#### _nudgeValue

```lua
Slider:_nudgeValue()
```

#### onFocusChanged

```lua
Slider:onFocusChanged()
```

#### draw

```lua
Slider:draw()
```

#### handleEvent

```lua
Slider:handleEvent()
```

### Table

#### new

```lua
Table:new()
```

#### _normalizeColumns

```lua
Table:_normalizeColumns()
```

#### _recomputeColumnMetrics

```lua
Table:_recomputeColumnMetrics()
```

#### _ensureColumnsForData

```lua
Table:_ensureColumnsForData()
```

#### setColumns

```lua
Table:setColumns()
```

#### getColumns

```lua
Table:getColumns()
```

#### setData

```lua
Table:setData()
```

#### getData

```lua
Table:getData()
```

#### _refreshRows

```lua
Table:_refreshRows()
```

#### _getColumnById

```lua
Table:_getColumnById()
```

#### _applySort

```lua
Table:_applySort()
```

#### setSort

```lua
Table:setSort()
```

#### getSort

```lua
Table:getSort()
```

#### setOnSort

```lua
Table:setOnSort()
```

#### setOnSelect

```lua
Table:setOnSelect()
```

#### getSelectedIndex

```lua
Table:getSelectedIndex()
```

#### getSelectedRow

```lua
Table:getSelectedRow()
```

#### setSelectedIndex

```lua
Table:setSelectedIndex()
```

#### _notifySelect

```lua
Table:_notifySelect()
```

#### _getInnerMetrics

```lua
Table:_getInnerMetrics()
```

#### _getRowsVisible

```lua
Table:_getRowsVisible()
```

#### _clampScroll

```lua
Table:_clampScroll()
```

#### _ensureSelectionVisible

```lua
Table:_ensureSelectionVisible()
```

#### _rowFromPoint

```lua
Table:_rowFromPoint()
```

#### _columnFromPoint

```lua
Table:_columnFromPoint()
```

#### _formatCell

```lua
Table:_formatCell()
```

#### draw

```lua
Table:draw()
```

#### _handleTypeSearch

```lua
Table:_handleTypeSearch()
```

#### _searchForPrefix

```lua
Table:_searchForPrefix()
```

#### onFocusChanged

```lua
Table:onFocusChanged()
```

#### handleEvent

```lua
Table:handleEvent()
```

### TreeView

#### new

```lua
TreeView:new()
```

#### setOnSelect

```lua
TreeView:setOnSelect()
```

#### setOnToggle

```lua
TreeView:setOnToggle()
```

#### _copyNodes

```lua
TreeView:_copyNodes()
```

#### setNodes

```lua
TreeView:setNodes()
```

#### getSelectedNode

```lua
TreeView:getSelectedNode()
```

#### setSelectedNode

```lua
TreeView:setSelectedNode()
```

#### expandNode

```lua
TreeView:expandNode()
```

#### collapseNode

```lua
TreeView:collapseNode()
```

#### toggleNode

```lua
TreeView:toggleNode()
```

#### _rebuildFlatNodes

```lua
TreeView:_rebuildFlatNodes()
```

#### _findVisibleIndex

```lua
TreeView:_findVisibleIndex()
```

#### _getInnerMetrics

```lua
TreeView:_getInnerMetrics()
```

#### _getInnerHeight

```lua
TreeView:_getInnerHeight()
```

#### _ensureSelectionVisible

```lua
TreeView:_ensureSelectionVisible()
```

#### _setSelectedIndex

```lua
TreeView:_setSelectedIndex()
```

#### _selectNode

```lua
TreeView:_selectNode()
```

#### _moveSelection

```lua
TreeView:_moveSelection()
```

#### _scrollBy

```lua
TreeView:_scrollBy()
```

#### _rowFromPoint

```lua
TreeView:_rowFromPoint()
```

#### _toggleNode

```lua
TreeView:_toggleNode()
```

#### _notifySelect

```lua
TreeView:_notifySelect()
```

#### onFocusChanged

```lua
TreeView:onFocusChanged()
```

#### _searchForPrefix

```lua
TreeView:_searchForPrefix()
```

#### _handleTypeSearch

```lua
TreeView:_handleTypeSearch()
```

#### draw

```lua
TreeView:draw()
```

#### handleEvent

```lua
TreeView:handleEvent()
```

### Chart

#### new

```lua
Chart:new()
```

#### _emitSelect

```lua
Chart:_emitSelect()
```

#### _clampSelection

```lua
Chart:_clampSelection()
```

#### setData

```lua
Chart:setData()
```

#### getData

```lua
Chart:getData()
```

#### setLabels

```lua
Chart:setLabels()
```

#### getLabels

```lua
Chart:getLabels()
```

#### getLabel

```lua
Chart:getLabel()
```

#### setChartType

```lua
Chart:setChartType()
```

#### setShowAxis

```lua
Chart:setShowAxis()
```

#### setShowLabels

```lua
Chart:setShowLabels()
```

#### setPlaceholder

```lua
Chart:setPlaceholder()
```

#### setRange

```lua
Chart:setRange()
```

#### setRangePadding

```lua
Chart:setRangePadding()
```

#### setOnSelect

```lua
Chart:setOnSelect()
```

#### setSelectedIndex

```lua
Chart:setSelectedIndex()
```

#### getSelectedIndex

```lua
Chart:getSelectedIndex()
```

#### getSelectedValue

```lua
Chart:getSelectedValue()
```

#### onFocusChanged

```lua
Chart:onFocusChanged()
```

#### _indexFromPoint

```lua
Chart:_indexFromPoint()
```

#### _moveSelection

```lua
Chart:_moveSelection()
```

#### draw

```lua
Chart:draw()
```

#### handleEvent

```lua
Chart:handleEvent()
```

### List

#### new

```lua
List:new()
```

#### _getInnerMetrics

```lua
List:_getInnerMetrics()
```

#### _getInnerHeight

```lua
List:_getInnerHeight()
```

#### _clampScroll

```lua
List:_clampScroll()
```

#### _ensureSelectionVisible

```lua
List:_ensureSelectionVisible()
```

#### _normalizeSelection

```lua
List:_normalizeSelection()
```

#### getItems

```lua
List:getItems()
```

#### setItems

```lua
List:setItems()
```

#### getSelectedItem

```lua
List:getSelectedItem()
```

#### setSelectedIndex

```lua
List:setSelectedIndex()
```

#### getSelectedIndex

```lua
List:getSelectedIndex()
```

#### setOnSelect

```lua
List:setOnSelect()
```

#### setPlaceholder

```lua
List:setPlaceholder()
```

#### setHighlightColors

```lua
List:setHighlightColors()
```

#### _notifySelect

```lua
List:_notifySelect()
```

#### onFocusChanged

```lua
List:onFocusChanged()
```

#### _itemIndexFromPoint

```lua
List:_itemIndexFromPoint()
```

#### _moveSelection

```lua
List:_moveSelection()
```

#### _scrollBy

```lua
List:_scrollBy()
```

#### _handleTypeSearch

```lua
List:_handleTypeSearch()
```

#### _searchForPrefix

```lua
List:_searchForPrefix()
```

#### draw

```lua
List:draw()
```

#### handleEvent

```lua
List:handleEvent()
```

### ComboBox

#### new

```lua
ComboBox:new()
```

#### _normalizeSelection

```lua
ComboBox:_normalizeSelection()
```

#### setItems

```lua
ComboBox:setItems()
```

#### getSelectedItem

```lua
ComboBox:getSelectedItem()
```

#### setSelectedIndex

```lua
ComboBox:setSelectedIndex()
```

#### setOnChange

```lua
ComboBox:setOnChange()
```

#### _notifyChange

```lua
ComboBox:_notifyChange()
```

#### _setOpen

```lua
ComboBox:_setOpen()
```

#### onFocusChanged

```lua
ComboBox:onFocusChanged()
```

#### _isPointInDropdown

```lua
ComboBox:_isPointInDropdown()
```

#### _indexFromPoint

```lua
ComboBox:_indexFromPoint()
```

#### _handlePress

```lua
ComboBox:_handlePress()
```

#### draw

```lua
ComboBox:draw()
```

#### _drawDropdown

```lua
ComboBox:_drawDropdown()
```

#### handleEvent

```lua
ComboBox:handleEvent()
```

### TextBox

#### new

```lua
TextBox:new()
```

#### setOnCursorMove

```lua
TextBox:setOnCursorMove()
```

#### onFocusChanged

```lua
TextBox:onFocusChanged()
```

#### _applyMaxLength

```lua
TextBox:_applyMaxLength()
```

#### _syncTextFromLines

```lua
TextBox:_syncTextFromLines()
```

#### _setTextInternal

```lua
TextBox:_setTextInternal()
```

#### _indexToPosition

```lua
TextBox:_indexToPosition()
```

#### _moveCursorToIndex

```lua
TextBox:_moveCursorToIndex()
```

#### getCursorPosition

```lua
TextBox:getCursorPosition()
```

#### getLineCount

```lua
TextBox:getLineCount()
```

#### _getInnerMetrics

```lua
TextBox:_getInnerMetrics()
```

#### _getOverlayHeight

```lua
TextBox:_getOverlayHeight()
```

#### _getContentSize

```lua
TextBox:_getContentSize()
```

#### _ensureCursorVisible

```lua
TextBox:_ensureCursorVisible()
```

#### _notifyChange

```lua
TextBox:_notifyChange()
```

#### _notifyCursorChange

```lua
TextBox:_notifyCursorChange()
```

#### _hasSelection

```lua
TextBox:_hasSelection()
```

#### getSelectionLength

```lua
TextBox:getSelectionLength()
```

#### getSelectionText

```lua
TextBox:getSelectionText()
```

#### _getSelectionRange

```lua
TextBox:_getSelectionRange()
```

#### _collectRange

```lua
TextBox:_collectRange()
```

#### _clearSelection

```lua
TextBox:_clearSelection()
```

#### _removeRange

```lua
TextBox:_removeRange()
```

#### _insertAt

```lua
TextBox:_insertAt()
```

#### _deleteSelection

```lua
TextBox:_deleteSelection()
```

#### _replaceSelection

```lua
TextBox:_replaceSelection()
```

#### _insertTextAtCursor

```lua
TextBox:_insertTextAtCursor()
```

#### _insertCharacter

```lua
TextBox:_insertCharacter()
```

#### _insertNewline

```lua
TextBox:_insertNewline()
```

#### _insertTab

```lua
TextBox:_insertTab()
```

#### _deleteBackward

```lua
TextBox:_deleteBackward()
```

#### _deleteForward

```lua
TextBox:_deleteForward()
```

#### _setCursorPosition

```lua
TextBox:_setCursorPosition()
```

#### _moveCursorLeft

```lua
TextBox:_moveCursorLeft()
```

#### _moveCursorRight

```lua
TextBox:_moveCursorRight()
```

#### _moveCursorVertical

```lua
TextBox:_moveCursorVertical()
```

#### _moveCursorUp

```lua
TextBox:_moveCursorUp()
```

#### _moveCursorDown

```lua
TextBox:_moveCursorDown()
```

#### _moveCursorLineStart

```lua
TextBox:_moveCursorLineStart()
```

#### _moveCursorLineEnd

```lua
TextBox:_moveCursorLineEnd()
```

#### _moveCursorDocumentStart

```lua
TextBox:_moveCursorDocumentStart()
```

#### _moveCursorDocumentEnd

```lua
TextBox:_moveCursorDocumentEnd()
```

#### _selectAll

```lua
TextBox:_selectAll()
```

#### _scrollLines

```lua
TextBox:_scrollLines()
```

#### _scrollColumns

```lua
TextBox:_scrollColumns()
```

#### _cursorFromPoint

```lua
TextBox:_cursorFromPoint()
```

#### _computeSyntaxColors

```lua
TextBox:_computeSyntaxColors()
```

#### _buildLineSegments

```lua
TextBox:_buildLineSegments()
```

#### _drawSegments

```lua
TextBox:_drawSegments()
```

#### _drawFindOverlay

```lua
TextBox:_drawFindOverlay()
```

#### _hideAutocomplete

```lua
TextBox:_hideAutocomplete()
```

#### _updateAutocomplete

```lua
TextBox:_updateAutocomplete()
```

#### _computeAutocompleteGhost

```lua
TextBox:_computeAutocompleteGhost()
```

#### _acceptAutocomplete

```lua
TextBox:_acceptAutocomplete()
```

#### _moveAutocompleteSelection

```lua
TextBox:_moveAutocompleteSelection()
```

#### _toggleFindOverlay

```lua
TextBox:_toggleFindOverlay()
```

#### _closeFindOverlay

```lua
TextBox:_closeFindOverlay()
```

#### _toggleFindField

```lua
TextBox:_toggleFindField()
```

#### _editFindFieldText

```lua
TextBox:_editFindFieldText()
```

#### _handleOverlayBackspace

```lua
TextBox:_handleOverlayBackspace()
```

#### _updateFindMatches

```lua
TextBox:_updateFindMatches()
```

#### _selectMatch

```lua
TextBox:_selectMatch()
```

#### _gotoMatch

```lua
TextBox:_gotoMatch()
```

#### _gotoNextMatch

```lua
TextBox:_gotoNextMatch()
```

#### _gotoPreviousMatch

```lua
TextBox:_gotoPreviousMatch()
```

#### _replaceCurrentMatch

```lua
TextBox:_replaceCurrentMatch()
```

#### _replaceAll

```lua
TextBox:_replaceAll()
```

#### _handleEscape

```lua
TextBox:_handleEscape()
```

#### _handleKey

```lua
TextBox:_handleKey()
```

#### draw

```lua
TextBox:draw()
```

#### handleEvent

```lua
TextBox:handleEvent()
```

#### setText

```lua
TextBox:setText()
```

#### getText

```lua
TextBox:getText()
```

#### setOnChange

```lua
TextBox:setOnChange()
```

### pixelui

#### create

*Since: 0.1.0*

```lua
pixelui.create(options)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| options | `PixelUI.AppOptions?` |  |

**Returns:**

- `PixelUI.App`

### App

#### getRoot

*Since: 0.1.0*

```lua
App:getRoot()
```

**Returns:**

- `PixelUI.Frame`

#### setBackground

*Since: 0.1.0*

```lua
App:setBackground(color)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color` |  |

#### getLayer

*Since: 0.1.0*

```lua
App:getLayer()
```

**Returns:**

- `Layer`

#### getPixelLayer

*Since: 0.1.0*

```lua
App:getPixelLayer()
```

**Returns:**

- `Layer`

#### createFrame

*Since: 0.1.0*

```lua
App:createFrame(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Frame`

#### createButton

*Since: 0.1.0*

```lua
App:createButton(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Button`

#### createLabel

*Since: 0.1.0*

```lua
App:createLabel(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Label`

#### createCheckBox

*Since: 0.1.0*

```lua
App:createCheckBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.CheckBox`

#### createToggle

*Since: 0.1.0*

```lua
App:createToggle(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Toggle`

#### createTextBox

*Since: 0.1.0*

```lua
App:createTextBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.TextBox`

#### createComboBox

*Since: 0.1.0*

```lua
App:createComboBox(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.ComboBox`

#### createList

*Since: 0.1.0*

```lua
App:createList(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.List`

#### createTable

*Since: 0.1.0*

```lua
App:createTable(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Table`

#### createTreeView

*Since: 0.1.0*

```lua
App:createTreeView(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.TreeView`

#### createChart

*Since: 0.1.0*

```lua
App:createChart(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Chart`

#### createRadioButton

*Since: 0.1.0*

```lua
App:createRadioButton(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.RadioButton`

#### createProgressBar

*Since: 0.1.0*

```lua
App:createProgressBar(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.ProgressBar`

#### createNotificationToast

```lua
App:createNotificationToast(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.NotificationToast`

#### createLoadingRing

```lua
App:createLoadingRing(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.LoadingRing`

#### createSlider

*Since: 0.1.0*

```lua
App:createSlider(config)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| config | `PixelUI.WidgetConfig?` |  |

**Returns:**

- `PixelUI.Slider`

#### _ensureAnimationTimer

```lua
App:_ensureAnimationTimer()
```

#### _updateAnimations

```lua
App:_updateAnimations()
```

#### _clearAnimations

```lua
App:_clearAnimations()
```

#### animate

*Since: 0.1.0*

```lua
App:animate(options)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| options | `PixelUI.AnimationOptions` |  |

**Returns:**

- `PixelUI.AnimationHandle`

#### _ensureThreadPump

```lua
App:_ensureThreadPump()
```

#### _cleanupThread

```lua
App:_cleanupThread()
```

#### _resumeThread

```lua
App:_resumeThread()
```

#### _serviceThreads

```lua
App:_serviceThreads()
```

#### _shutdownThreads

```lua
App:_shutdownThreads()
```

#### spawnThread

```lua
App:spawnThread()
```

#### getThreads

```lua
App:getThreads()
```

#### _registerPopup

```lua
App:_registerPopup()
```

#### _unregisterPopup

```lua
App:_unregisterPopup()
```

#### _drawPopups

```lua
App:_drawPopups()
```

#### _registerRadioButton

```lua
App:_registerRadioButton()
```

#### _unregisterRadioButton

```lua
App:_unregisterRadioButton()
```

#### _selectRadioInGroup

```lua
App:_selectRadioInGroup()
```

#### setFocus

*Since: 0.1.0*

```lua
App:setFocus(widget)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| widget | `PixelUI.Widget?` |  |

#### getFocus

*Since: 0.1.0*

```lua
App:getFocus()
```

**Returns:**

- `PixelUI.Widget?`

#### render

*Since: 0.1.0*

```lua
App:render()
```

#### step

*Since: 0.1.0*

```lua
App:step(event)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| event | `string` |  |

#### run

*Since: 0.1.0*

```lua
App:run()
```

#### stop

*Since: 0.1.0*

```lua
App:stop()
```

## Type Aliases

| Name | Type |
|------|------|
| PixelUI.Color | `integer` |
| ccTweaked.colors.color | `integer` |
| PixelUI.ThreadStatus | `"running"\|"completed"\|"error"\|"cancelled"` |
| PixelUI.WidgetConfig | `table` |

