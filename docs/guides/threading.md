# Threading

PixelUI v2 provides a powerful threading system for running background tasks without blocking the UI.

## Basic Threading

Spawn a background thread using `app:spawnThread()`:

```lua
local handle = app:spawnThread(function(ctx)
  -- This runs in the background
  for i = 1, 100 do
    ctx:setProgress(i / 100)
    ctx:setStatus("Processing item " .. i)
    ctx:sleep(0.1)
    
    -- Check if cancelled
    ctx:checkCancelled()
  end
  
  return "Task complete!"
end, {
  name = "Background Task"
})
```

## Thread Context

The thread function receives a context object (`ctx`) with these methods:

| Method | Description |
|--------|-------------|
| `ctx:sleep(seconds)` | Sleep for specified seconds |
| `ctx:yield()` | Yield control to other threads |
| `ctx:checkCancelled()` | Throws error if thread was cancelled |
| `ctx:isCancelled()` | Returns true if cancelled |
| `ctx:setStatus(text)` | Set status text |
| `ctx:setDetail(text)` | Set detail text |
| `ctx:setProgress(value)` | Set progress (0-1) |
| `ctx:setMetadata(key, value)` | Set custom metadata |
| `ctx:getHandle()` | Get thread handle |

## Thread Handle

The handle returned by `spawnThread()` provides control over the thread:

```lua
local handle = app:spawnThread(function(ctx)
  -- Background work
end)

-- Check status
print(handle:getStatus())  -- "running", "completed", "error", or "cancelled"
print(handle:isRunning())
print(handle:isFinished())

-- Get thread info
print(handle:getName())
handle:setName("New Name")

-- Cancel thread
handle:cancel()

-- Get results (blocks until complete)
local result = handle:getResult()

-- Get metadata
local progress = handle:getMetadata("progress")
local allData = handle:getAllMetadata()
```

## Progress Reporting

Report progress from your background thread:

```lua
local progressBar = app:createProgressBar({
  x = 5,
  y = 10,
  width = 30,
  height = 3
})
root:addChild(progressBar)

local handle = app:spawnThread(function(ctx)
  for i = 1, 100 do
    -- Update progress
    ctx:setProgress(i / 100)
    ctx:setStatus("Step " .. i .. " of 100")
    
    -- Simulate work
    ctx:sleep(0.05)
  end
end, {
  name = "Work Task",
  onMetadata = function(h, key, value)
    if key == "progress" then
      progressBar:setValue(value)
    end
  end
})
```

## Error Handling

Handle errors in background threads:

```lua
local handle = app:spawnThread(function(ctx)
  error("Something went wrong!")
end)

-- Check for errors after completion
if handle:getStatus() == "error" then
  local err = handle:getError()
  print("Thread error:", err)
end
```

## Cancellation

Threads can be cancelled from the main thread:

```lua
local handle = app:spawnThread(function(ctx)
  for i = 1, 1000 do
    -- Check if cancelled
    if ctx:isCancelled() then
      return "Cancelled at step " .. i
    end
    
    ctx:sleep(0.1)
  end
end)

-- Cancel after 2 seconds
os.sleep(2)
handle:cancel()
```

Use `checkCancelled()` for automatic error on cancellation:

```lua
local handle = app:spawnThread(function(ctx)
  for i = 1, 1000 do
    ctx:checkCancelled()  -- Throws error if cancelled
    ctx:sleep(0.1)
  end
end)
```

## Complete Example

Here's a complete example with a progress bar and cancel button:

```lua
local pixelui = require("pixelui")
local app = pixelui.create()
local root = app:getRoot()

-- Create UI elements
local progressBar = app:createProgressBar({
  x = 2,
  y = 5,
  width = root.width - 3,
  height = 3,
  label = "Processing...",
  showPercent = true
})
root:addChild(progressBar)

local statusLabel = app:createLabel({
  x = 2,
  y = 9,
  width = root.width - 3,
  height = 1,
  text = "Idle"
})
root:addChild(statusLabel)

local startBtn = app:createButton({
  x = 2,
  y = 11,
  width = 15,
  height = 3,
  label = "Start Task",
  bg = colors.green,
  fg = colors.white
})
root:addChild(startBtn)

local cancelBtn = app:createButton({
  x = 18,
  y = 11,
  width = 15,
  height = 3,
  label = "Cancel",
  bg = colors.red,
  fg = colors.white,
  disabled = true
})
root:addChild(cancelBtn)

local currentHandle = nil

startBtn.onClick = function()
  startBtn.disabled = true
  cancelBtn.disabled = false
  progressBar:setValue(0)
  
  currentHandle = app:spawnThread(function(ctx)
    for i = 1, 100 do
      ctx:setProgress(i / 100)
      ctx:setStatus("Processing item " .. i)
      ctx:sleep(0.1)
      ctx:checkCancelled()
    end
    return "Complete!"
  end, {
    name = "Processing Task",
    onMetadata = function(h, key, value)
      if key == "progress" then
        progressBar:setValue(value)
      elseif key == "status" then
        statusLabel:setText(value)
      end
    end,
    onStatus = function(h, status)
      if status == "completed" then
        statusLabel:setText("Task completed!")
        startBtn.disabled = false
        cancelBtn.disabled = true
      elseif status == "cancelled" then
        statusLabel:setText("Task cancelled")
        startBtn.disabled = false
        cancelBtn.disabled = true
      elseif status == "error" then
        statusLabel:setText("Error: " .. tostring(h:getError()))
        startBtn.disabled = false
        cancelBtn.disabled = true
      end
    end
  })
end

cancelBtn.onClick = function()
  if currentHandle then
    currentHandle:cancel()
  end
end

app:run()
```

## Best Practices

1. **Always Check Cancellation** - Use `ctx:checkCancelled()` in loops
2. **Report Progress** - Keep the UI informed of task progress
3. **Handle Errors** - Wrap operations in pcall when necessary
4. **Sleep Regularly** - Call `ctx:sleep()` to prevent blocking
5. **Clean Up Resources** - Close files and connections properly
6. **Use Metadata** - Store custom data for UI updates

## Multiple Threads

You can run multiple threads simultaneously:

```lua
local thread1 = app:spawnThread(function(ctx)
  -- Task 1
end, { name = "Task 1" })

local thread2 = app:spawnThread(function(ctx)
  -- Task 2
end, { name = "Task 2" })

-- Get all threads
local threads = app:getThreads()
for _, handle in ipairs(threads) do
  print(handle:getName(), handle:getStatus())
end
```
