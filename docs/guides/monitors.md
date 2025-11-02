# Using PixelUI with ComputerCraft Monitors

PixelUI renders beautifully on ComputerCraft monitors, letting you deploy dashboards and control panels away from the in-game terminal. This guide walks through the setup, shows how to tune layouts for large displays, and highlights monitor-specific features such as touch input.

## Prerequisites

- **ComputerCraft or CC:Tweaked** with monitor peripherals attached
- **PixelUI v2** files installed on the computer controlling the monitor
- Basic familiarity with Lua and the PixelUI application bootstrap
- The monitor configured to an appropriate size (`/monitor set <side> <width> <height>` in CC:Tweaked)

## Quick Start Example

```lua
local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)

local pixelui = require("pixelui")


local width, height = monitor.getSize()
local viewport = window.create(monitor, 1, 1, width, height, true)

local app = pixelui.create({
	window = viewport,
	background = colors.black,
	rootBorder = { color = colors.gray },
	animationInterval = 0.05
})

local root = app:getRoot()

local header = app:createLabel({
	width = width,
	height = 1,
	text = "Remote Operations",
	align = "center",
	bg = colors.blue,
	fg = colors.white
})
root:addChild(header)

app:run()
```

> **Tip:** When you pass the monitor to `pixelui.create`, PixelUI automatically swaps the active terminal and handles correct rendering on that surface. When the app stops, the original terminal is restored.

## Choosing a Text Scale

- **Start with `setTextScale(0.5)`** for large monitors to increase available character cells.
- PixelUI widgets use character coordinates, so lowering the text scale effectively gives you more layout room.
- If text appears too small, experiment with `1` or `2`. Always update your layout bounds (width/height) to match `monitor.getSize()` after changing the scale.

## Sizing and Layout Considerations

1. **Query the monitor size** immediately after setting the text scale:
   ```lua
   local width, height = monitor.getSize()
   ```
2. **Resize the root frame or the widgets** to match that size. For example, `root:setSize(width, height)` or pass `width`/`height` when creating frames.
3. **Use constraints** (see [Constraints](/constraints.md)) to make complex screens respond to different monitor dimensions.
4. **Leverage layout helpers** like those in `example.lua` to centralize resizing logic when the monitor size changes.

## Handling Touch Input

- Monitors emit `monitor_touch` events; PixelUI automatically translates these into widget clicks.
- Ensure interactive widgets (buttons, lists, tab controls, context menus) have enough padding for finger-sized clicks.
- For custom widgets, implement `handleEvent` and check for the `"monitor_touch"` source to deliver appropriate behavior.

## Multi-Monitor Setups

PixelUI can drive any window-like object. With CC:Tweaked you can stitch monitors using `monitor combine`. Wrap the combined monitor and follow the same steps—just remember that the text scale will reset to `1` when you combine or separate, so reapply your preferred scale.

For advanced scenarios you can create multiple PixelUI apps, each bound to a different monitor, or reuse a single app with different windows by calling `app:setWindow(newWindow)` (be mindful of tearing during the swap).

## Performance Notes

- Keep animations sparing on very large monitors; consider increasing `animationInterval` to `0.1` if the screen flickers.
- When streaming frequent data updates, batch changes and call `app:render()` once per tick rather than per widget update.
- Disable borders or simplify fills on massive dashboards to cut draw time.

## Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| Nothing renders on the monitor | Window not passed to `pixelui.create` | Ensure the `window` option points to the wrapped monitor |
| Text appears tiny | Text scale still `1` on a large monitor | Call `monitor.setTextScale(0.5)` before creating the app |
| Touch presses ignored | Widgets not focusable or obscured | Verify the widget’s `visible` and `focusable` flags; ensure no overlapping frames block input |
| Colors look dull | Monitor not advanced | Craft or enable an advanced monitor; standard monitors only support grayscale |

## Further Reading

- `example.lua` – contains monitor-friendly layout patterns and animation usage.
- [`constraints.md`](./constraints.md) – details adaptive sizing strategies for varying monitor resolutions.
- [`monitors` peripheral docs](https://tweaked.cc/module/peripheral.html) – official CC:Tweaked reference for monitor APIs.

With these steps you can deliver polished status boards or remote controls on any in-game monitor.
