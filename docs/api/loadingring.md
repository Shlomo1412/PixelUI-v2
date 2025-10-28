# PixelUI.LoadingRing

*Extends: PixelUI.Widget*

An animated loading ring indicator widget. Displays a rotating segmented ring for loading states.

## Properties

| Name | Type | Description |
|------|------|-------------|
| segmentCount | `integer` | Number of segments in the ring |
| thickness | `integer` | Thickness of the ring in pixels |
| color | `PixelUI.Color` | Primary color of the ring |
| secondaryColor | `PixelUI.Color?` | Optional secondary color for gradient effect |
| trailColor | `PixelUI.Color?` | Color for the trailing segments |
| tertiaryColor | `PixelUI.Color?` | Optional tertiary color |
| speed | `number` | Rotation speed multiplier |
| direction | `integer` | Rotation direction (1 or -1) |
| radiusPixels | `integer?` | Radius in pixels (auto-calculated if not set) |
| trailPalette | `PixelUI.Color[]?` | Array of colors for trail gradient |
| fadeSteps | `integer` | Number of fade steps for the trail |
| autoStart | `boolean?` | Whether to start animating automatically |

