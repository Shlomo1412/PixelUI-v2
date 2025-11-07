# Configuration

Configuration options for PixelUI components.

## PixelUI.BorderConfig

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color?` | Border color |
| sides | `("top"\|"right"\|"bottom"\|"left")[]\|table&lt;string,boolean&gt;?` | Enabled sides |
| thickness | `integer?` | Pixel thickness of the border (defaults to 1) |

## PixelUI.AppOptions

| Name | Type | Description |
|------|------|-------------|
| window | `table?` | Target window; defaults to the current terminal |
| background | `PixelUI.Color?` | Root background color |
| rootBorder | `PixelUI.BorderConfig?` | Border applied to the root frame |
| animationInterval | `number?` | Animation tick interval in seconds (defaults to 0.05) |

## PixelUI.NormalizedBorderConfig

Internal normalized border configuration.

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color` | Border color |
| top | `boolean` | Show top border |
| right | `boolean` | Show right border |
| bottom | `boolean` | Show bottom border |
| left | `boolean` | Show left border |
| thickness | `integer` | Border thickness in pixels |

## PixelUI.ScrollbarConfig

| Name | Type | Description |
|------|------|-------------|
| enabled | `boolean?` | Whether the scrollbar is enabled |
| alwaysVisible | `boolean?` | Force rendering even when content fits |
| width | `integer?` | Width i n characters (defaults to 1) |
| trackColor | `PixelUI.Color?` | Track background color |
| thumbColor | `PixelUI.Color?` | Thumb color |
| arrowColor | `PixelUI.Color?` | Arrow glyph color |
| background | `PixelUI.Color?` | Fill color for unused areas |
| minThumbSize | `integer?` | Minimum thumb height in characters |

## PixelUI.NormalizedScrollbarConfig

| Name | Type | Description |
|------|------|-------------|
| percent | `number?` | Percentage (0-1) of the referenced metric |
| of | `string?` | Reference string such as "parent.width" |
| offset | `integer?` | Offset applied after evaluation |

## PixelUI.ConstraintConfig

| Name | Type | Description |
|------|------|-------------|
| minWidth | `integer?` | Minimum allowed width (in characters) |
| maxWidth | `integer?` | Maximum allowed width (in characters) |
| minHeight | `integer?` | Minimum allowed height (in characters) |
| maxHeight | `integer?` | Maximum allowed height (in characters) |
| width | `(number\|string\|PixelUI.DimensionConstraint\|boolean)?` | Explicit width rule |
| height | `(number\|string\|PixelUI.DimensionConstraint\|boolean)?` | Explicit height rule |
| widthPercent | `number?` | Width as a percentage (0-1 or 0-100) of the parent width |
| heightPercent | `number?` | Height as a percentage (0-1 or 0-100) of the parent height |
| centerX | `(boolean\|string\|PixelUI.AlignmentConstraint)?` | Horizontal alignment rule |
| centerY | `(boolean\|string\|PixelUI.AlignmentConstraint)?` | Vertical alignment rule |
| offsetX | `integer?` | X offset applied after alignment rules |
| offsetY | `integer?` | Y offset applied after alignment rules |

## PixelUI.NormalizedConstraintConfig

| Name | Type | Description |
|------|------|-------------|
| minWidth | `integer?` | Minimum allowed width (in characters) |
| maxWidth | `integer?` | Maximum allowed width (in characters) |
| minHeight | `integer?` | Minimum allowed height (in characters) |
| maxHeight | `integer?` | Maximum allowed height (in characters) |
| width | `table?` | Internal descriptor for width rules |
| height | `table?` | Internal descriptor for height rules |
| widthPercent | `number?` | Normalized width percentage (0-1) |
| heightPercent | `number?` | Normalized height percentage (0-1) |
| centerX | `table?` | Internal descriptor for horizontal alignment |
| centerY | `table?` | Internal descriptor for vertical alignment |
| offsetX | `integer?` | Horizontal offset applied after alignment |
| offsetY | `integer?` | Vertical offset applied after alignment |

## PixelUI.ThreadOptions

Configuration options for spawning a background thread.

| Name | Type | Description |
|------|------|-------------|
| name | `string?` | Display name for the thread |
| onStatus | `fun(handle:PixelUI.ThreadHandle,` |  |
| onMetadata | `fun(handle:PixelUI.ThreadHandle,` |  |

## PixelUI.AnimationOptions

Configuration options for creating an animation.

| Name | Type | Description |
|------|------|-------------|
| duration | `number?` | Duration in seconds (default: 1.0) |
| easing | `(fun(t:number):number)\|string?` | Easing function or name (default: "linear") |
| update | `fun(progress:number,` |  |
| onComplete | `fun(handle:PixelUI.AnimationHandle?)?` | Callback fired when animation completes |
| onCancel | `fun(handle:PixelUI.AnimationHandle?)?` | Callback fired when animation is cancelled |

