# Types and Utilities

Type definitions and utility types used in PixelUI.

## PixelUI.TreeNode

A tree node representing an item in a TreeView. Can have children nodes for hierarchical structures.

| Name | Type | Description |
|------|------|-------------|
| label | `string` | Display text for the node |
| data | `any` | Custom data associated with the node |
| children | `PixelUI.TreeNode[]` | Child nodes |
| expanded | `boolean` | Whether the node is expanded to show children |

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
| PixelUI.ThreadStatus | `"running"\|"completed"\|"error"\|"cancelled"` |
| PixelUI.WidgetConfig | `table` |

