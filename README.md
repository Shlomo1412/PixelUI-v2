# PixelUI v2

A modern UI framework for ComputerCraft with comprehensive widget support and smooth animations.

## Features

- Rich collection of widgets (buttons, labels, checkboxes, toggles, text inputs, lists, tables, charts, and more)
- Flexible frame-based layout system
- Built-in animation system with various easing functions
- Comprehensive event handling
- Thread management for background tasks
- Full LuaDoc type annotations

## Documentation

Full API documentation is available at: https://shlomo1412.github.io/PixelUI-v2/

To build the documentation locally:

```bash
npm install
npm run docs:dev
```

## Quick Start

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

## Development

### Generating Documentation

The documentation is automatically generated from LuaDoc annotations in `pixelui.lua`:

```bash
npm run generate-docs
```

This will parse the annotations and generate markdown files in the `docs` directory.

### Building Documentation

Build the VitePress documentation site:

```bash
npm run docs:build
```

The built site will be in `docs/.vitepress/dist`.

## License

MIT License
