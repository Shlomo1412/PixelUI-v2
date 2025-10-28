# Animations

PixelUI v2 includes a powerful animation system with built-in easing functions for creating smooth, fluid animations.

## Basic Animation

Create an animation using `app:animate()`:

```lua
local widget = app:createButton({
  parent = root,
  x = 5,
  y = 5,
  width = 15,
  height = 3,
  label = "Animate Me"
})

-- Animate the button moving to the right
app:animate({
  duration = 1.0,  -- 1 second
  easing = "easeOutQuad",
  update = function(progress)
    widget.x = 5 + (30 * progress)
  end,
  onComplete = function()
    print("Animation complete!")
  end
})
```

## Animation Options

| Option | Type | Description |
|--------|------|-------------|
| `duration` | `number` | Duration in seconds (default: 1.0) |
| `easing` | `string\|function` | Easing function (default: "linear") |
| `update` | `function` | Called each frame with progress (0-1) |
| `onComplete` | `function` | Called when animation finishes |
| `onCancel` | `function` | Called if animation is cancelled |

## Easing Functions

PixelUI includes many built-in easing functions:

### Linear
- `linear` - No easing, constant speed

### Quadratic
- `easeInQuad` - Accelerating from zero velocity
- `easeOutQuad` - Decelerating to zero velocity
- `easeInOutQuad` - Acceleration until halfway, then deceleration

### Cubic
- `easeInCubic` - Cubic acceleration
- `easeOutCubic` - Cubic deceleration
- `easeInOutCubic` - Cubic acceleration and deceleration

### And more...
- Quartic: `easeInQuart`, `easeOutQuart`, `easeInOutQuart`
- Quintic: `easeInQuint`, `easeOutQuint`, `easeInOutQuint`
- Sine: `easeInSine`, `easeOutSine`, `easeInOutSine`
- Exponential: `easeInExpo`, `easeOutExpo`, `easeInOutExpo`
- Circular: `easeInCirc`, `easeOutCirc`, `easeInOutCirc`
- Back: `easeInBack`, `easeOutBack`, `easeInOutBack`
- Elastic: `easeInElastic`, `easeOutElastic`, `easeInOutElastic`
- Bounce: `easeInBounce`, `easeOutBounce`, `easeInOutBounce`

## Examples

### Moving a Widget

```lua
-- Slide widget in from left
app:animate({
  duration = 0.5,
  easing = "easeOutQuad",
  update = function(progress)
    widget.x = -20 + (25 * progress)  -- Start off-screen
  end
})
```

### Fading Colors

```lua
-- Fade widget background from red to blue
local startColor = colors.red
local endColor = colors.blue

app:animate({
  duration = 2.0,
  easing = "linear",
  update = function(progress)
    -- Note: This is a simplified example
    -- Actual color interpolation may require more complex logic
    if progress < 0.5 then
      widget.bg = startColor
    else
      widget.bg = endColor
    end
  end
})
```

### Pulsing Effect

```lua
-- Create a pulsing animation
local originalWidth = widget.width
local originalHeight = widget.height

app:animate({
  duration = 0.5,
  easing = "easeInOutQuad",
  update = function(progress)
    local scale = 1 + (0.1 * math.sin(progress * math.pi))
    widget.width = math.floor(originalWidth * scale)
    widget.height = math.floor(originalHeight * scale)
  end,
  onComplete = function()
    -- Restore original size
    widget.width = originalWidth
    widget.height = originalHeight
  end
})
```

### Chaining Animations

```lua
-- Move right, then down
app:animate({
  duration = 0.5,
  easing = "easeOutQuad",
  update = function(progress)
    widget.x = 5 + (20 * progress)
  end,
  onComplete = function()
    -- Start second animation
    app:animate({
      duration = 0.5,
      easing = "easeOutQuad",
      update = function(progress)
        widget.y = 5 + (10 * progress)
      end
    })
  end
})
```

### Cancelling Animations

```lua
local handle = app:animate({
  duration = 5.0,
  update = function(progress)
    widget.x = 5 + (50 * progress)
  end
})

-- Cancel after 2 seconds
os.startTimer(2)
-- In your event handler:
handle:cancel()
```

## Custom Easing Functions

You can create your own easing functions:

```lua
app:animate({
  duration = 1.0,
  easing = function(t)
    -- Custom bounce effect
    return t < 0.5 
      and 2 * t * t 
      or 1 - math.pow(-2 * t + 2, 2) / 2
  end,
  update = function(progress)
    widget.x = 5 + (30 * progress)
  end
})
```

## Performance Tips

1. **Avoid Creating Too Many Animations** - Too many simultaneous animations can impact performance
2. **Use Appropriate Durations** - Very short durations may not be noticeable
3. **Clean Up** - Cancel animations when widgets are removed
4. **Batch Updates** - When possible, update multiple properties in one animation

## Raw Progress

The `update` callback receives two parameters: `progress` (eased) and `rawProgress` (linear 0-1):

```lua
app:animate({
  duration = 1.0,
  easing = "easeOutBounce",
  update = function(progress, rawProgress)
    widget.x = 5 + (30 * progress)  -- Uses easing
    -- rawProgress is useful for calculations that need linear progression
  end
})
```
