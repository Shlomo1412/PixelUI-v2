# Types and Utilities

Type definitions and utility types used in PixelUI.

## PixelUI.TreeNode

| Name | Type | Description |
|------|------|-------------|
| label | `string` |  |
| data | `any` |  |
| children | `PixelUI.TreeNode[]` |  |
| expanded | `boolean` |  |

## PixelUI.TableColumn

| Name | Type | Description |
|------|------|-------------|
| id | `string` |  |
| title | `string` |  |
| key | `string?` |  |
| accessor | `fun(row:any):any` |  |
| width | `integer?` |  |
| align | `"left"\|"center"\|"right"?` |  |
| sortable | `boolean?` |  |
| format | `fun(value:any,` |  |
| comparator | `fun(a:any,` |  |

## PixelUI.ThreadHandle

| Name | Type | Description |
|------|------|-------------|
| app | `PixelUI.App` |  |
| getId | `fun(self:PixelUI.ThreadHandle):integer` |  |
| getName | `fun(self:PixelUI.ThreadHandle):string` |  |
| setName | `fun(self:PixelUI.ThreadHandle,` |  |
| getStatus | `fun(self:PixelUI.ThreadHandle):PixelUI.ThreadStatus` |  |
| isRunning | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| isFinished | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| cancel | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| isCancelled | `fun(self:PixelUI.ThreadHandle):boolean` |  |
| getResult | `fun(self:PixelUI.ThreadHandle):...` |  |
| getResults | `fun(self:PixelUI.ThreadHandle):any[]?` |  |
| getError | `fun(self:PixelUI.ThreadHandle):any` |  |
| setMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getMetadata | `fun(self:PixelUI.ThreadHandle,` |  |
| getAllMetadata | `fun(self:PixelUI.ThreadHandle):table&lt;string,` |  |
| onStatusChange | `fun(self:PixelUI.ThreadHandle,` |  |
| onMetadataChange | `fun(self:PixelUI.ThreadHandle,` |  |

## PixelUI.ThreadContext

| Name | Type | Description |
|------|------|-------------|
| sleep | `fun(self:PixelUI.ThreadContext,` |  |
| yield | `fun(self:PixelUI.ThreadContext)` |  |
| checkCancelled | `fun(self:PixelUI.ThreadContext)` |  |
| isCancelled | `fun(self:PixelUI.ThreadContext):boolean` |  |
| setMetadata | `fun(self:PixelUI.ThreadContext,` |  |
| setStatus | `fun(self:PixelUI.ThreadContext,` |  |
| setDetail | `fun(self:PixelUI.ThreadContext,` |  |
| setProgress | `fun(self:PixelUI.ThreadContext,` |  |
| getHandle | `fun(self:PixelUI.ThreadContext):PixelUI.ThreadHandle` |  |

## PixelUI.AnimationHandle

| Name | Type | Description |
|------|------|-------------|
| cancel | `fun(self:PixelUI.AnimationHandle)` |  |

## Type Aliases

| Name | Type |
|------|------|
| PixelUI.Color | `integer` |
| ccTweaked.colors.color | `integer` |
| PixelUI.ThreadStatus | `"running"\|"completed"\|"error"\|"cancelled"` |
| PixelUI.WidgetConfig | `table` |

