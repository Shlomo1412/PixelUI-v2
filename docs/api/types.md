# Types and Utilities

Type definitions and utility types used in PixelUI.

## PixelUI.DimensionConstraint

| Name | Type | Description |
|------|------|-------------|
| percent | `number?` | Percentage (0-1) of the referenced metric |
| of | `string?` | Reference string such as "parent.width" |
| offset | `integer?` | Offset applied after evaluation |

## PixelUI.AlignmentConstraint

| Name | Type | Description |
|------|------|-------------|
| reference | `string?` | Reference string such as "parent.centerX" |
| offset | `integer?` | Offset applied relative to the reference |

## PixelUI.FreeDrawContext

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` | Owning application instance |
| box | `ShrekBox` | Underlying ShrekBox instance |
| textLayer | `Layer` | Shared text layer used by PixelUI |
| pixelLayer | `Layer` | Shared pixel layer used by PixelUI |
| x | `integer` | Absolute X coordinate of the widget region |
| y | `integer` | Absolute Y coordinate of the widget region |
| width | `integer` | Width of the widget region |
| height | `integer` | Height of the widget region |
| write | `fun(x:integer,` |  |
| pixel | `fun(x:integer,` |  |
| fill | `fun(color:PixelUI.Color)` | Fill the region with a colour |

## PixelUI.TreeNode

A tree node representing an item in a TreeView. Can have children nodes for hierarchical structures.

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Display text for the node |
| data | `any` | Custom data associated with the node |
| children | `PixelUI.TreeNode[]` | Child nodes |
| expanded | `boolean` | Whether the node is expanded to show children |

## PixelUI.TabControlTab

| Name | Type | Description |
|------|------|-------------|
| id | `any?` | Optional identifier for the tab |
| label | `string` | Display label rendered inside the tab |
| value | `any?` | Optional value associated with the tab |
| content | `string\|PixelUI.TabControlRenderer?` | Optional string or renderer used for the body |
| contentRenderer | `PixelUI.TabControlRenderer?` | Tab-specific renderer that overrides the widget default |
| disabled | `boolean?` | When true the tab cannot be selected |
| tooltip | `string?` | Optional tooltip text (reserved for future use) |

## PixelUI.ContextMenu

A hierarchical context menu widget with optional submenus. Renders as a popup and supports keyboard navigation.

| Name | Type | Description |
|------|------|-------------|
| items | `PixelUI.ContextMenuEntry[]` | Normalized menu entries |
| menuBg | `PixelUI.Color` | Background color for menu panels |
| menuFg | `PixelUI.Color` | Foreground color for menu items |
| highlightBg | `PixelUI.Color` | Highlight background for the active item |
| highlightFg | `PixelUI.Color` | Highlight foreground for the active item |
| shortcutFg | `PixelUI.Color` | Foreground color for shortcut text |
| disabledFg | `PixelUI.Color` | Foreground color for disabled entries |
| separatorColor | `PixelUI.Color` | Separator line color |
| maxWidth | `integer` | Maximum width of a menu panel in characters |
| onSelect | `fun(self:PixelUI.ContextMenu,` |  |

## PixelUI.ContextMenuEntry

| Name | Type | Description |
|------|------|-------------|
| label | `string?` | Text label for menu row |
| shortcut | `string?` | Optional shortcut hint text |
| value | `any` | Arbitrary value passed through on selection |
| id | `any` | Optional identifier for the item |
| disabled | `boolean?` | When true the item cannot be activated |
| submenu | `PixelUI.ContextMenuEntry[]?` | Nested submenu entries |
| onSelect | `fun(menu:PixelUI.ContextMenu,` |  |
| separator | `boolean?` | Marks this entry as a separator row |

## PixelUI.ContextMenuItem

| Name | Type | Description |
|------|------|-------------|
| type | `"item"\|"separator"` |  |
| label | `string?` |  |
| shortcut | `string?` |  |
| value | `any` |  |
| id | `any` |  |
| disabled | `boolean` |  |
| submenu | `PixelUI.ContextMenuItem[]?` |  |
| action | `fun(menu:PixelUI.ContextMenu,` |  |
| data | `any` |  |

## PixelUI.TableColumn

A table column definition for the Table widget. Defines how data is accessed, displayed, and sorted.

| Name | Type | Description |
|------|------|-------------|
| id | `string` | Unique identifier for the column |
| title | `string` | Display title in the header |
| key | `string?` | Key to access data from row objects |
| accessor | `fun(row:any):any` | Function to extract cell value from row |
| width | `integer?` | Fixed width in characters (auto-sized if not set) |
| align | `"left"\|"center"\|"right"?` | Cell text alignment |
| sortable | `boolean?` | Whether this column can be sorted |
| format | `fun(value:any,` |  |
| comparator | `fun(a:any,` |  |

## PixelUI.ThreadHandle

Handle for controlling and monitoring a background thread. Provides methods to check status, cancel execution, and retrieve results.

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` | The application instance |
| getId | `fun(self:PixelUI.ThreadHandle):integer` | Get thread ID |
| getName | `fun(self:PixelUI.ThreadHandle):string` | Get thread name |
| setName | `fun(self:PixelUI.ThreadHandle,` |  |
| getStatus | `fun(self:PixelUI.ThreadHandle):PixelUI.ThreadStatus` | Get current status |
| isRunning | `fun(self:PixelUI.ThreadHandle):boolean` | Check if thread is running |
| isFinished | `fun(self:PixelUI.ThreadHandle):boolean` | Check if thread has finished |
| cancel | `fun(self:PixelUI.ThreadHandle):boolean` | Request thread cancellation |
| isCancelled | `fun(self:PixelUI.ThreadHandle):boolean` | Check if thread was cancelled |
| getResult | `fun(self:PixelUI.ThreadHandle):...` | Get thread results (blocks until complete) |
| getResults | `fun(self:PixelUI.ThreadHandle):any[]?` | Get results as array |
| getError | `fun(self:PixelUI.ThreadHandle):any` | Get error if thread failed |
| setMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getAllMetadata | `fun(self:PixelUI.ThreadHandle):table&lt;string,` |  |
| onStatusChange | `fun(self:PixelUI.ThreadHandle,` |  |
| onMetadataChange | `fun(self:PixelUI.ThreadHandle,` |  |

## PixelUI.ThreadContext

Context object provided to background thread functions. Provides utilities for sleeping, yielding, and reporting progress.

| Name | Type | Description |
|------|------|-------------|
| sleep | `fun(self:PixelUI.ThreadContext,` |  |
| yield | `fun(self:PixelUI.ThreadContext)` | Yield control to other threads |
| checkCancelled | `fun(self:PixelUI.ThreadContext)` | Throw error if cancelled |
| isCancelled | `fun(self:PixelUI.ThreadContext):boolean` | Check if cancelled |
| setMetadata | `fun(self:PixelUI.ThreadContext,` |  |
| setStatus | `fun(self:PixelUI.ThreadContext,` |  |
| setDetail | `fun(self:PixelUI.ThreadContext,` |  |
| setProgress | `fun(self:PixelUI.ThreadContext,` |  |
| getHandle | `fun(self:PixelUI.ThreadContext):PixelUI.ThreadHandle` | Get thread handle |

## PixelUI.AnimationHandle

Handle for controlling a running animation.

| Name | Type | Description |
|------|------|-------------|
| cancel | `fun(self:PixelUI.AnimationHandle)` | Cancel the animation |

## Type Aliases

| Name | Type |
|------|------|
| PixelUI.Color | `integer` |
| ccTweaked.colors.color | `integer` |
| PixelUI.TabControlRenderer | `fun(self:PixelUI.TabControl, tab:PixelUI.TabControlTab?, textLayer:Layer, pixelLayer:Layer, area:{ x:integer, y:integer, width:integer, height:integer })` |
| PixelUI.ThreadStatus | `"running"\|"completed"\|"error"\|"cancelled"` |
| PixelUI.WidgetConfig | `table` |

