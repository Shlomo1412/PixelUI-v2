# PixelUI.TabControl

*Extends: PixelUI.Widget*

A tabbed navigation widget with an optional body renderer. Renders a strip of selectable tabs and a content area beneath them.

## Properties

| Name | Type | Description |
|------|------|-------------|
| tabs | `PixelUI.TabControlTab[]` | Active tabs in display order |
| selectedIndex | `integer` | Index of the currently selected tab (0 when none available) |
| tabSpacing | `integer` | Spacing in characters between adjacent tabs |
| tabPadding | `integer` | Horizontal padding applied inside tab labels |
| tabHeight | `integer` | Height of the tab strip in characters |
| tabBg | `PixelUI.Color` | Background color for inactive tabs |
| tabFg | `PixelUI.Color` | Foreground color for inactive tabs |
| activeTabBg | `PixelUI.Color` | Background color for the active tab |
| activeTabFg | `PixelUI.Color` | Foreground color for the active tab |
| hoverTabBg | `PixelUI.Color` | Background color for hovered tabs |
| hoverTabFg | `PixelUI.Color` | Foreground color for hovered tabs |
| disabledTabFg | `PixelUI.Color` | Foreground color for disabled tabs |
| bodyBg | `PixelUI.Color` | Background color for the body area |
| bodyFg | `PixelUI.Color` | Foreground color for the body area |
| tabCloseButton | `{` |  |
| tabIndicatorChar | `string?` | Glyph rendered as a prefix for the active tab |
| tabIndicatorSpacing | `integer` | Horizontal spacing that follows the indicator glyph |
| onSelect | `fun(self:PixelUI.TabControl,` |  |
| onCloseTab | `fun(self:PixelUI.TabControl,` |  |
| bodyRenderer | `PixelUI.TabControlRenderer?` | Optional custom renderer for the content area |
| emptyText | `string?` | Message displayed when no tabs are available |

## Methods

### new

```lua
new()
```

### _normalizeTabEntry

```lua
_normalizeTabEntry()
```

### _normalizeTabs

```lua
_normalizeTabs()
```

### _findFirstEnabled

```lua
_findFirstEnabled()
```

### _resolveSelectableIndex

```lua
_resolveSelectableIndex()
```

### _normalizeSelection

```lua
_normalizeSelection()
```

### setTabs

```lua
setTabs()
```

### getTabs

```lua
getTabs()
```

### addTab

```lua
addTab()
```

### removeTab

```lua
removeTab()
```

### setTabEnabled

```lua
setTabEnabled()
```

### setTabLabel

```lua
setTabLabel()
```

### selectTabById

```lua
selectTabById()
```

### getSelectedIndex

```lua
getSelectedIndex()
```

### getSelectedTab

```lua
getSelectedTab()
```

### setSelectedIndex

```lua
setSelectedIndex()
```

### setOnSelect

```lua
setOnSelect()
```

### setOnCloseTab

```lua
setOnCloseTab()
```

### setBodyRenderer

```lua
setBodyRenderer()
```

### setEmptyText

```lua
setEmptyText()
```

### setTabCloseButton

```lua
setTabCloseButton()
```

### setTabIndicator

```lua
setTabIndicator()
```

### setTabClosable

```lua
setTabClosable()
```

### setAutoShrink

```lua
setAutoShrink()
```

### _invalidateLayout

```lua
_invalidateLayout()
```

### _ensureScrollIndexValid

```lua
_ensureScrollIndexValid()
```

### _isPointInTabStrip

```lua
_isPointInTabStrip()
```

### _adjustScroll

```lua
_adjustScroll()
```

### _notifySelect

```lua
_notifySelect()
```

### _emitSelect

```lua
_emitSelect()
```

### _computeTabLayout

```lua
_computeTabLayout()
```

### _tabIndexFromPoint

```lua
_tabIndexFromPoint()
```

### _hitTestTabArea

```lua
_hitTestTabArea()
```

### _canCloseTab

```lua
_canCloseTab()
```

### _tryCloseTab

```lua
_tryCloseTab()
```

### _moveSelection

```lua
_moveSelection()
```

### _renderBody

```lua
_renderBody()
```

### onFocusChanged

```lua
onFocusChanged()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple tab control
local tabs = app:tabcontrol({
    x = 2, y = 2,
    width = 40, height = 12
})

tabs:addTab({ id = "home", label = "Home" })
tabs:addTab({ id = "settings", label = "Settings" })
tabs:addTab({ id = "about", label = "About" })

app.root:addChild(tabs)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Tab control with dynamic content and styling
local tabs = app:tabcontrol({
    x = 2, y = 2,
    width = 45, height = 15,
    tabBg = colors.gray,
    tabFg = colors.white,
    selectedTabBg = colors.blue,
    selectedTabFg = colors.white,
    tabSpacing = 1,
    tabPadding = 2,
    onSelect = function(self, tabId, index)
        -- Handle tab selection
    end
})

-- Add tabs with custom content renderers
local homeTab = tabs:addTab({
    id = "home",
    label = "Home",
    closable = false
})

local settingsTab = tabs:addTab({
    id = "settings",
    label = "Settings",
    closable = true,
    onClose = function(tab)
        -- Confirm before closing
        return true
    end
})

-- Get tab body frame for adding content
local homeBody = tabs:getTabBody("home")
if homeBody then
    homeBody:addChild(app:label({
        x = 2, y = 2,
        text = "Welcome to the Home tab!"
    }))
end

app.root:addChild(tabs)

app:run()
```

</details>

