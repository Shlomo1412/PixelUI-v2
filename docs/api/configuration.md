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

| Name | Type | Description |
|------|------|-------------|
| color | `PixelUI.Color` |  |
| top | `boolean` |  |
| right | `boolean` |  |
| bottom | `boolean` |  |
| left | `boolean` |  |
| thickness | `integer` |  |

## PixelUI.ThreadOptions

| Name | Type | Description |
|------|------|-------------|
| name | `string?` |  |
| onStatus | `fun(handle:PixelUI.ThreadHandle,` |  |
| onMetadata | `fun(handle:PixelUI.ThreadHandle,` |  |

## PixelUI.AnimationOptions

| Name | Type | Description |
|------|------|-------------|
| duration | `number?` |  |
| easing | `(fun(t:number):number)\|string?` |  |
| update | `fun(progress:number,` |  |
| onComplete | `fun(handle:PixelUI.AnimationHandle?)?` |  |
| onCancel | `fun(handle:PixelUI.AnimationHandle?)?` |  |

