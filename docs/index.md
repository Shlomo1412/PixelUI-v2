---
layout: home

hero:
  name: "PixelUI"
  text: "A Modern UI Framework"
  tagline: "Build beautiful user interfaces for ComputerCraft with ease"
  actions:
    - theme: brand
      text: Get Started
      link: /api
    - theme: alt
      text: View on GitHub
      link: https://github.com/Shlomo1412/PixelUI-v2

features:
  - title: Rich Widget Library
    details: Comprehensive collection of pre-built widgets including buttons, labels, checkboxes, toggles, text boxes, lists, tables, charts, and more.
  
  - title: Flexible Layout System
    details: Powerful frame-based layout system with support for borders, positioning, and z-ordering for complex UI hierarchies.
  
  - title: Smooth Animations
    details: Built-in animation system with various easing functions to create fluid, responsive user interfaces.
  
  - title: Event Handling
    details: Comprehensive event system with focus management, mouse and keyboard input handling.
  
  - title: Thread Management
    details: Advanced threading capabilities for background tasks with status tracking and cancellation support.
  
  - title: Type-Safe
    details: Fully annotated with LuaDoc type hints for better development experience and IDE support.
---

## Quick Start

Install PixelUI in your ComputerCraft environment:

```lua
local pixelui = require("pixelui")

-- Create an app instance
local app = pixelui.create()

-- Add widgets to the root frame
local root = app:getRoot()

-- Create a button
local button = app:createButton({
  parent = root,
  x = 5,
  y = 5,
  width = 20,
  height = 3,
  label = "Click Me!",
  onClick = function()
    print("Button clicked!")
  end
})

-- Run the app
app:run()
```

## Features Overview

### Widgets

PixelUI provides a comprehensive set of widgets:

- **Button** - Clickable buttons with press effects
- **Label** - Text display with alignment and wrapping
- **CheckBox** - Checkbox with optional indeterminate state
- **Toggle** - On/off toggle switches
- **TextBox** - Single and multi-line text input
- **ComboBox** - Dropdown selection
- **List** - Scrollable list selection
- **Table** - Data table with sorting and selection
- **TreeView** - Hierarchical tree display
- **Chart** - Bar and line charts for data visualization
- **RadioButton** - Radio button groups for exclusive selection
- **ProgressBar** - Progress indicators with optional labels
- **Slider** - Value sliders with range support
- **NotificationToast** - Temporary notification messages

### Animation System

Create smooth animations with built-in easing functions:

```lua
app:animate({
  duration = 1.0,
  easing = "easeOutQuad",
  update = function(progress)
    widget.x = startX + (endX - startX) * progress
  end,
  onComplete = function()
    print("Animation complete!")
  end
})
```

### Threading

Run background tasks without blocking the UI:

```lua
local handle = app:spawnThread(function(ctx)
  for i = 1, 100 do
    ctx:setProgress(i / 100)
    ctx:sleep(0.1)
    ctx:checkCancelled()
  end
  return "Task complete!"
end, { name = "Background Task" })
```

## Documentation

For detailed API documentation, see the [API Reference](/api).

## License

PixelUI is released under the MIT License.
