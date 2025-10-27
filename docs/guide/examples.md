# Examples

Here are some examples to help you get started with PixelUI.

## Basic Button Example

```lua
local pixelui = require("pixelui")

local app = pixelui.create({
  background = colors.gray
})

local root = app:getRoot()

local button = app:createButton({
  x = 5,
  y = 5,
  width = 15,
  height = 3,
  label = "Click Me",
  bg = colors.blue,
  fg = colors.white,
  onClick = function(self)
    self.label = "Clicked!"
  end
})

root:addChild(button)
app:run()
```

## Form with Multiple Widgets

```lua
local pixelui = require("pixelui")

local app = pixelui.create({ background = colors.lightGray })
local root = app:getRoot()

-- Title
local title = app:createLabel({
  x = 2,
  y = 2,
  width = 30,
  height = 1,
  text = "User Registration",
  align = "center",
  bg = colors.lightGray,
  fg = colors.black
})

-- Text input
local nameBox = app:createTextBox({
  x = 2,
  y = 5,
  width = 25,
  height = 3,
  placeholder = "Enter your name",
  bg = colors.white,
  fg = colors.black
})

-- Checkbox
local checkbox = app:createCheckBox({
  x = 2,
  y = 9,
  width = 25,
  height = 3,
  label = "Accept terms",
  bg = colors.lightGray,
  fg = colors.black
})

-- Submit button
local submitBtn = app:createButton({
  x = 2,
  y = 13,
  width = 15,
  height = 3,
  label = "Submit",
  bg = colors.green,
  fg = colors.white,
  onClick = function(self)
    if checkbox.checked then
      print("Submitted:", nameBox.text)
    else
      print("Please accept terms")
    end
  end
})

root:addChild(title)
root:addChild(nameBox)
root:addChild(checkbox)
root:addChild(submitBtn)

app:run()
```

## Progress Bar Example

```lua
local pixelui = require("pixelui")

local app = pixelui.create({ background = colors.black })
local root = app:getRoot()

local progressBar = app:createProgressBar({
  x = 5,
  y = 8,
  width = 30,
  height = 3,
  value = 0,
  min = 0,
  max = 100,
  bg = colors.gray,
  fg = colors.lime
})

root:addChild(progressBar)

-- Simulate progress
app:spawnThread(function(ctx)
  for i = 0, 100, 5 do
    progressBar.value = i
    app:render()
    ctx:sleep(0.1)
  end
end)

app:run()
```

## Animation Example

```lua
local pixelui = require("pixelui")

local app = pixelui.create({ background = colors.black })
local root = app:getRoot()

local button = app:createButton({
  x = 5,
  y = 5,
  width = 15,
  height = 3,
  label = "Animate",
  bg = colors.blue,
  fg = colors.white
})

root:addChild(button)

button.onClick = function(self)
  -- Animate button movement
  app:animate({
    widget = self,
    duration = 1.0,
    easing = "easeInOutQuad",
    properties = {
      x = 30,
      y = 10
    },
    onComplete = function()
      print("Animation complete!")
    end
  })
end

app:run()
```

## List Example

```lua
local pixelui = require("pixelui")

local app = pixelui.create({ background = colors.white })
local root = app:getRoot()

local items = {}
for i = 1, 20 do
  table.insert(items, "Item " .. i)
end

local list = app:createList({
  x = 5,
  y = 3,
  width = 25,
  height = 12,
  items = items,
  bg = colors.white,
  fg = colors.black,
  onSelect = function(self, item, index)
    print("Selected:", item, "at index", index)
  end
})

root:addChild(list)
app:run()
```

## Table Example

```lua
local pixelui = require("pixelui")

local app = pixelui.create({ background = colors.white })
local root = app:getRoot()

local table = app:createTable({
  x = 2,
  y = 2,
  width = 45,
  height = 15,
  columns = {
    { header = "Name", key = "name", width = 15 },
    { header = "Age", key = "age", width = 10 },
    { header = "City", key = "city", width = 15 }
  },
  data = {
    { name = "Alice", age = 30, city = "New York" },
    { name = "Bob", age = 25, city = "London" },
    { name = "Charlie", age = 35, city = "Paris" }
  },
  bg = colors.white,
  fg = colors.black
})

root:addChild(table)
app:run()
```

## More Examples

Check out the [example.lua](https://github.com/Shlomo1412/PixelUI-v2/blob/main/example.lua) file in the repository for more comprehensive examples.

## Next Steps

- [API Reference](/api/) - Detailed documentation
- [Widget Reference](/api/#classes) - All available widgets
