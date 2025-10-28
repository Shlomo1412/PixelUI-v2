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

