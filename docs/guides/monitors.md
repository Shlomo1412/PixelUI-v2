# Using PixelUI on Monitors

This guide covers how to use PixelUI v2 applications on ComputerCraft monitors, including setup, configuration, and best practices for multi-monitor displays.

## Basic Monitor Setup

PixelUI can render to any ComputerCraft monitor by creating a window on the monitor peripheral and passing it to the application.

```lua
local pixelui = require("pixelui")

-- Find and wrap the monitor
local monitor = peripheral.find("monitor")
if not monitor then
  error("No monitor found!")
end

-- Create the application with the monitor as the target window
local app = pixelui.create({
  window = monitor
})

-- Get the root frame
local root = app:getRoot()

-- Create your UI normally
local button = app:createButton({
  x = 5,
  y = 3,
  width = 20,
  height = 3,
  label = "Monitor Button",
  bg = colors.blue,
  fg = colors.white,
  onClick = function()
    print("Clicked on monitor!")
  end
})
root:addChild(button)

-- Run the application
app:run()
```

## Specific Monitor Selection

If you have multiple monitors, you can target a specific one by name or side:

```lua
-- Connect to a specific monitor by name
local monitor = peripheral.wrap("monitor_0")

-- Or connect to a monitor on a specific side
local monitor = peripheral.wrap("top")  -- monitor above the computer

if not monitor then
  error("Monitor not found on the specified side!")
end

local app = pixelui.create({
  window = monitor
})
```

## Monitor Size Detection and Adaptive UI

Monitors come in different sizes. Use the monitor's dimensions to create adaptive layouts:

```lua
local monitor = peripheral.find("monitor")
local width, height = monitor.getSize()

print(string.format("Monitor size: %dx%d", width, height))

local app = pixelui.create({
  window = monitor,
  background = colors.black
})

local root = app:getRoot()

-- Create a frame that adapts to monitor size
local mainPanel = app:createFrame({
  x = 2,
  y = 2,
  width = width - 2,
  height = height - 2,
  bg = colors.gray,
  border = { color = colors.white }
})
root:addChild(mainPanel)

-- Use constraints for responsive design
local title = app:createLabel({
  x = 1,
  y = 1,
  width = 30,
  height = 1,
  text = "Monitor Dashboard",
  align = "center",
  bg = colors.blue,
  fg = colors.white,
  constraints = {
    width = "parent.width",
    centerX = true
  }
})
mainPanel:addChild(title)
```

## Touch Events on Advanced Monitors

Advanced monitors support touch events. PixelUI automatically handles these as `monitor_touch` events:

```lua
local monitor = peripheral.find("monitor")

-- Enable touch events (only works on Advanced Monitors)
if monitor.setTextScale then
  monitor.setTextScale(0.5)  -- Optional: make text smaller for more space
end

local app = pixelui.create({
  window = monitor
})

local root = app:getRoot()

-- Create interactive elements
local touchButton = app:createButton({
  x = 5,
  y = 5,
  width = 25,
  height = 4,
  label = "Touch Me!",
  bg = colors.green,
  fg = colors.white,
  onClick = function(self, button, x, y)
    print(string.format("Touched at %d, %d", x, y))
  end
})
root:addChild(touchButton)

-- Create a larger touch area
local touchPanel = app:createFrame({
  x = 2,
  y = 10,
  width = 40,
  height = 8,
  bg = colors.lightBlue,
  border = { color = colors.blue }
})
root:addChild(touchPanel)

-- Handle custom touch events on the panel
touchPanel.handleEvent = function(self, event, ...)
  if event == "monitor_touch" then
    local _, x, y = ...
    if self:containsPoint(x, y) then
      -- Custom touch handling
      print(string.format("Panel touched at %d, %d", x, y))
      return true
    end
  end
  -- Fall back to default handling
  return false
end

app:run()
```

## Multi-Monitor Setups

For complex setups with multiple monitors, you can run separate PixelUI applications on each:

```lua
local pixelui = require("pixelui")

-- Find all monitors
local monitors = { peripheral.find("monitor") }

if #monitors == 0 then
  error("No monitors found!")
end

local apps = {}

-- Create an application for each monitor
for i, monitor in ipairs(monitors) do
  local app = pixelui.create({
    window = monitor,
    background = colors.black
  })
  
  local root = app:getRoot()
  
  -- Create monitor-specific content
  local label = app:createLabel({
    x = 2,
    y = 2,
    width = 25,
    height = 1,
    text = string.format("Monitor %d", i),
    bg = colors.blue,
    fg = colors.white
  })
  root:addChild(label)
  
  -- Store the app for later use
  apps[i] = app
end

-- Run applications in parallel using the built-in threading
local function runMonitor(app)
  app:run()
end

-- Start each monitor app in a separate thread
for i, app in ipairs(apps) do
  app:spawnThread(function()
    runMonitor(app)
  end, { name = string.format("Monitor_%d", i) })
end

-- Keep the main program running
while true do
  os.sleep(1)
end
```

## Monitor Scale and Text Size

Advanced monitors support different text scales, which affects the available screen space:

```lua
local monitor = peripheral.find("monitor")

-- Check if the monitor supports scaling
if monitor.setTextScale then
  -- Available scales: 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0
  monitor.setTextScale(0.5)  -- Smaller text, more space
  
  -- Get the new size after scaling
  local width, height = monitor.getSize()
  print(string.format("Monitor size at 0.5 scale: %dx%d", width, height))
end

local app = pixelui.create({
  window = monitor
})

-- Design your UI based on the available space
-- Smaller scales give you more characters to work with
```

## Best Practices for Monitor UIs

### 1. Use Appropriate Sizes
```lua
-- Monitor UIs can be larger than terminal UIs
local dashboard = app:createFrame({
  width = 50,   -- Much wider than typical terminal apps
  height = 20,
  bg = colors.gray,
  border = { color = colors.white }
})
```

### 2. Consider Viewing Distance
```lua
-- Use larger, more readable fonts for monitors viewed from a distance
local title = app:createLabel({
  text = "REACTOR STATUS",
  align = "center",
  bg = colors.red,
  fg = colors.white,
  constraints = {
    width = "parent.width",
    height = 3  -- Taller text area
  }
})
```

### 3. Leverage Color for Information
```lua
-- Monitors are great for color-coded status displays
local statusIndicators = {
  { label = "Power", status = "online", color = colors.green },
  { label = "Cooling", status = "normal", color = colors.blue },
  { label = "Fuel", status = "low", color = colors.orange }
}

for i, indicator in ipairs(statusIndicators) do
  local status = app:createLabel({
    x = 2,
    y = 2 + i * 2,
    width = 20,
    height = 1,
    text = string.format("%s: %s", indicator.label, indicator.status),
    bg = indicator.color,
    fg = colors.white
  })
  root:addChild(status)
end
```

### 4. Handle Monitor Disconnection
```lua
local function createMonitorApp()
  local monitor = peripheral.find("monitor")
  
  if not monitor then
    print("No monitor found, waiting...")
    return nil
  end
  
  return pixelui.create({
    window = monitor,
    background = colors.black
  })
end

-- Robust monitor connection handling
local app
while true do
  if not app then
    app = createMonitorApp()
    if app then
      print("Monitor connected, starting UI...")
      -- Set up your UI here
      app:run()
    end
  end
  
  -- Check if monitor is still connected
  if app and not peripheral.find("monitor") then
    print("Monitor disconnected")
    app = nil
  end
  
  os.sleep(1)
end
```

## Common Monitor Applications

### Information Display
```lua
-- Perfect for status dashboards, server monitoring, etc.
local dashboard = app:createFrame({
  constraints = {
    width = "parent.width",
    height = "parent.height"
  },
  bg = colors.black
})

-- Add real-time data widgets
local timeLabel = app:createLabel({
  x = 2, y = 1,
  width = 20, height = 1,
  text = os.date("%H:%M:%S"),
  fg = colors.white
})
dashboard:addChild(timeLabel)

-- Update time every second
app:spawnThread(function(ctx)
  while not ctx:isCancelled() do
    timeLabel:setText(os.date("%H:%M:%S"))
    ctx:sleep(1)
  end
end)
```

### Control Panels
```lua
-- Interactive control interfaces
local controlPanel = app:createFrame({
  width = 40, height = 15,
  bg = colors.gray,
  border = { color = colors.white }
})

local powerButton = app:createToggle({
  x = 5, y = 3,
  width = 12, height = 3,
  labelOn = "POWER ON",
  labelOff = "POWER OFF",
  onChange = function(self, value)
    -- Control your machinery here
    print("Power:", value and "ON" or "OFF")
  end
})
controlPanel:addChild(powerButton)
```

## Troubleshooting

### Monitor Not Detected
- Ensure the monitor is properly connected with network cables
- Use `peripheral.getNames()` to list all connected peripherals, or type `peripherals` in your shell to see all connected peripherals mannually

### Touch Events Not Working
- Confirm you're using an Advanced Monitor (not a regular Monitor)
- Check that the monitor peripheral supports the `monitor_touch` event
- Make sure your widgets have proper event handling

### Performance Issues
- Reduce the number of widgets on screen
- Use threading to prevent blocking the UI
- Consider using a larger text scale to reduce the rendering area

---

*Next: Learn about [Animations](animations.md) to make your monitor displays more engaging*