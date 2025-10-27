# PixelUI.App

## Fields

### window

- **Type:** `table`

### box

- **Type:** `ShrekBox`

### layer

- **Type:** `Layer`

### pixelLayer

- **Type:** `Layer`

### background

- **Type:** `PixelUI.Color`

### root

- **Type:** `PixelUI.Frame`

### running

- **Type:** `boolean`

### _autoWindow

- **Type:** `boolean`

### _parentTerminal

- **Type:** `table?`

### _focusWidget

- **Type:** `PixelUI.Widget?`

### _popupWidgets

- **Type:** `PixelUI.Widget[]`

### _popupLookup

- **Type:** `table<PixelUI.Widget, boolean>`

### _animations

- **Type:** `table`

### _animationTimer

- **Type:** `integer?`

### _animationInterval

- **Type:** `number`

### _radioGroups

- **Type:** `table<string, { buttons: PixelUI.RadioButton[], lookup: table<PixelUI.RadioButton, boolean>, selected: PixelUI.RadioButton? }>`

## Methods

### getRoot

*Since: 0.1.0*

**Returns:**

- `PixelUI.Frame`

### setBackground

*Since: 0.1.0*

**Parameters:**

- `color` (`PixelUI.Color`)

### getLayer

*Since: 0.1.0*

**Returns:**

- `Layer`

### getPixelLayer

*Since: 0.1.0*

**Returns:**

- `Layer`

### createFrame

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Frame`

### createButton

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Button`

### createLabel

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Label`

### createCheckBox

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.CheckBox`

### createToggle

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Toggle`

### createTextBox

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.TextBox`

### createComboBox

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.ComboBox`

### createList

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.List`

### createTable

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Table`

### createTreeView

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.TreeView`

### createChart

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Chart`

### createRadioButton

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.RadioButton`

### createProgressBar

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.ProgressBar`

### createSlider

*Since: 0.1.0*

**Parameters:**

- `config` (`PixelUI.WidgetConfig?`)

**Returns:**

- `PixelUI.Slider`

### animate

*Since: 0.1.0*

**Parameters:**

- `options` (`PixelUI.AnimationOptions`)

**Returns:**

- `PixelUI.AnimationHandle`

### setFocus

*Since: 0.1.0*

**Parameters:**

- `widget` (`PixelUI.Widget?`)

### getFocus

*Since: 0.1.0*

**Returns:**

- `PixelUI.Widget?`

### render

*Since: 0.1.0*

### step

*Since: 0.1.0*

**Parameters:**

- `event` (`string`)

### run

*Since: 0.1.0*

### stop

*Since: 0.1.0*

