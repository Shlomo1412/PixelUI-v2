# PixelUI.FreeDraw

*Extends: PixelUI.Widget*

A raw drawing surface that exposes ShrekBox layers for custom rendering. Useful for advanced visualisations or integrating bespoke ASCII art.

## Properties

| Name | Type | Description |
|------|------|-------------|
| onDraw | `fun(self:PixelUI.FreeDraw,` |  |
| clear | `boolean` | Whether to clear the region before drawing |

## Methods

### new

```lua
new()
```

### setOnDraw

```lua
setOnDraw()
```

### setClear

```lua
setClear()
```

### draw

```lua
draw()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Custom drawing surface
local canvas = app:freedraw({
    x = 2, y = 2,
    width = 20, height = 10,
    clear = true,
    onDraw = function(self, ctx)
        ctx.fill(colors.black)
        ctx.write(1, 1, "Custom Draw", colors.white)
    end
})
app.root:addChild(canvas)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Pixel art drawing with ShrekBox layers
local canvas = app:freedraw({
    x = 2, y = 2,
    width = 30, height = 15,
    clear = true,
    onDraw = function(self, ctx)
        -- Clear background
        ctx.fill(colors.black)
        
        -- Draw pixel pattern
        for px = 1, ctx.width * 2 do
            for py = 1, ctx.height * 3 do
                if (px + py) % 4 == 0 then
                    ctx.pixel(px, py, colors.blue)
                end
            end
        end
        
        -- Draw text overlay
        ctx.write(2, 2, "Pixel Art", colors.yellow, colors.black)
        
        -- Access raw layers for advanced drawing
        local layer = ctx.pixelLayer
        -- layer:pixel(x, y, color) for absolute coords
    end
})

app.root:addChild(canvas)

app:run()
```

</details>

