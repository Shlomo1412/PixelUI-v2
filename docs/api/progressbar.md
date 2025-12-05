# PixelUI.ProgressBar

*Extends: PixelUI.Widget*

A progress indicator widget showing completion status. Supports determinate and indeterminate modes with optional labels.

## Properties

| Name | Type | Description |
|------|------|-------------|
| value | `number` | Current progress value |
| min | `number` | Minimum progress value |
| max | `number` | Maximum progress value |
| indeterminate | `boolean` | Whether to show an animated indeterminate state |
| label | `string?` | Optional label text to display |
| showPercent | `boolean` | Whether to show percentage text |
| trackColor | `PixelUI.Color` | Background track color |
| fillColor | `PixelUI.Color` | Foreground fill color |
| textColor | `PixelUI.Color` | Color for text (label and percentage) |

## Methods

### new

```lua
new()
```

### _clampValue

```lua
_clampValue()
```

### _stopIndeterminateAnimation

```lua
_stopIndeterminateAnimation()
```

### _startIndeterminateAnimation

```lua
_startIndeterminateAnimation()
```

### setRange

```lua
setRange()
```

### getRange

```lua
getRange()
```

### setValue

```lua
setValue()
```

### getValue

```lua
getValue()
```

### getPercent

```lua
getPercent()
```

### setIndeterminate

```lua
setIndeterminate()
```

### isIndeterminate

```lua
isIndeterminate()
```

### setLabel

```lua
setLabel()
```

### setShowPercent

```lua
setShowPercent()
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

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple progress bar
local progress = app:progressbar({
    x = 2, y = 2,
    width = 30, height = 1,
    value = 50,
    min = 0,
    max = 100,
    showPercent = true
})
app.root:addChild(progress)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Progress bar with animation and custom styling
local progress = app:progressbar({
    x = 2, y = 2,
    width = 40, height = 2,
    value = 0,
    min = 0,
    max = 100,
    showPercent = true,
    label = "Downloading...",
    trackColor = colors.gray,
    fillColor = colors.green,
    textColor = colors.white
})

-- Indeterminate loading indicator
local loadingBar = app:progressbar({
    x = 2, y = 6,
    width = 40, height = 1,
    indeterminate = true,
    fillColor = colors.cyan
})

-- Animate the determinate progress
app:spawnThread(function(ctx)
    for i = 0, 100, 2 do
        progress:setValue(i)
        ctx:sleep(0.1)
    end
    progress:setLabel("Complete!")
end)

app.root:addChild(progress)
app.root:addChild(loadingBar)

app:run()
```

</details>

