# Getting Started

This guide will help you get started with PixelUI v2 and build your first user interface.

## Installation

PixelUI v2 is a single-file library for ComputerCraft. Download `pixelui.lua` and place it in your ComputerCraft computer.

```lua
-- Download the installer using wget
wget run https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/installer.lua
```

## Your First Application

Let's create a simple application with a button:

```lua
local pixelui = require("pixelui")

-- Create the application
local app = pixelui.create()

-- Get the root frame
local root = app:getRoot()

-- Create a button
local button = app:createButton({
  x = 5,
  y = 5,
  width = 20,
  height = 3,
  label = "Click Me!",
  bg = colors.blue,
  fg = colors.white,
  onClick = function()
    print("Button clicked!")
  end
})

-- Add the button to the main frame
root:addChild(button)

-- Run the application
app:run()
```

## Understanding the Structure

Every PixelUI application has the following structure:

1. **Create the App** - `pixelui.create()` initializes the application
2. **Get the Root Frame** - The root frame is the main container
3. **Add Widgets** - Create and configure widgets
4. Remember to add the button to the frame: `root:addChild(widget)`
5. **Run the App** - Start the event loop with `app:run()`

## Adding More Widgets

Let's create a more complex interface:

```lua
local pixelui = require("pixelui")
local app = pixelui.create()
local root = app:getRoot()

-- Add a title label
local title = app:createLabel({
  x = 2,
  y = 2,
  width = root.width - 2,
  height = 3,
  text = "Welcome to PixelUI!",
  align = "center",
  verticalAlign = "middle",
  bg = colors.gray,
  fg = colors.yellow
})

-- Add to root
root:addChild(title)

-- Add a text input
local textbox = app:createTextBox({
  x = 2,
  y = 6,
  width = root.width - 2,
  height = 3,
  placeholder = "Enter your name...",
  bg = colors.white,
  fg = colors.black
})

-- Add to root
root:addChild(textbox)

-- Add a submit button
local submitBtn = app:createButton({
  x = 2,
  y = 10,
  width = 15,
  height = 3,
  label = "Submit",
  bg = colors.green,
  fg = colors.white,
  onClick = function()
    local name = textbox.text
    if name ~= "" then
      title:setText("Hello, " .. name .. "!")
    end
  end
})

-- And, yet again - add to root
root:addChild(submitBtn)

app:run()
```

## Working with Frames

Frames are containers that can hold other widgets. They're useful for organizing your UI:

```lua
-- Create a frame for a sidebar
local sidebar = app:createFrame({
  x = 1,
  y = 1,
  width = 15,
  height = root.height,
  bg = colors.gray,
  border = { color = colors.lightGray }
})
root:addChild(sidebar)

-- Add widgets to the sidebar
local menuBtn1 = app:createButton({
  x = 2,
  y = 2,
  width = 11,
  height = 3,
  label = "Menu 1",
  bg = colors.blue,
  fg = colors.white
})
sidebar:addChild(menuBtn1)

local menuBtn2 = app:createButton({
  x = 2,
  y = 6,
  width = 11,
  height = 3,
  label = "Menu 2",
  bg = colors.blue,
  fg = colors.white
})
sidebar:addChild(menuBtn2)
```

## Event Handling

Most widgets support event callbacks. Here are some common ones:

```lua
-- Button events
button.onClick = function(self, mouseBtn, x, y)
  print("Clicked at", x, y)
end

-- Text change events
textbox.onChange = function(self, text)
  print("Text changed to:", text)
end

-- List selection
local list = app:createList({
  items = {"Item 1", "Item 2", "Item 3"},
  onSelect = function(self, item, index)
    print("Selected:", item)
  end
})
root:addChild(list)

-- Checkbox state
local checkbox = app:createCheckBox({
  label = "Enable feature",
  onChange = function(self, checked, indeterminate)
    print("Checked:", checked)
  end
})
root:addChild(checkbox)
```

## Next Steps

Now that you understand the basics, explore:

- [Widget Reference](/api) - Learn about all available widgets
- [Animations Guide](/guides/animations) - Create smooth animations
- [Threading Guide](/guides/threading) - Run background tasks
- [Core Classes](/api/app) - Understand the App and Widget classes

## Tips

- Use `app:setBackground(color)` to set the background color
- Widgets can be nested in frames for complex layouts
- Use `z` property to control layering
- Call `app:render()` to manually redraw (normally automatic)
- Use `widget.visible = false` to hide widgets
- Always use `frame:addChild(widget)`, otherwise the widget won't render
