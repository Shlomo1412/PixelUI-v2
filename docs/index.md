---
layout: home

hero:
  name: "PixelUI v2"
  text: "A Modern UI Framework"
  tagline: "Build beautiful, responsive user interfaces for ComputerCraft with ease"
  actions:
    - theme: brand
      text: Get Started
      link: /api
    - theme: alt
      text: View on GitHub
      link: https://github.com/Shlomo1412/PixelUI-v2

features:
  - icon: 🎨
    title: Rich Widget Library
    details: Comprehensive collection of 15+ pre-built widgets including buttons, labels, checkboxes, toggles, text boxes, lists, tables, charts, sliders, and more.
  
  - icon: 📐
    title: Flexible Layout System
    details: Powerful frame-based layout system with support for borders, positioning, and z-ordering for complex UI hierarchies.
  
  - icon: ✨
    title: Smooth Animations
    details: Built-in animation system with various easing functions to create fluid, responsive user interfaces.
  
  - icon: 🎯
    title: Event Handling
    details: Comprehensive event system with focus management, mouse and keyboard input handling, and intuitive callbacks.
  
  - icon: ⚡
    title: Thread Management
    details: Advanced threading capabilities for background tasks with status tracking, cancellation support, and progress reporting.
  
  - icon: 🔒
    title: Type-Safe
    details: Fully annotated with LuaDoc type hints for better development experience, IDE support, and autocomplete.
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

## About This Project

PixelUI v2 is a complete rewrite of the original PixelUI framework, designed to provide a modern, feature-rich UI framework for ComputerCraft. Building on the lessons learned from v1, this version offers improved performance, better type safety, and a more comprehensive widget collection.

### Links

- **[GitHub Repository](https://github.com/Shlomo1412/PixelUI-v2)** - Current version (v2)
- **[PixelUI v1 (Archived)](https://github.com/Shlomo1412/PixelUI)** - Original version

### Documentation

For detailed API documentation, see the [API Reference](/api).

## Key Features Explained

### 🎨 Widget Variety

PixelUI v2 includes widgets for virtually every use case:

- **Interactive Controls**: Buttons, CheckBoxes, RadioButtons, Toggles
- **Data Display**: Labels, ProgressBars, Charts (bar & line)
- **Data Input**: TextBox (with multiline support), ComboBox, Slider
- **Data Structures**: List, Table (with sorting), TreeView
- **Notifications**: NotificationToast with multiple severity levels

### 📐 Layout Management

Create complex layouts using nested frames with:
- Absolute positioning for precise control
- Z-ordering for layer management
- Customizable borders on any widget
- Popup support for overlays and dialogs

### ✨ Animation System

Built-in easing functions for smooth transitions:
- Linear, Quad, Cubic, Quart, Quint
- Sine, Expo, Circ, Back, Elastic, Bounce
- Both "in" and "out" variants
- Custom easing function support

## License

PixelUI is released under the MIT License.
