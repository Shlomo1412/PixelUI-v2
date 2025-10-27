# PixelUI.ThreadHandle

## Fields

### app

- **Type:** `PixelUI.App`

### getId

- **Type:** `fun(self:PixelUI.ThreadHandle):integer`

### getName

- **Type:** `fun(self:PixelUI.ThreadHandle):string`

### setName

- **Type:** `fun(self:PixelUI.ThreadHandle, name:string)`

### getStatus

- **Type:** `fun(self:PixelUI.ThreadHandle):PixelUI.ThreadStatus`

### isRunning

- **Type:** `fun(self:PixelUI.ThreadHandle):boolean`

### isFinished

- **Type:** `fun(self:PixelUI.ThreadHandle):boolean`

### cancel

- **Type:** `fun(self:PixelUI.ThreadHandle):boolean`

### isCancelled

- **Type:** `fun(self:PixelUI.ThreadHandle):boolean`

### getResult

- **Type:** `fun(self:PixelUI.ThreadHandle):...`

### getResults

- **Type:** `fun(self:PixelUI.ThreadHandle):any[]?`

### getError

- **Type:** `fun(self:PixelUI.ThreadHandle):any`

### setMetadata

- **Type:** `fun(self:PixelUI.ThreadHandle, key:string, value:any)`

### getMetadata

- **Type:** `fun(self:PixelUI.ThreadHandle, key:string):any`

### getAllMetadata

- **Type:** `fun(self:PixelUI.ThreadHandle):table<string, any>`

### onStatusChange

- **Type:** `fun(self:PixelUI.ThreadHandle, callback:fun(handle:PixelUI.ThreadHandle, status:PixelUI.ThreadStatus))`

### onMetadataChange

- **Type:** `fun(self:PixelUI.ThreadHandle, callback:fun(handle:PixelUI.ThreadHandle, key:string, value:any))`

