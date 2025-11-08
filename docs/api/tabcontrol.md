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
| onSelect | `fun(self:PixelUI.TabControl,` |  |
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

### setBodyRenderer

```lua
setBodyRenderer()
```

### setEmptyText

```lua
setEmptyText()
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

