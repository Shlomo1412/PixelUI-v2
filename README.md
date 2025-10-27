# PixelUI v2

A modern, pixel-perfect UI library for ComputerCraft built on top of [ShrekBox](https://github.com/9551-Dev/shrekbox).

## Features

- 🎨 **Pixel-Perfect Rendering**: Built on ShrekBox for precise pixel-level graphics
- 🧩 **Rich Widget Set**: Buttons, Labels, TextBoxes, Tables, Charts, and more
- ⚡ **Animation System**: Smooth animations with multiple easing functions
- 🔧 **Event Handling**: Robust mouse and keyboard event system with focus management
- 🧵 **Threading Support**: Run background tasks without blocking the UI
- 📚 **Type Annotations**: Full Lua Language Server annotations for better IDE support

## Documentation

Full documentation is available at: **[https://shlomo1412.github.io/PixelUI-v2/](https://shlomo1412.github.io/PixelUI-v2/)**

- [Getting Started](https://shlomo1412.github.io/PixelUI-v2/guide/getting-started)
- [Installation Guide](https://shlomo1412.github.io/PixelUI-v2/guide/installation)
- [Examples](https://shlomo1412.github.io/PixelUI-v2/guide/examples)
- [API Reference](https://shlomo1412.github.io/PixelUI-v2/api/)

## Quick Start

```lua
local pixelui = require("pixelui")

-- Create the app
local app = pixelui.create({
  background = colors.gray
})

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

root:addChild(button)

-- Run the app
app:run()
```

## Installation

### In ComputerCraft

```lua
-- Download the library
wget https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/compressed/pixelui.lua
```

### For Development

1. Clone this repository
2. Install Node.js dependencies: `npm install`
3. Build documentation: `npm run docs:build`
4. Preview documentation: `npm run docs:preview`

## Available Widgets

- **Frame**: Container for organizing widgets
- **Button**: Clickable button with customizable appearance
- **Label**: Text display with alignment options
- **TextBox**: Text input field
- **CheckBox**: Checkbox control
- **Toggle**: Toggle switch
- **RadioButton**: Radio button for mutually exclusive selections
- **ProgressBar**: Progress indicator
- **Slider**: Numeric slider input
- **ComboBox**: Dropdown selection
- **List**: Scrollable list of items
- **Table**: Data table with columns and rows
- **TreeView**: Hierarchical tree structure
- **Chart**: Data visualization (bar and line charts)

## Documentation Generation

The documentation is automatically generated from Lua annotations in `pixelui.lua`:

```bash
# Parse annotations and generate markdown
npm run docs:parse

# Build the full documentation site
npm run docs:build

# Preview locally
npm run docs:preview
```

The documentation is automatically deployed to GitHub Pages when changes are pushed to the `main` branch.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - See LICENSE file for details

## Credits

- Built on [ShrekBox](https://github.com/9551-Dev/shrekbox) by 9551-Dev
- Designed for [ComputerCraft: Tweaked](https://github.com/cc-tweaked/CC-Tweaked)
