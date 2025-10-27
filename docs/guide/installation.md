# Installation

## Installing PixelUI

PixelUI can be installed in several ways depending on your setup.

## Prerequisites

Before installing PixelUI, you need to have:

1. **ComputerCraft: Tweaked** (or compatible mod) installed
2. **ShrekBox** library (PixelUI's dependency)

## Method 1: Direct Download

1. Download the `pixelui.lua` file from the [GitHub repository](https://github.com/Shlomo1412/PixelUI-v2)
2. Place it in your ComputerCraft computer's directory
3. Require it in your code:

```lua
local pixelui = require("pixelui")
```

## Method 2: Using wget (In-Game)

If you're in ComputerCraft, you can download PixelUI directly:

```lua
-- Download the compressed version
wget run https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/compressed/pixelui.lua pixelui.lua
```

Or download the full version with comments:

```lua
-- Download the full version
wget run https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/pixelui.lua pixelui.lua
```

## Installing ShrekBox

PixelUI depends on ShrekBox for pixel rendering. Install it similarly:

```lua
-- Follow ShrekBox installation instructions
-- (Add specific instructions based on ShrekBox setup)
```

## Verifying Installation

To verify PixelUI is installed correctly:

```lua
local pixelui = require("pixelui")
print("PixelUI version:", pixelui.version)
```

## Project Structure

For a typical PixelUI project:

```
your-project/
├── pixelui.lua      # PixelUI library
├── shrekbox.lua     # ShrekBox library (dependency)
└── main.lua         # Your application
```

## Next Steps

- [Getting Started Guide](./getting-started.md) - Create your first app
- [Examples](./examples.md) - See example applications
