# Getting Started

Welcome to PixelUI! This guide will help you get started with creating beautiful UIs for ComputerCraft.

## What is PixelUI?

PixelUI is a modern UI library for ComputerCraft that provides pixel-perfect rendering and a rich set of widgets. Built on top of ShrekBox, it offers advanced graphics capabilities while maintaining ease of use.

## Prerequisites

- ComputerCraft: Tweaked (or compatible mod)
- ShrekBox library (dependency)

## Quick Start

Here's a simple example to create your first PixelUI application:

```lua
local pixelui = require("pixelui")

-- Create the app
local app = pixelui.create({
  background = colors.gray
})

-- Get the root frame
local root = app:getRoot()

-- Create a button
local button = app:createButton({
  x = 10,
  y = 5,
  width = 20,
  height = 3,
  label = "Click Me!",
  bg = colors.blue,
  fg = colors.white,
  onClick = function(self)
    print("Button clicked!")
  end
})

-- Add button to root
root:addChild(button)

-- Run the app
app:run()
```

## Core Concepts

### App

The `App` is the main container for your UI. It manages the window, rendering, and event handling.

```lua
local app = pixelui.create({
  background = colors.black,
  animationInterval = 0.05
})
```

### Widgets

Widgets are the building blocks of your UI. PixelUI provides many built-in widgets:

- **Frame**: Container for other widgets
- **Button**: Clickable button
- **Label**: Text display
- **TextBox**: Text input
- **CheckBox**: Checkbox control
- **Toggle**: Toggle switch
- **RadioButton**: Radio button (mutually exclusive selection)
- **ProgressBar**: Progress indicator
- **Slider**: Numeric slider input
- **ComboBox**: Dropdown selection
- **List**: Scrollable list
- **Table**: Data table with columns
- **TreeView**: Hierarchical tree view
- **Chart**: Data visualization (bar/line charts)

### Event Handling

Widgets respond to events like clicks, key presses, and more:

```lua
button.onClick = function(self, button, x, y)
  print("Clicked at", x, y)
end
```

## Next Steps

- [Installation Guide](./installation.md) - Learn how to install PixelUI
- [Examples](./examples.md) - See more examples
- [API Reference](/api/) - Detailed API documentation
