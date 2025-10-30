# FreeDraw Surfaces

`PixelUI.FreeDraw` is a lightweight canvas widget that exposes direct access to the underlying ShrekBox text and pixel layers. Use it when the built-in widgets are not flexible enough and you need to render custom visuals yourself.

## Creating a FreeDraw Widget

```lua
local canvas = app:createFreeDraw({
  x = 4,
  y = 3,
  width = 24,
  height = 9,
  bg = colors.black,
  fg = colors.white,
  border = { color = colors.lightGray },
  onDraw = function(self, ctx)
    ctx.fill(colors.black)
    for x = 1, ctx.width do
      local angle = (x / ctx.width) * math.pi * 2
      local y = math.floor(ctx.height / 2 + math.sin(angle) * (ctx.height / 3))
      ctx.pixel(x, math.max(1, math.min(ctx.height, y)), colors.cyan)
    end
    ctx.write(2, 2, "FreeDraw", colors.white)
  end
})
```

Add the widget to a frame like any other control. The `onDraw` callback runs every frame when the widget is visible.

## Drawing Context Reference

The `ctx` object passed to `onDraw(self, ctx)` exposes everything you need to render:

- `ctx.width`, `ctx.height`, `ctx.x`, `ctx.y` — current bounds in characters
- `ctx.fill(color)` — flood-fills the widget with the provided background color (defaults to the widget background)
- `ctx.write(x, y, text, fg, bg)` — prints a string relative to the widget origin (1-based), automatically clipping to the canvas
- `ctx.pixel(x, y, color)` — sets a high-resolution pixel (two per character horizontally, three vertically)
- `ctx.textLayer`, `ctx.pixelLayer` — direct access to the ShrekBox layers for advanced use cases
- `ctx.app`, `ctx.box` — references to the owning app and render box if you need global state

## Clearing Behaviour

By default FreeDraw clears itself before each draw. Set `clear = false` (or call `widget:setClear(false)`) to keep previous content around for incremental drawing effects. When you disable automatic clearing, remember to call `ctx.fill` when you need to reset the surface.

## Updating the Draw Handler

Swap render logic on the fly with `widget:setOnDraw(handler)`:

```lua
local patterns = {
  grid = function(ctx)
    ctx.fill(colors.black)
    for y = 1, ctx.height, 2 do
      for x = 1, ctx.width do
        ctx.pixel(x, y, colors.gray)
      end
    end
  end,
  spark = function(ctx)
    ctx.fill(colors.black)
    for i = 1, math.min(40, ctx.width * ctx.height) do
      ctx.pixel(math.random(1, ctx.width), math.random(1, ctx.height), colors.yellow)
    end
  end
}

canvas:setOnDraw(patterns.grid)
canvas:setOnDraw(patterns.spark)
```

Any change to the draw handler is picked up by the next render pass — no manual invalidation required.

## Demo

Run `example.lua` and jump to step 18 in the wizard to experiment with FreeDraw. The sample cycles through three patterns and shows how writing text, plotting pixels, and filling backgrounds all work together.
