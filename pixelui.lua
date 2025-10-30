local term = assert(rawget(_G, "term"), "term API unavailable")
local colors = assert(rawget(_G, "colors"), "colors API unavailable")
local osLib = assert(rawget(_G, "os"), "os API unavailable")
local pullEvent = assert(osLib.pullEvent, "os.pullEvent unavailable")
local windowAPI = assert(rawget(_G, "window"), "window API unavailable")
local keys = assert(rawget(_G, "keys"), "keys API unavailable")
local table_pack = table.pack or function(...)
	return { n = select("#", ...), ... }
end
local table_unpack = assert(table.unpack, "table.unpack unavailable")
local expect = require("cc.expect").expect
local shrekbox = require("shrekbox")

---@alias PixelUI.Color integer
---@alias ccTweaked.colors.color integer

---@class PixelUI.BorderConfig
---@field color PixelUI.Color? # Border color
---@field sides ("top"|"right"|"bottom"|"left")[]|table<string,boolean>? # Enabled sides
---@field thickness integer? # Pixel thickness of the border (defaults to 1)

---@class PixelUI.AppOptions
---@field window table? # Target window; defaults to the current terminal
---@field background PixelUI.Color? # Root background color
---@field rootBorder PixelUI.BorderConfig? # Border applied to the root frame
---@field animationInterval number? # Animation tick interval in seconds (defaults to 0.05)

--- Base class for all UI widgets.
--- Provides common properties and behavior for positioning, sizing, styling, and event handling.
---@class PixelUI.Widget
---@field app PixelUI.App # The application instance that owns this widget
---@field parent PixelUI.Frame? # The parent frame containing this widget
---@field x integer # X position relative to parent
---@field y integer # Y position relative to parent
---@field width integer # Width in characters
---@field height integer # Height in characters
---@field bg PixelUI.Color # Background color
---@field fg PixelUI.Color # Foreground/text color
---@field _orderIndex integer? # Internal ordering index
---@field visible boolean # Whether the widget is visible
---@field z number # Z-order for layering (higher values appear on top)
---@field border PixelUI.NormalizedBorderConfig? # Border configuration
---@field id string? # Optional unique identifier
---@field focusable boolean # Whether the widget can receive focus
---@field draw fun(self:PixelUI.Widget, textLayer:Layer, pixelLayer:Layer) # Render the widget
---@field handleEvent fun(self:PixelUI.Widget, event:string, ...:any):boolean # Handle input events
---@field setFocused fun(self:PixelUI.Widget, focused:boolean) # Set focus state
---@field isFocused fun(self:PixelUI.Widget):boolean # Check if widget has focus

--- Internal normalized border configuration.
---@class PixelUI.NormalizedBorderConfig
---@field color PixelUI.Color # Border color
---@field top boolean # Show top border
---@field right boolean # Show right border
---@field bottom boolean # Show bottom border
---@field left boolean # Show left border
---@field thickness integer # Border thickness in pixels

---@class PixelUI.ScrollbarConfig
---@field enabled boolean? # Whether the scrollbar is enabled
---@field alwaysVisible boolean? # Force rendering even when content fits
---@field width integer? # Width in characters (defaults to 1)
---@field trackColor PixelUI.Color? # Track background color
---@field thumbColor PixelUI.Color? # Thumb color
---@field arrowColor PixelUI.Color? # Arrow glyph color
---@field background PixelUI.Color? # Fill color for unused areas
---@field minThumbSize integer? # Minimum thumb height in characters

---@class PixelUI.NormalizedScrollbarConfig
---@field enabled boolean # Whether the scrollbar is enabled
---@field alwaysVisible boolean # Whether the scrollbar renders when content fits
---@field width integer # Width in characters
---@field trackColor PixelUI.Color # Track background color
---@field thumbColor PixelUI.Color # Thumb color
---@field arrowColor PixelUI.Color # Arrow glyph color
---@field background PixelUI.Color # Fill color for unused areas
---@field minThumbSize integer # Minimum thumb height in characters

--- Main application class managing the UI and event loop.
--- Handles rendering, events, animations, and threading.
---@class PixelUI.App
---@field window table # The terminal window object
---@field box ShrekBox # ShrekBox rendering instance
---@field layer Layer # Text rendering layer
---@field pixelLayer Layer # Pixel rendering layer
---@field background PixelUI.Color # Root background color
---@field root PixelUI.Frame # Root frame container
---@field running boolean # Whether the application is running
---@field _autoWindow boolean # Whether window was auto-created
---@field _parentTerminal table? # Original terminal before window creation
---@field _focusWidget PixelUI.Widget? # Currently focused widget
---@field _popupWidgets PixelUI.Widget[] # Active popup widgets
---@field _popupLookup table<PixelUI.Widget, boolean> # Popup lookup table
---@field _animations table # Active animations
---@field _animationTimer integer? # Animation timer ID
---@field _animationInterval number # Animation update interval
---@field _radioGroups table<string, { buttons: PixelUI.RadioButton[], lookup: table<PixelUI.RadioButton, boolean>, selected: PixelUI.RadioButton? }> # Radio button groups

--- A container widget that can hold child widgets.
--- Serves as the base for layout organization and hierarchy.
---@class PixelUI.Frame : PixelUI.Widget
---@field private _children PixelUI.Widget[] # Child widgets
---@field private _orderCounter integer # Counter for child ordering
---@field title string? # Optional frame title

--- A clickable button widget with press effects and event callbacks.
--- Supports click, press, and release events with visual feedback.
---@class PixelUI.Button : PixelUI.Widget
---@field label string # The text displayed on the button
---@field onPress fun(self:PixelUI.Button, button:integer, x:integer, y:integer)? # Callback fired when the button is pressed
---@field onRelease fun(self:PixelUI.Button, button:integer, x:integer, y:integer)? # Callback fired when the button is released
---@field onClick fun(self:PixelUI.Button, button:integer, x:integer, y:integer)? # Callback fired when the button is clicked (press + release)
---@field clickEffect boolean # Whether to show a visual press effect
---@field private _pressed boolean

--- A text display widget with support for wrapping and alignment.
--- Can display static or dynamic text with customizable alignment options.
---@class PixelUI.Label : PixelUI.Widget
---@field text string # The text content to display
---@field wrap boolean # Whether to wrap text to fit within the widget bounds
---@field align "left"|"center"|"right" # Horizontal text alignment
---@field verticalAlign "top"|"middle"|"bottom" # Vertical text alignment

--- A checkbox widget with support for checked, unchecked, and indeterminate states.
--- Provides visual feedback and change callbacks.
---@class PixelUI.CheckBox : PixelUI.Widget
---@field label string # Label text displayed next to the checkbox
---@field checked boolean # Whether the checkbox is checked
---@field indeterminate boolean # Whether the checkbox is in an indeterminate state
---@field allowIndeterminate boolean # Whether the indeterminate state is allowed
---@field focusBg PixelUI.Color? # Background color when focused
---@field focusFg PixelUI.Color? # Foreground color when focused
---@field onChange fun(self:PixelUI.CheckBox, checked:boolean, indeterminate:boolean)? # Callback fired when state changes

--- A toggle switch widget with on/off states and customizable appearance.
--- Features a sliding thumb animation and optional labels.
---@class PixelUI.Toggle : PixelUI.Widget
---@field value boolean # Current toggle state (true = on, false = off)
---@field labelOn string # Label text when toggle is on
---@field labelOff string # Label text when toggle is off
---@field trackColorOn PixelUI.Color # Track color when on
---@field trackColorOff PixelUI.Color # Track color when off
---@field thumbColor PixelUI.Color # Color of the sliding thumb
---@field onLabelColor PixelUI.Color? # Text color for "on" label
---@field offLabelColor PixelUI.Color? # Text color for "off" label
---@field focusBg PixelUI.Color? # Background color when focused
---@field focusFg PixelUI.Color? # Foreground color when focused
---@field showLabel boolean # Whether to show the label text
---@field disabled boolean # Whether the toggle is disabled
---@field onChange fun(self:PixelUI.Toggle, value:boolean)? # Callback fired when value changes

--- A data visualization widget supporting bar and line charts.
--- Displays numeric data with optional labels and interactive selection.
---@class PixelUI.Chart : PixelUI.Widget
---@field data number[] # Array of numeric values to display
---@field labels string[] # Labels for each data point
---@field chartType "bar"|"line" # Type of chart visualization
---@field minValue number? # Minimum value for the Y axis (auto-calculated if not set)
---@field maxValue number? # Maximum value for the Y axis (auto-calculated if not set)
---@field showAxis boolean # Whether to show axis lines
---@field showLabels boolean # Whether to show data point labels
---@field placeholder string? # Text to show when no data is available
---@field barColor PixelUI.Color # Color for bars or line
---@field highlightColor PixelUI.Color # Color for highlighted/selected elements
---@field axisColor PixelUI.Color # Color for axis lines
---@field lineColor PixelUI.Color # Color for line charts
---@field rangePadding number # Padding percentage for the value range
---@field selectedIndex integer? # Currently selected data point index
---@field onSelect fun(self:PixelUI.Chart, index:integer?, value:number?)? # Callback fired when a data point is selected

--- A progress indicator widget showing completion status.
--- Supports determinate and indeterminate modes with optional labels.
---@class PixelUI.ProgressBar : PixelUI.Widget
---@field value number # Current progress value
---@field min number # Minimum progress value
---@field max number # Maximum progress value
---@field indeterminate boolean # Whether to show an animated indeterminate state
---@field label string? # Optional label text to display
---@field showPercent boolean # Whether to show percentage text
---@field trackColor PixelUI.Color # Background track color
---@field fillColor PixelUI.Color # Foreground fill color
---@field textColor PixelUI.Color # Color for text (label and percentage)

--- A notification toast widget for displaying temporary messages.
--- Supports different severity levels and auto-hide functionality.
---@class PixelUI.NotificationToast : PixelUI.Widget
---@field title string? # Optional title text
---@field message string # The notification message content
---@field severity string # Severity level (e.g., "info", "success", "warning", "error")
---@field autoHide boolean # Whether to automatically hide after duration
---@field duration number # Duration in seconds before auto-hiding
---@field dismissOnClick boolean # Whether clicking dismisses the notification

--- An animated loading ring indicator widget.
--- Displays a rotating segmented ring for loading states.
---@class PixelUI.LoadingRing : PixelUI.Widget
---@field segmentCount integer # Number of segments in the ring
---@field thickness integer # Thickness of the ring in pixels
---@field color PixelUI.Color # Primary color of the ring
---@field secondaryColor PixelUI.Color? # Optional secondary color for gradient effect
---@field trailColor PixelUI.Color? # Color for the trailing segments
---@field tertiaryColor PixelUI.Color? # Optional tertiary color
---@field speed number # Rotation speed multiplier
---@field direction integer # Rotation direction (1 or -1)
---@field radiusPixels integer? # Radius in pixels (auto-calculated if not set)
---@field trailPalette PixelUI.Color[]? # Array of colors for trail gradient
---@field fadeSteps integer # Number of fade steps for the trail
---@field autoStart boolean? # Whether to start animating automatically

--- A slider widget for selecting numeric values within a range.
--- Supports single value or range selection mode.
---@class PixelUI.Slider : PixelUI.Widget
---@field min number # Minimum value
---@field max number # Maximum value
---@field value number # Current value (single mode)
---@field range boolean # Whether in range selection mode
---@field lowerValue number? # Lower bound value (range mode)
---@field upperValue number? # Upper bound value (range mode)
---@field step number # Step increment for value changes
---@field showValue boolean # Whether to display the current value
---@field onChange fun(self:PixelUI.Slider, ...:number)? # Callback fired when value changes
---@field formatValue fun(self:PixelUI.Slider, ...:number):string? # Custom value formatter function

--- A tree node representing an item in a TreeView.
--- Can have children nodes for hierarchical structures.
---@class PixelUI.TreeNode
---@field label string # Display text for the node
---@field data any # Custom data associated with the node
---@field children PixelUI.TreeNode[] # Child nodes
---@field expanded boolean # Whether the node is expanded to show children

--- A hierarchical tree view widget for displaying nested data.
--- Supports expand/collapse and selection of nodes.
---@class PixelUI.TreeView : PixelUI.Widget
---@field indentWidth integer # Width of indentation per level
---@field highlightBg PixelUI.Color # Background color for selected node
---@field highlightFg PixelUI.Color # Foreground color for selected node
---@field placeholder string? # Text shown when tree is empty
---@field onSelect fun(self:PixelUI.TreeView, node:PixelUI.TreeNode?, index:integer)? # Callback fired when node is selected
---@field onToggle fun(self:PixelUI.TreeView, node:PixelUI.TreeNode, expanded:boolean)? # Callback fired when node is expanded/collapsed
---@field scrollbar PixelUI.ScrollbarConfig? # Optional scrollbar configuration

--- A scrollable list widget for displaying and selecting items.
--- Supports keyboard and mouse navigation.
---@class PixelUI.List : PixelUI.Widget
---@field items string[] # Array of items to display
---@field selectedIndex integer # Index of currently selected item
---@field highlightBg PixelUI.Color # Background color for selected item
---@field highlightFg PixelUI.Color # Foreground color for selected item
---@field placeholder string? # Text shown when list is empty
---@field onSelect fun(self:PixelUI.List, item:string?, index:integer)? # Callback fired when selection changes
---@field scrollbar PixelUI.ScrollbarConfig? # Optional scrollbar configuration

--- A radio button widget for exclusive selection within a group.
--- Only one radio button in a group can be selected at a time.
---@class PixelUI.RadioButton : PixelUI.Widget
---@field label string # Label text displayed next to the radio button
---@field value any # Value associated with this radio button
---@field group string? # Group identifier for exclusive selection
---@field selected boolean # Whether this radio button is selected
---@field focusBg PixelUI.Color? # Background color when focused
---@field focusFg PixelUI.Color? # Foreground color when focused
---@field onChange fun(self:PixelUI.RadioButton, selected:boolean, value:any)? # Callback fired when selection changes

--- A dropdown selection widget (combo box) for choosing from a list of options.
--- Opens a dropdown menu when clicked.
---@class PixelUI.ComboBox : PixelUI.Widget
---@field items string[] # Array of selectable items
---@field selectedIndex integer # Index of currently selected item
---@field dropdownBg PixelUI.Color # Background color for dropdown menu
---@field dropdownFg PixelUI.Color # Foreground color for dropdown menu
---@field highlightBg PixelUI.Color # Background color for highlighted item
---@field highlightFg PixelUI.Color # Foreground color for highlighted item
---@field placeholder string? # Text shown when no item is selected
---@field onChange fun(self:PixelUI.ComboBox, item:string?, index:integer)? # Callback fired when selection changes

--- A text input widget supporting single and multi-line input.
--- Features syntax highlighting, autocomplete, and find/replace.
---@class PixelUI.TextBox : PixelUI.Widget
---@field text string # Current text content
---@field placeholder string # Placeholder text shown when empty
---@field onChange fun(self:PixelUI.TextBox, value:string)? # Callback fired when text changes
---@field maxLength integer? # Maximum allowed text length
---@field multiline boolean # Whether to support multiple lines
---@field autocomplete string[]? # Array of autocomplete suggestions
---@field syntax table? # Syntax highlighting configuration
---@field scrollbar PixelUI.ScrollbarConfig? # Optional scrollbar configuration

--- A table column definition for the Table widget.
--- Defines how data is accessed, displayed, and sorted.
---@class PixelUI.TableColumn
---@field id string # Unique identifier for the column
---@field title string # Display title in the header
---@field key string? # Key to access data from row objects
---@field accessor fun(row:any):any # Function to extract cell value from row
---@field width integer? # Fixed width in characters (auto-sized if not set)
---@field align "left"|"center"|"right"? # Cell text alignment
---@field sortable boolean? # Whether this column can be sorted
---@field format fun(value:any, row:any, column:PixelUI.TableColumn):string? # Custom cell formatter
---@field comparator fun(a:any, b:any, aRow:any, bRow:any, column:PixelUI.TableColumn):number? # Custom sort comparator

--- A data table widget with sorting and selection capabilities.
--- Displays tabular data with customizable columns and row selection.
---@class PixelUI.Table : PixelUI.Widget
---@field columns PixelUI.TableColumn[] # Array of column definitions
---@field data table[] # Array of row data objects
---@field sortColumn string? # ID of currently sorted column
---@field sortDirection "asc"|"desc" # Sort direction (ascending or descending)
---@field allowRowSelection boolean # Whether rows can be selected
---@field highlightBg PixelUI.Color # Background color for selected row
---@field highlightFg PixelUI.Color # Foreground color for selected row
---@field placeholder string # Text shown when table is empty
---@field onSelect fun(self:PixelUI.Table, row:any?, index:integer)? # Callback fired when row is selected
---@field onSort fun(self:PixelUI.Table, columnId:string, direction:"asc"|"desc")? # Callback fired when sort changes
---@field scrollbar PixelUI.ScrollbarConfig? # Optional scrollbar configuration

--- Status of a background thread.
---@alias PixelUI.ThreadStatus "running"|"completed"|"error"|"cancelled"

--- Configuration options for spawning a background thread.
---@class PixelUI.ThreadOptions
---@field name string? # Display name for the thread
---@field onStatus fun(handle:PixelUI.ThreadHandle, status:PixelUI.ThreadStatus)? # Callback fired on status changes
---@field onMetadata fun(handle:PixelUI.ThreadHandle, key:string, value:any)? # Callback fired on metadata changes

--- Handle for controlling and monitoring a background thread.
--- Provides methods to check status, cancel execution, and retrieve results.
---@class PixelUI.ThreadHandle
---@field app PixelUI.App # The application instance
---@field getId fun(self:PixelUI.ThreadHandle):integer # Get thread ID
---@field getName fun(self:PixelUI.ThreadHandle):string # Get thread name
---@field setName fun(self:PixelUI.ThreadHandle, name:string) # Set thread name
---@field getStatus fun(self:PixelUI.ThreadHandle):PixelUI.ThreadStatus # Get current status
---@field isRunning fun(self:PixelUI.ThreadHandle):boolean # Check if thread is running
---@field isFinished fun(self:PixelUI.ThreadHandle):boolean # Check if thread has finished
---@field cancel fun(self:PixelUI.ThreadHandle):boolean # Request thread cancellation
---@field isCancelled fun(self:PixelUI.ThreadHandle):boolean # Check if thread was cancelled
---@field getResult fun(self:PixelUI.ThreadHandle):... # Get thread results (blocks until complete)
---@field getResults fun(self:PixelUI.ThreadHandle):any[]? # Get results as array
---@field getError fun(self:PixelUI.ThreadHandle):any # Get error if thread failed
---@field setMetadata fun(self:PixelUI.ThreadHandle, key:string, value:any) # Set metadata value
---@field getMetadata fun(self:PixelUI.ThreadHandle, key:string):any # Get metadata value
---@field getAllMetadata fun(self:PixelUI.ThreadHandle):table<string, any> # Get all metadata
---@field onStatusChange fun(self:PixelUI.ThreadHandle, callback:fun(handle:PixelUI.ThreadHandle, status:PixelUI.ThreadStatus)) # Register status change callback
---@field onMetadataChange fun(self:PixelUI.ThreadHandle, callback:fun(handle:PixelUI.ThreadHandle, key:string, value:any)) # Register metadata change callback

--- Context object provided to background thread functions.
--- Provides utilities for sleeping, yielding, and reporting progress.
---@class PixelUI.ThreadContext
---@field sleep fun(self:PixelUI.ThreadContext, seconds:number|nil) # Sleep for specified seconds
---@field yield fun(self:PixelUI.ThreadContext) # Yield control to other threads
---@field checkCancelled fun(self:PixelUI.ThreadContext) # Throw error if cancelled
---@field isCancelled fun(self:PixelUI.ThreadContext):boolean # Check if cancelled
---@field setMetadata fun(self:PixelUI.ThreadContext, key:string, value:any) # Set metadata value
---@field setStatus fun(self:PixelUI.ThreadContext, text:string) # Set status text
---@field setDetail fun(self:PixelUI.ThreadContext, text:string) # Set detail text
---@field setProgress fun(self:PixelUI.ThreadContext, value:number) # Set progress value (0-1)
---@field getHandle fun(self:PixelUI.ThreadContext):PixelUI.ThreadHandle # Get thread handle

--- Configuration options for creating an animation.
---@class PixelUI.AnimationOptions
---@field duration number? # Duration in seconds (default: 1.0)
---@field easing (fun(t:number):number)|string? # Easing function or name (default: "linear")
---@field update fun(progress:number, rawProgress:number, handle:PixelUI.AnimationHandle?)? # Update callback (progress is eased, rawProgress is linear)
---@field onComplete fun(handle:PixelUI.AnimationHandle?)? # Callback fired when animation completes
---@field onCancel fun(handle:PixelUI.AnimationHandle?)? # Callback fired when animation is cancelled

--- Handle for controlling a running animation.
---@class PixelUI.AnimationHandle
---@field cancel fun(self:PixelUI.AnimationHandle) # Cancel the animation

---@alias PixelUI.WidgetConfig table


local pixelui = {
	version = "0.1.0"
}

local easings = {
	linear = function(t)
		return t
	end,
	easeInQuad = function(t)
		return t * t
	end,
	easeOutQuad = function(t)
		local inv = 1 - t
		return 1 - inv * inv
	end,
	easeInOutQuad = function(t)
		if t < 0.5 then
			return 2 * t * t
		end
		local inv = -2 * t + 2
		return 1 - (inv * inv) / 2
	end,
	easeOutCubic = function(t)
		local inv = 1 - t
		return 1 - inv * inv * inv
	end
}

local Widget = {}
Widget.__index = Widget

local Frame = {}
Frame.__index = Frame
setmetatable(Frame, { __index = Widget })

local Button = {}
Button.__index = Button
setmetatable(Button, { __index = Widget })

local Label = {}
Label.__index = Label
setmetatable(Label, { __index = Widget })

local CheckBox = {}
CheckBox.__index = CheckBox
setmetatable(CheckBox, { __index = Widget })

local Toggle = {}
Toggle.__index = Toggle
setmetatable(Toggle, { __index = Widget })

local ProgressBar = {}
ProgressBar.__index = ProgressBar
setmetatable(ProgressBar, { __index = Widget })

local Slider = {}
Slider.__index = Slider
setmetatable(Slider, { __index = Widget })

local ThreadHandle = {}
ThreadHandle.__index = ThreadHandle

local ThreadContext = {}
ThreadContext.__index = ThreadContext

local List = {}
List.__index = List
setmetatable(List, { __index = Widget })

local Table = {}
Table.__index = Table
setmetatable(Table, { __index = Widget })

local TreeView = {}
TreeView.__index = TreeView
setmetatable(TreeView, { __index = Widget })

local Chart = {}
Chart.__index = Chart
setmetatable(Chart, { __index = Widget })

local RadioButton = {}
RadioButton.__index = RadioButton
setmetatable(RadioButton, { __index = Widget })

local ComboBox = {}
ComboBox.__index = ComboBox
setmetatable(ComboBox, { __index = Widget })

local NotificationToast = {}
NotificationToast.__index = NotificationToast
setmetatable(NotificationToast, { __index = Widget })

local LoadingRing = {}
LoadingRing.__index = LoadingRing
setmetatable(LoadingRing, { __index = Widget })

local App = {}
App.__index = App

local borderSides = { "top", "right", "bottom", "left" }
local RADIO_DOT_CHAR = string.char(7)

local TOAST_DEFAULT_STYLES = {
	info = { bg = colors.blue, fg = colors.white, accent = colors.lightBlue, icon = "i" },
	success = { bg = colors.green, fg = colors.black, accent = colors.lime, icon = "+" },
	warning = { bg = colors.orange, fg = colors.black, accent = colors.yellow, icon = "!" },
	error = { bg = colors.red, fg = colors.white, accent = colors.white, icon = "x" }
}

local function normalize_toast_severity(severity)
	if severity == nil then
		return "info"
	end
	local value = tostring(severity):lower()
	if TOAST_DEFAULT_STYLES[value] then
		return value
	end
	return "info"
end


local function resolve_toast_padding(padding)
	if padding == nil then
		return 1, 1, 1, 1
	end
	if type(padding) == "number" then
		local value = math.max(0, math.floor(padding))
		return value, value, value, value
	end
	local left, right, top, bottom = 1, 1, 1, 1
	if type(padding) == "table" then
		local horizontal = padding.horizontal or padding.x
		local vertical = padding.vertical or padding.y
		if horizontal ~= nil then
			horizontal = math.max(0, math.floor(horizontal))
			left = horizontal
			right = horizontal
		end
		if vertical ~= nil then
			vertical = math.max(0, math.floor(vertical))
			top = vertical
			bottom = vertical
		end
		if padding.left ~= nil then
			left = math.max(0, math.floor(padding.left))
		end
		if padding.right ~= nil then
			right = math.max(0, math.floor(padding.right))
		end
		if padding.top ~= nil then
			top = math.max(0, math.floor(padding.top))
		end
		if padding.bottom ~= nil then
			bottom = math.max(0, math.floor(padding.bottom))
		end
	end
	return left, right, top, bottom
end

local function toast_wrap_line(line, width, out)
	if width <= 0 then
		out[#out + 1] = ""
		return
	end
	line = (line or ""):gsub("\r", "")
	if line == "" then
		out[#out + 1] = ""
		return
	end
	local remaining = line
	while #remaining > width do
		local segment = remaining:sub(1, width)
		local breakPos
		for index = width, 1, -1 do
			local ch = segment:sub(index, index)
			if ch:match("%s") then
				breakPos = index - 1
				break
			end
		end
		if breakPos and breakPos >= 1 then
			local chunk = remaining:sub(1, breakPos)
			chunk = chunk:gsub("%s+$", "")
			if chunk == "" then
				chunk = remaining:sub(1, width)
				breakPos = width
			end
			out[#out + 1] = chunk
			remaining = remaining:sub(breakPos + 1)
		else
			out[#out + 1] = segment
			remaining = remaining:sub(width + 1)
		end
		remaining = remaining:gsub("^%s+", "")
		if remaining == "" then
			break
		end
	end
	if remaining ~= "" then
		out[#out + 1] = remaining
	elseif #out == 0 then
		out[#out + 1] = ""
	end
end

local function normalize_toast_anchor(anchor)
	if anchor == nil then
		return nil
	end
	if anchor == false then
		return nil
	end
	if type(anchor) ~= "string" then
		return nil
	end
	local normalized = anchor:lower():gsub("%s+", "_"):gsub("-", "_")
	if normalized == "manual" or normalized == "none" then
		return nil
	end
	if normalized == "topright" then
		normalized = "top_right"
	elseif normalized == "topleft" then
		normalized = "top_left"
	elseif normalized == "bottomright" then
		normalized = "bottom_right"
	elseif normalized == "bottomleft" then
		normalized = "bottom_left"
	end
	if normalized == "top_right" or normalized == "top_left" or normalized == "bottom_right" or normalized == "bottom_left" then
		return normalized
	end
	return nil
end

local function resolve_toast_anchor_margins(margins)
	local top, right, bottom, left = 1, 1, 1, 1
	if margins == nil then
		return { top = top, right = right, bottom = bottom, left = left }
	end
	if type(margins) == "number" then
		local value = math.max(0, math.floor(margins))
		top, right, bottom, left = value, value, value, value
	elseif type(margins) == "table" then
		if margins.all ~= nil then
			local value = math.max(0, math.floor(margins.all))
			top, right, bottom, left = value, value, value, value
		end
		if margins.vertical ~= nil then
			local value = math.max(0, math.floor(margins.vertical))
			top, bottom = value, value
		end
		if margins.horizontal ~= nil then
			local value = math.max(0, math.floor(margins.horizontal))
			right, left = value, value
		end
		if margins.top ~= nil then
			top = math.max(0, math.floor(margins.top))
		end
		if margins.right ~= nil then
			right = math.max(0, math.floor(margins.right))
		end
		if margins.bottom ~= nil then
			bottom = math.max(0, math.floor(margins.bottom))
		end
		if margins.left ~= nil then
			left = math.max(0, math.floor(margins.left))
		end
	end
	return { top = top, right = right, bottom = bottom, left = left }
end

local function toast_wrap_text(text, width)
	local lines = {}
	if width <= 0 then
		lines[1] = ""
		return lines
	end
	text = tostring(text or "")
	if text == "" then
		lines[1] = ""
		return lines
	end
	local start = 1
	while true do
		local nl = text:find("\n", start, true)
		if not nl then
			toast_wrap_line(text:sub(start), width, lines)
			break
		end
		toast_wrap_line(text:sub(start, nl - 1), width, lines)
		start = nl + 1
	end
	if #lines == 0 then
		lines[1] = ""
	end
	return lines
end

---@generic T: table
---@param src T|nil
---@return T|nil
local function clone_table(src)
	if not src then
		return nil
	end
	local copy = {}
	for k, v in pairs(src) do
		copy[k] = v
	end
	return copy
end

local function assert_positive_integer(name, value)
	expect(nil, name, "string")
	expect(nil, value, "number")
	if value < 1 or value ~= math.floor(value) then
		error(('%s must be a positive integer, got "%s"'):format(name, tostring(value)), 3)
	end
end

local function normalize_border(config)
	if not config or config == false then
		return nil
	end

	if config == true then
		return {
			color = colors.lightGray,
			top = true,
			right = true,
			bottom = true,
			left = true,
			thickness = 1
		}
	end

	expect(1, config, "table")
	local normalized = {
		color = config.color or colors.lightGray,
		top = true,
		right = true,
		bottom = true,
		left = true,
		thickness = math.max(1, math.floor(config.thickness or 1))
	}

	local function apply_side(side, enabled)
		if enabled ~= nil then
			normalized[side] = not not enabled
		end
	end

	if config.sides then
		normalized.top = false
		normalized.right = false
		normalized.bottom = false
		normalized.left = false
		if #config.sides > 0 then
			for i = 1, #config.sides do
				local side = config.sides[i]
				if normalized[side] ~= nil then
					normalized[side] = true
				end
			end
		else
			for side, enabled in pairs(config.sides) do
				if normalized[side] ~= nil then
					normalized[side] = not not enabled
				end
			end
		end
	else
		for i = 1, #borderSides do
			apply_side(borderSides[i], config[borderSides[i]])
		end
	end

	if normalized.thickness < 1 then
		normalized.thickness = 1
	end

	return normalized
end

local SCROLLBAR_ARROW_UP = string.char(30)
local SCROLLBAR_ARROW_DOWN = string.char(31)

local function normalize_scrollbar(config, fallbackBg, fallbackFg)
	if config == false then
		return nil
	end

	local source
	if config == nil or config == true then
		source = {}
	elseif type(config) == "table" then
		source = config
		if source.enabled == false then
			return nil
		end
	else
		expect(1, config, "table")
		source = config
		if source.enabled == false then
			return nil
		end
	end

	local trackColor = source.trackColor or colors.gray
	local thumbColor = source.thumbColor or colors.lightGray
	local arrowColor = source.arrowColor or fallbackFg or colors.white
	local background = source.background or fallbackBg or colors.black
	local width = math.max(1, math.floor(source.width or 1))
	local minThumbSize = math.max(1, math.floor(source.minThumbSize or 1))
	return {
		enabled = true,
		alwaysVisible = not not source.alwaysVisible,
		width = width,
		trackColor = trackColor,
		thumbColor = thumbColor,
		arrowColor = arrowColor,
		background = background,
		minThumbSize = minThumbSize
	}
end

local function clamp01(value)
	if value < 0 then
		return 0
	end
	if value > 1 then
		return 1
	end
	return value
end

local function resolve_scrollbar(style, totalItems, visibleItems, availableWidth)
	if not style or style.enabled == false then
		return 0, nil
	end
	totalItems = math.max(0, totalItems or 0)
	visibleItems = math.max(0, visibleItems or 0)
	availableWidth = math.max(0, availableWidth or 0)
	if availableWidth <= 1 or visibleItems <= 0 then
		return 0, nil
	end
	if visibleItems <= 2 then
		return 0, nil
	end
	if not style.alwaysVisible and totalItems <= visibleItems then
		return 0, nil
	end
	local maxWidth = math.max(1, availableWidth - 1)
	local width = math.max(1, math.floor(style.width or 1))
	if width > maxWidth then
		width = maxWidth
	end
	if width <= 0 then
		return 0, nil
	end
	return width, style
end

local function draw_vertical_scrollbar(textLayer, x, y, height, totalItems, visibleItems, zeroOffset, style)
	if not style or height <= 0 then
		return
	end
	local width = math.max(1, math.floor(style.width or 1))
	local trackColor = style.trackColor
	local arrowColor = style.arrowColor
	local thumbColor = style.thumbColor
	local minThumbSize = math.max(1, math.floor(style.minThumbSize or 1))
	local arrowPadding = math.max(0, width - 1)
	local topArrowLine = SCROLLBAR_ARROW_UP .. string.rep(" ", arrowPadding)
	textLayer.text(x, y, topArrowLine, arrowColor, trackColor)
	if height >= 2 then
		local bottomArrowLine = SCROLLBAR_ARROW_DOWN .. string.rep(" ", arrowPadding)
		textLayer.text(x, y + height - 1, bottomArrowLine, arrowColor, trackColor)
	end
	local trackStart = y + 1
	local trackHeight = math.max(0, height - 2)
	local trackFill = string.rep(" ", width)
	for row = 0, trackHeight - 1 do
		textLayer.text(x, trackStart + row, trackFill, trackColor, trackColor)
	end
	local maxZeroOffset = math.max(0, (totalItems or 0) - (visibleItems or 0))
	if maxZeroOffset <= 0 or trackHeight <= 0 then
		return
	end
	local sanitizedOffset = math.max(0, math.min(maxZeroOffset, math.floor((zeroOffset or 0) + 0.5)))
	local lengthRatio = visibleItems / totalItems
	local thumbHeight = math.max(minThumbSize, math.floor(trackHeight * lengthRatio + 0.5))
	if thumbHeight > trackHeight then
		thumbHeight = trackHeight
	end
	if thumbHeight < 1 then
		thumbHeight = 1
	end
	local thumbRange = trackHeight - thumbHeight
	local thumbStart = trackStart
	if thumbRange > 0 then
		local positionRatio = clamp01(maxZeroOffset == 0 and 0 or (sanitizedOffset / maxZeroOffset))
		thumbStart = trackStart + math.floor(positionRatio * thumbRange + 0.5)
		if thumbStart > trackStart + thumbRange then
			thumbStart = trackStart + thumbRange
		end
	end
	local thumbFill = string.rep(" ", width)
	for row = 0, thumbHeight - 1 do
		textLayer.text(x, thumbStart + row, thumbFill, thumbColor, thumbColor)
	end
end

local function scrollbar_click_to_offset(relativeY, height, totalItems, visibleItems, currentZeroOffset)
	if height <= 0 then
		return currentZeroOffset or 0
	end
	local maxZeroOffset = math.max(0, (totalItems or 0) - (visibleItems or 0))
	if maxZeroOffset <= 0 then
		return 0
	end
	local offset = math.max(0, math.min(maxZeroOffset, math.floor((currentZeroOffset or 0) + 0.5)))
	if relativeY <= 0 then
		return math.max(0, offset - 1)
	elseif relativeY >= height - 1 then
		return math.min(maxZeroOffset, offset + 1)
	end
	local trackHeight = height - 2
	if trackHeight <= 0 then
		return offset
	end
	local trackPos = relativeY - 1
	if trackPos < 0 then
		trackPos = 0
	elseif trackPos > trackHeight then
		trackPos = trackHeight
	end
	local target = math.floor((trackPos / trackHeight) * maxZeroOffset + 0.5)
	if target < 0 then
		target = 0
	elseif target > maxZeroOffset then
		target = maxZeroOffset
	end
	return target
end

---@param layer Layer
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param fg PixelUI.Color
---@param bg PixelUI.Color
---@param char string?
local function fill_rect(layer, x, y, width, height, fg, bg, char)
	if width <= 0 or height <= 0 then
		return
	end
	local glyph = char or " "
	local line = glyph:rep(width)
	for offset = 0, height - 1 do
		layer.text(x, y + offset, line, fg, bg)
	end
end

---@param layer Layer
---@param x integer
---@param y integer
---@param width integer
---@param height integer
local function clear_border_characters(layer, x, y, width, height)
	if width <= 0 or height <= 0 then
		return
	end
	local transparent = shrekbox.transparent
	for dx = 0, width - 1 do
		layer.pixel(x + dx, y, transparent)
		if height > 1 then
			layer.pixel(x + dx, y + height - 1, transparent)
		end
	end
	for dy = 1, math.max(0, height - 2) do
		layer.pixel(x, y + dy, transparent)
		if width > 1 then
			layer.pixel(x + width - 1, y + dy, transparent)
		end
	end
end

---@param pixelLayer Layer
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param border PixelUI.NormalizedBorderConfig
---@param background PixelUI.Color
local function draw_border(pixelLayer, x, y, width, height, border, background)
	if width <= 0 or height <= 0 then
		return
	end

	local color = border.color
	local bgColor = background or color
	local px = (x - 1) * 2 + 1
	local py = (y - 1) * 3 + 1
	local pw = width * 2
	local ph = height * 3

	local charHeightPixels = 3
	local charWidthPixels = 2

	local horizontalThickness = math.min(border.thickness, ph)
	local verticalThickness = math.min(border.thickness, pw)
	local horizontalBackground = math.min(ph, math.max(horizontalThickness, charHeightPixels))
	local verticalBackground = math.min(pw, math.max(verticalThickness, charWidthPixels))

	local function fill_horizontal_band(startY, bandHeight, fillColor)
		for ty = 0, bandHeight - 1 do
			local pyPos = startY + ty
			if pyPos < py or pyPos >= py + ph then break end
			for dx = 0, pw - 1 do
				pixelLayer.pixel(px + dx, pyPos, fillColor)
			end
		end
	end

	local function draw_horizontal_line(startY, thickness, lineColor)
		for ty = 0, thickness - 1 do
			local pyPos = startY + ty
			if pyPos < py or pyPos >= py + ph then break end
			for dx = 0, pw - 1 do
				pixelLayer.pixel(px + dx, pyPos, lineColor)
			end
		end
	end

	local function fill_vertical_band(startX, bandWidth, fillColor)
		for tx = 0, bandWidth - 1 do
			local pxPos = startX + tx
			if pxPos < px or pxPos >= px + pw then break end
			for dy = 0, ph - 1 do
				pixelLayer.pixel(pxPos, py + dy, fillColor)
			end
		end
	end

	local function draw_vertical_line(startX, thickness, lineColor)
		for tx = 0, thickness - 1 do
			local pxPos = startX + tx
			if pxPos < px or pxPos >= px + pw then break end
			for dy = 0, ph - 1 do
				pixelLayer.pixel(pxPos, py + dy, lineColor)
			end
		end
	end

	-- fill background bands first
	if border.left then
		fill_vertical_band(px, verticalBackground, bgColor)
	end
	if border.right then
		fill_vertical_band(px + pw - verticalBackground, verticalBackground, bgColor)
	end
	if border.top then
		fill_horizontal_band(py, horizontalBackground, bgColor)
	end
	if border.bottom then
		fill_horizontal_band(py + ph - horizontalBackground, horizontalBackground, bgColor)
	end

	-- draw vertical lines
	if border.top then
		draw_horizontal_line(py, horizontalThickness, color)
	end

	if border.bottom then
		draw_horizontal_line(py + ph - horizontalThickness, horizontalThickness, color)
	end

	if border.left then
		draw_vertical_line(px, verticalThickness, color)
	end

	if border.right then
		draw_vertical_line(px + pw - verticalThickness, verticalThickness, color)
	end
end

function NotificationToast:new(app, config)
	config = config or {}
	expect(1, app, "table")
	if config ~= nil then
		expect(2, config, "table")
	end
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = false
	baseConfig.width = math.max(12, math.floor(baseConfig.width or 24))
	baseConfig.height = math.max(3, math.floor(baseConfig.height or 5))
	if baseConfig.visible == nil then
		baseConfig.visible = false
	end
	local instance = setmetatable({}, NotificationToast)
	instance:_init_base(app, baseConfig)
	instance.focusable = false

	local explicitAnchor = config.anchor ~= nil
	local anchor = normalize_toast_anchor(config.anchor)
	if not anchor and not explicitAnchor then
		if config.x ~= nil or config.y ~= nil then
			anchor = nil
		else
			anchor = "top_right"
		end
	end
	instance.anchor = anchor
	instance.anchorMargins = resolve_toast_anchor_margins(config.anchorMargin)
	instance.anchorAnimationDuration = math.max(0.05, tonumber(config.anchorAnimationDuration) or 0.2)
	instance.anchorEasing = config.anchorEasing or "easeOutCubic"
	instance._anchorDirty = true
	instance._anchorAnimationHandle = nil

	instance.title = config.title ~= nil and tostring(config.title) or nil
	instance.message = config.message ~= nil and tostring(config.message) or ""
	instance.icon = config.icon ~= nil and tostring(config.icon) or nil
	instance.severity = normalize_toast_severity(config.severity)
	local duration = config.duration
	if duration ~= nil then
		duration = tonumber(duration) or 0
	else
		duration = 3
	end
	if duration < 0 then
		duration = 0
	end
	instance.duration = duration
	instance.autoHide = config.autoHide ~= false
	instance.dismissOnClick = config.dismissOnClick ~= false
	instance.onDismiss = config.onDismiss
	if instance.onDismiss ~= nil and type(instance.onDismiss) ~= "function" then
		error("config.onDismiss must be a function", 2)
	end
	instance.variantOverrides = config.variants and clone_table(config.variants) or nil
	instance.styleOverride = config.style and clone_table(config.style) or nil
	instance.paddingLeft, instance.paddingRight, instance.paddingTop, instance.paddingBottom = resolve_toast_padding(config.padding)
	instance._hideTimer = nil
	instance._wrappedLines = { "" }
	instance._lastWrapWidth = nil
	instance._lastMessage = nil
	instance:_refreshWrap(true)
	return instance
end

function NotificationToast:_applyPadding(padding, force)
	local left, right, top, bottom = resolve_toast_padding(padding)
	if force or left ~= self.paddingLeft or right ~= self.paddingRight or top ~= self.paddingTop or bottom ~= self.paddingBottom then
		self.paddingLeft = left
		self.paddingRight = right
		self.paddingTop = top
		self.paddingBottom = bottom
		self:_refreshWrap(true)
		self._anchorDirty = true
	end
end

function NotificationToast:setPadding(padding)
	self:_applyPadding(padding, false)
end

function NotificationToast:getAnchor()
	return self.anchor
end

function NotificationToast:getAnchorMargins()
	return clone_table(self.anchorMargins)
end

function NotificationToast:refreshAnchor(animate)
	if not self.anchor then
		self._anchorDirty = false
		return
	end
	self._anchorDirty = true
	if animate and self.visible then
		self:_applyAnchorPosition(true)
	else
		self:_applyAnchorPosition(false)
	end
end

function NotificationToast:setAnchor(anchor)
	local normalized = normalize_toast_anchor(anchor)
	if normalized == nil and anchor ~= nil then
		self.anchor = nil
	else
		self.anchor = normalized
	end
	self:refreshAnchor(false)
end

function NotificationToast:setAnchorMargin(margins)
	self.anchorMargins = resolve_toast_anchor_margins(margins)
	self:refreshAnchor(false)
end

function NotificationToast:_computeAnchorPosition()
	local anchor = self.anchor
	if not anchor then
		return nil, nil
	end
	local parent = self.parent
	if not parent then
		return nil, nil
	end
	local parentWidth = parent.width
	local parentHeight = parent.height
	if type(parentWidth) ~= "number" or type(parentHeight) ~= "number" then
		return nil, nil
	end
	local width = self.width
	local height = self.height
	local margins = self.anchorMargins or resolve_toast_anchor_margins(nil)
	local targetX
	local targetY
	if anchor == "top_right" then
		targetX = parentWidth - width - (margins.right or 0) + 1
		targetY = (margins.top or 0) + 1
	elseif anchor == "top_left" then
		targetX = (margins.left or 0) + 1
		targetY = (margins.top or 0) + 1
	elseif anchor == "bottom_right" then
		targetX = parentWidth - width - (margins.right or 0) + 1
		targetY = parentHeight - height - (margins.bottom or 0) + 1
	elseif anchor == "bottom_left" then
		targetX = (margins.left or 0) + 1
		targetY = parentHeight - height - (margins.bottom or 0) + 1
	else
		return nil, nil
	end
	if targetX < 1 then
		targetX = 1
	end
	if targetY < 1 then
		targetY = 1
	end
	if targetX + width - 1 > parentWidth then
		targetX = math.max(1, parentWidth - width + 1)
	end
	if targetY + height - 1 > parentHeight then
		targetY = math.max(1, parentHeight - height + 1)
	end
	return targetX, targetY
end

function NotificationToast:getAnchorTargetPosition()
	return self:_computeAnchorPosition()
end

function NotificationToast:_applyAnchorPosition(animate)
	if not self.anchor then
		self._anchorDirty = false
		return
	end
	local targetX, targetY = self:_computeAnchorPosition()
	if not targetX or not targetY then
		return
	end
	if self._anchorAnimationHandle then
		self._anchorAnimationHandle:cancel()
		self._anchorAnimationHandle = nil
	end
	if animate and self.app and self.app.animate then
		local horizontalOffset = math.max(2, math.floor(self.width / 6))
		local verticalOffset = math.max(1, math.floor(self.height / 3))
		local startX = targetX
		local startY = targetY
		if self.anchor == "top_right" then
			startX = targetX + horizontalOffset
			startY = math.max(1, targetY - verticalOffset)
		elseif self.anchor == "top_left" then
			startX = targetX - horizontalOffset
			startY = math.max(1, targetY - verticalOffset)
		elseif self.anchor == "bottom_right" then
			startX = targetX + horizontalOffset
			startY = targetY + verticalOffset
		elseif self.anchor == "bottom_left" then
			startX = targetX - horizontalOffset
			startY = targetY + verticalOffset
		end
		Widget.setPosition(self, startX, startY)
		local duration = self.anchorAnimationDuration or 0.2
		local easing = self.anchorEasing or "easeOutCubic"
		local initialX = startX
		local initialY = startY
		local deltaX = targetX - initialX
		local deltaY = targetY - initialY
		self._anchorAnimationHandle = self.app:animate({
			duration = duration,
			easing = easing,
			update = function(progress)
				local newX = math.floor(initialX + deltaX * progress + 0.5)
				local newY = math.floor(initialY + deltaY * progress + 0.5)
				Widget.setPosition(self, newX, newY)
			end,
			onComplete = function()
				Widget.setPosition(self, targetX, targetY)
				self._anchorAnimationHandle = nil
			end,
			onCancel = function()
				Widget.setPosition(self, targetX, targetY)
				self._anchorAnimationHandle = nil
			end
		})
		self._anchorDirty = false
		return
	end
	if self.x ~= targetX or self.y ~= targetY then
		Widget.setPosition(self, targetX, targetY)
	end
	self._anchorDirty = false
end

function NotificationToast:_getActiveBorder()
	if self.border then
		return self.border
	end
	return nil
end

function NotificationToast:_refreshWrap(force, widthOverride)
	local wrapWidth
	if widthOverride ~= nil then
		wrapWidth = math.max(0, math.floor(widthOverride))
	else
		local border = self:_getActiveBorder()
		local leftPad = (border and border.left) and border.thickness or 0
		local rightPad = (border and border.right) and border.thickness or 0
		wrapWidth = math.max(0, self.width - leftPad - rightPad - (self.paddingLeft or 0) - (self.paddingRight or 0))
	end
	if wrapWidth < 0 then
		wrapWidth = 0
	end
	if not force and self._lastWrapWidth == wrapWidth and self._lastMessage == self.message then
		return
	end
	self._wrappedLines = toast_wrap_text(self.message, wrapWidth)
	self._lastWrapWidth = wrapWidth
	self._lastMessage = self.message
end

function NotificationToast:_getStyle()
	local severity = self.severity
	local baseStyle = TOAST_DEFAULT_STYLES.info
	if severity ~= nil then
		local candidate = TOAST_DEFAULT_STYLES[severity]
		if candidate then
			baseStyle = candidate
		end
	else
		severity = "info"
	end
	local resolved = baseStyle
	if self.variantOverrides then
		local variantOverride = self.variantOverrides[severity]
		if variantOverride then
			resolved = clone_table(baseStyle) or baseStyle
			for k, v in pairs(variantOverride) do
				resolved[k] = v
			end
		end
	end
	if self.styleOverride then
		if resolved == baseStyle then
			resolved = clone_table(baseStyle) or baseStyle
		end
		for k, v in pairs(self.styleOverride) do
			resolved[k] = v
		end
	end
	return resolved or baseStyle
end

function NotificationToast:_cancelTimer()
	if self._hideTimer then
		if osLib.cancelTimer then
			pcall(osLib.cancelTimer, self._hideTimer)
		end
		self._hideTimer = nil
	end
end

function NotificationToast:_scheduleHide(seconds)
	if not self.autoHide then
		return
	end
	local duration = seconds
	if duration == nil then
		duration = self.duration
	end
	if not duration or duration <= 0 then
		return
	end
	self._hideTimer = osLib.startTimer(duration)
end

function NotificationToast:setTitle(title)
	if title == nil then
		self.title = nil
	else
		self.title = tostring(title)
	end
end

function NotificationToast:getTitle()
	return self.title
end

function NotificationToast:setMessage(message)
	if message == nil then
		message = ""
	end
	local text = tostring(message)
	if self.message ~= text then
		self.message = text
		self:_refreshWrap(true)
	end
end

function NotificationToast:getMessage()
	return self.message
end

function NotificationToast:setSeverity(severity)
	local normalized = normalize_toast_severity(severity)
	if self.severity ~= normalized then
		self.severity = normalized
	end
end


function NotificationToast:getSeverity()
	return self.severity
end

function NotificationToast:setIcon(icon)
	if icon == nil or icon == "" then
		self.icon = nil
		return
	end
	self.icon = tostring(icon)
end

function NotificationToast:getIcon()
	return self.icon
end

function NotificationToast:setAutoHide(autoHide)
	autoHide = not not autoHide
	if self.autoHide ~= autoHide then
		self.autoHide = autoHide
		if not autoHide then
			self:_cancelTimer()
		end
	end
end

function NotificationToast:isAutoHide()
	return self.autoHide
end

function NotificationToast:setDuration(duration)
	if duration == nil then
		return
	end
	local seconds = tonumber(duration) or 0
	if seconds < 0 then
		seconds = 0
	end
	self.duration = seconds
	if self.visible and self.autoHide then
		self:_cancelTimer()
		self:_scheduleHide(seconds)
	end
end

function NotificationToast:getDuration()
	return self.duration
end

function NotificationToast:setDismissOnClick(enabled)
	self.dismissOnClick = not not enabled
end

function NotificationToast:isDismissOnClick()
	return self.dismissOnClick
end

function NotificationToast:setOnDismiss(handler)
	if handler ~= nil and type(handler) ~= "function" then
		error("onDismiss handler must be a function", 2)
	end
	self.onDismiss = handler
end

function NotificationToast:setVariants(variants)
	if variants ~= nil and type(variants) ~= "table" then
		error("variants must be a table", 2)
	end
	self.variantOverrides = variants and clone_table(variants) or nil
end

function NotificationToast:setStyle(style)
	if style ~= nil and type(style) ~= "table" then
		error("style must be a table", 2)
	end
	self.styleOverride = style and clone_table(style) or nil
end

function NotificationToast:present(options)
	expect(1, options, "table")
	if options.title ~= nil then
		self:setTitle(options.title)
	end
	if options.message ~= nil then
		self:setMessage(options.message)
	end
	if options.icon ~= nil then
		self:setIcon(options.icon)
	end
	if options.severity ~= nil then
		self:setSeverity(options.severity)
	end
	if options.duration ~= nil then
		self:setDuration(options.duration)
	end
	if options.autoHide ~= nil then
		self:setAutoHide(options.autoHide)
	end
	if options.style ~= nil then
		self:setStyle(options.style)
	end
	if options.variants ~= nil then
		self:setVariants(options.variants)
	end
	self:show(options.duration)
end

function NotificationToast:show(duration)
	local wasVisible = self.visible
	self.visible = true
	self:_refreshWrap(true)
	self:_cancelTimer()
	if self.anchor then
		if not wasVisible then
			self:_applyAnchorPosition(true)
		elseif self._anchorDirty then
			self:_applyAnchorPosition(false)
		end
	end
	local override = nil
	if duration ~= nil then
		override = tonumber(duration) or 0
		if override < 0 then
			override = 0
		end
	end
	self:_scheduleHide(override)
end

function NotificationToast:hide(invokeCallback)
	local wasVisible = self.visible
	self.visible = false
	self:_cancelTimer()
	if self._anchorAnimationHandle then
		self._anchorAnimationHandle:cancel()
		self._anchorAnimationHandle = nil
	end
	if invokeCallback ~= false and wasVisible and self.onDismiss then
		self.onDismiss(self)
	end
end

function NotificationToast:setSize(width, height)
	Widget.setSize(self, width, height)
	self:_refreshWrap(true)
	self._anchorDirty = true
	if self.anchor then
		self:_applyAnchorPosition(false)
	end
end

function NotificationToast:setBorder(borderConfig)
	Widget.setBorder(self, borderConfig)
	self:_refreshWrap(true)
	self._anchorDirty = true
end

function NotificationToast:_renderLine(textLayer, x, y, width, text, fg, bg)
	if width <= 0 then
		return
	end
	local content = text or ""
	if #content > width then
		content = content:sub(1, width)
	end
	if #content < width then
		content = content .. string.rep(" ", width - #content)
	end
	textLayer.text(x, y, content, fg, bg)
end

function NotificationToast:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	if self._anchorDirty and not self._anchorAnimationHandle then
		self:_applyAnchorPosition(false)
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	if width <= 0 or height <= 0 then
		return
	end

	local style = self:_getStyle() or TOAST_DEFAULT_STYLES.info
	local bg = style.bg or self.bg or colors.gray
	local fg = style.fg or self.fg or colors.white
	local accent = style.accent or fg
	local titleColor = style.titleColor or fg
	local iconColor = style.iconColor or accent

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)

	local renderBorder = self.border
	if renderBorder then
		draw_border(pixelLayer, ax, ay, width, height, renderBorder, bg)
	else
		draw_border(pixelLayer, ax, ay, width, height, {
			color = accent,
			top = true,
			right = true,
			bottom = true,
			left = true,
			thickness = 1
		}, bg)
	end

	local border = renderBorder
	local leftPad = (border and border.left) and border.thickness or 0
	local rightPad = (border and border.right) and border.thickness or 0
	local topPad = (border and border.top) and border.thickness or 0
	local bottomPad = (border and border.bottom) and border.thickness or 0
	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerHeight = math.max(0, height - topPad - bottomPad)
	local contentX = innerX + (self.paddingLeft or 0)
	local contentY = innerY + (self.paddingTop or 0)
	local contentWidth = math.max(0, innerWidth - (self.paddingLeft or 0) - (self.paddingRight or 0))
	local contentHeight = math.max(0, innerHeight - (self.paddingTop or 0) - (self.paddingBottom or 0))
	if contentWidth <= 0 or contentHeight <= 0 then
		return
	end

	local iconChar = self.icon
	if not iconChar or iconChar == "" then
		iconChar = style.icon or ""
	end
	iconChar = tostring(iconChar or "")
	local iconSpacing = 0
	local textX = contentX
	local lineY = contentY
	if iconChar ~= "" and contentWidth > 0 then
		local iconDisplay = iconChar:sub(1, 1)
		textLayer.text(contentX, lineY, iconDisplay, iconColor, bg)
		if contentWidth >= 3 then
			textLayer.text(contentX + 1, lineY, " ", iconColor, bg)
			iconSpacing = 2
		else
			iconSpacing = 1
		end
		textX = contentX + iconSpacing
	end

	local availableWidth = math.max(0, contentWidth - iconSpacing)
	self:_refreshWrap(false, availableWidth)

	if self.title and self.title ~= "" and contentHeight > 0 and availableWidth > 0 then
		self:_renderLine(textLayer, textX, lineY, availableWidth, self.title, titleColor, bg)
		lineY = lineY + 1
		contentHeight = contentHeight - 1
	end

	if contentHeight > 0 and availableWidth > 0 then
		local lines = self._wrappedLines or { "" }
		local maxLines = math.min(contentHeight, #lines)
		for index = 1, maxLines do
			self:_renderLine(textLayer, textX, lineY, availableWidth, lines[index], fg, bg)
			lineY = lineY + 1
		end
	end
end

function NotificationToast:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "timer" then
		local timerId = ...
		if self._hideTimer and timerId == self._hideTimer then
			self._hideTimer = nil
			self:hide(true)
			return true
		end
	elseif event == "mouse_click" then
		local _, x, y = ...
		if self.dismissOnClick and self:containsPoint(x, y) then
			self:hide(true)
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self.dismissOnClick and self:containsPoint(x, y) then
			self:hide(true)
			return true
		end
	end

	return false
end

function NotificationToast:onFocusChanged()
	-- toasts do not track focus
end

function LoadingRing:new(app, config)
	config = config or {}
	expect(1, app, "table")
	if config ~= nil then
		expect(2, config, "table")
	end
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = false
	baseConfig.width = math.max(3, math.floor(baseConfig.width or 8))
	baseConfig.height = math.max(3, math.floor(baseConfig.height or 5))
	local instance = setmetatable({}, LoadingRing)
	instance:_init_base(app, baseConfig)
	instance.focusable = false
	instance.color = config.color or colors.cyan
	instance.secondaryColor = config.secondaryColor or colors.lightBlue
	instance.tertiaryColor = config.tertiaryColor or colors.blue
	instance.trailColor = config.trailColor or colors.gray
	instance.trailPalette = config.trailPalette and clone_table(config.trailPalette) or nil
	instance.segmentCount = math.max(6, math.floor(config.segments or config.segmentCount or 12))
	instance.thickness = math.max(1, math.floor(config.thickness or 2))
	instance.radiusPixels = config.radius and math.max(2, math.floor(config.radius)) or nil
	local speed = tonumber(config.speed)
	if not speed or speed <= 0 then
		speed = 0.08
	end
	instance.speed = math.max(0.01, speed)
	instance.fadeSteps = math.max(0, math.floor(config.fadeSteps or 2))
	local direction = config.direction
	if type(direction) == "string" then
		local dir = direction:lower()
		if dir == "counterclockwise" or dir == "anticlockwise" or dir == "ccw" then
			direction = -1
		else
			direction = 1
		end
	elseif type(direction) == "number" then
		direction = direction >= 0 and 1 or -1
	else
		direction = 1
	end
	instance.direction = direction
	instance._phase = 0
	instance._tickTimer = nil
	instance._paused = config.autoStart == false
	if not instance._paused then
		instance:_scheduleTick()
	end
	return instance
end

function LoadingRing:_cancelTick()
	if self._tickTimer then
		if osLib.cancelTimer then
			pcall(osLib.cancelTimer, self._tickTimer)
		end
		self._tickTimer = nil
	end
end

function LoadingRing:_scheduleTick()
	self:_cancelTick()
	if self._paused then
		return
	end
	if not self.speed or self.speed <= 0 then
		return
	end
	self._tickTimer = osLib.startTimer(self.speed)
end

function LoadingRing:start()
	if not self._paused then
		return
	end
	self._paused = false
	self:_scheduleTick()
end

function LoadingRing:stop()
	if self._paused then
		return
	end
	self._paused = true
	self:_cancelTick()
end

function LoadingRing:setSpeed(speed)
	if speed == nil then
		return
	end
	local value = tonumber(speed)
	if not value then
		return
	end
	if value <= 0 then
		self.speed = 0
		self:_cancelTick()
		return
	end
	value = math.max(0.01, value)
	if value ~= self.speed then
		self.speed = value
		if not self._paused then
			self:_scheduleTick()
		end
	end
end

function LoadingRing:setDirection(direction)
	if direction == nil then
		return
	end
	local dir = direction
	if type(dir) == "string" then
		local lower = dir:lower()
		if lower == "counterclockwise" or lower == "anticlockwise" or lower == "ccw" then
			dir = -1
		else
			dir = 1
		end
	elseif type(dir) == "number" then
		dir = dir >= 0 and 1 or -1
	else
		dir = 1
	end
	if dir ~= self.direction then
		self.direction = dir
	end
end

function LoadingRing:setSegments(count)
	if count == nil then
		return
	end
	local value = math.max(3, math.floor(count))
	if value ~= self.segmentCount then
		self.segmentCount = value
		self._phase = self._phase % value
	end
end

function LoadingRing:setThickness(thickness)
	if thickness == nil then
		return
	end
	local value = math.max(1, math.floor(thickness))
	self.thickness = value
end

function LoadingRing:setRadius(radius)
	if radius == nil then
		self.radiusPixels = nil
		return
	end
	local value = math.max(2, math.floor(radius))
	self.radiusPixels = value
end

function LoadingRing:setColor(color)
	if color == nil then
		return
	end
	expect(1, color, "number")
	self.color = color
end

function LoadingRing:setSecondaryColor(color)
	if color == nil then
		self.secondaryColor = nil
		return
	end
	expect(1, color, "number")
	self.secondaryColor = color
end

function LoadingRing:setTertiaryColor(color)
	if color == nil then
		self.tertiaryColor = nil
		return
	end
	expect(1, color, "number")
	self.tertiaryColor = color
end

function LoadingRing:setTrailColor(color)
	if color == nil then
		self.trailColor = nil
		return
	end
	expect(1, color, "number")
	self.trailColor = color
end

function LoadingRing:setTrailPalette(palette)
	if palette ~= nil then
		expect(1, palette, "table")
	end
	self.trailPalette = palette and clone_table(palette) or nil
end

function LoadingRing:setFadeSteps(steps)
	if steps == nil then
		return
	end
	local value = math.max(0, math.floor(steps))
	self.fadeSteps = value
end

function LoadingRing:_computeTrailColors()
	local result = {}
	local palette = self.trailPalette
	if type(palette) == "table" then
		for index = 1, #palette do
			local value = palette[index]
			if value then
				result[#result + 1] = value
			end
		end
	end
	if #result == 0 then
		if self.secondaryColor then
			result[#result + 1] = self.secondaryColor
		end
		if self.tertiaryColor then
			result[#result + 1] = self.tertiaryColor
		end
	end
	local fadeSteps = math.max(0, math.floor(self.fadeSteps or 0))
	if fadeSteps > 0 then
		local filler = self.trailColor or result[#result] or self.color
		for _ = 1, fadeSteps do
			result[#result + 1] = filler
		end
	elseif #result == 0 and self.trailColor then
		result[1] = self.trailColor
	end
	if #result == 0 then
		result[1] = self.color
	end
	return result
end

function LoadingRing:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	if width <= 0 or height <= 0 then
		return
	end

	local background = self.bg or self.app.background
	fill_rect(textLayer, ax, ay, width, height, background, background)
	clear_border_characters(textLayer, ax, ay, width, height)

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, background)
	end

	local leftPad = (self.border and self.border.left) and 1 or 0
	local rightPad = (self.border and self.border.right) and 1 or 0
	local topPad = (self.border and self.border.top) and 1 or 0
	local bottomPad = (self.border and self.border.bottom) and 1 or 0

	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerHeight = math.max(0, height - topPad - bottomPad)

	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end

	fill_rect(textLayer, innerX, innerY, innerWidth, innerHeight, background, background)

	local centerX = innerX + (innerWidth - 1) / 2
	local centerY = innerY + (innerHeight - 1) / 2
	local maxRadius = math.floor(math.min(innerWidth, innerHeight) / 2)
	local radius = self.radiusPixels and math.floor(self.radiusPixels) or maxRadius
	if radius > maxRadius then
		radius = maxRadius
	end
	if radius < 1 then
		radius = 1
	end
	local thickness = math.max(1, math.min(math.floor(self.thickness or 1), radius))
	local outerRadius = radius + 0.35
	local innerRadius = math.max(0, radius - thickness + 0.35)
	local outerSquared = outerRadius * outerRadius
	local innerSquared = innerRadius * innerRadius

	local segments = math.max(3, math.floor(self.segmentCount or 12))
	local headIndex = self._phase % segments
	local direction = self.direction >= 0 and 1 or -1
	local twoPi = math.pi * 2
	local trailColors = self:_computeTrailColors()

	for offsetY = 0, innerHeight - 1 do
		local py = innerY + offsetY
		local relY = py - centerY
		for offsetX = 0, innerWidth - 1 do
			local px = innerX + offsetX
			local relX = px - centerX
			local distanceSquared = relX * relX + relY * relY
			local color = background
			if distanceSquared <= outerSquared and distanceSquared >= innerSquared then
				local angle = math.atan(relY, relX)
				if angle < 0 then
					angle = angle + twoPi
				end
				local segmentIndex = math.floor(angle / twoPi * segments) % segments
				local relative
				if direction >= 0 then
					relative = (headIndex - segmentIndex) % segments
				else
					relative = (segmentIndex - headIndex) % segments
				end
				if relative == 0 then
					color = self.color or background
				else
					local trailIndex = math.floor(relative + 0.0001)
					if trailIndex < 1 then
						trailIndex = 1
					end
					color = trailColors[trailIndex] or background
				end
			end
			pixelLayer.pixel(px, py, color)
		end
	end
end

function LoadingRing:handleEvent(event, ...)
	if event == "timer" then
		local timerId = ...
		if self._tickTimer and timerId == self._tickTimer then
			self._tickTimer = nil
			local segments = math.max(3, math.floor(self.segmentCount or 12))
			local direction = self.direction >= 0 and 1 or -1
			local nextPhase = (self._phase + direction) % segments
			if nextPhase < 0 then
				nextPhase = nextPhase + segments
			end
			self._phase = nextPhase
			if not self._paused then
				self:_scheduleTick()
			end
			return true
		end
	end

	return Widget.handleEvent(self, event, ...)
end

---@param widget PixelUI.Widget
local function compute_absolute_position(widget)
	local ax, ay = widget.x, widget.y
	local current = widget.parent
	while current do
		ax = ax + current.x - 1
		ay = ay + current.y - 1
		current = current.parent
	end
	return ax, ay
end

function Widget:_init_base(app, config)
	expect(1, app, "table")
	config = config or {}
	expect(2, config, "table", "nil")

	self.app = app
	self.parent = nil
	self.x = math.floor(config.x or 1)
	self.y = math.floor(config.y or 1)
	self.width = math.floor(config.width or 1)
	self.height = math.floor(config.height or 1)
	self.bg = config.bg or colors.black
	self.fg = config.fg or colors.white
	self.visible = config.visible ~= false
	self.z = config.z or 0
	self.id = config.id
	self.border = normalize_border(config.border)
	self.focusable = config.focusable == true
	self._focused = false

	assert_positive_integer("width", self.width)
	assert_positive_integer("height", self.height)
end

function Widget:setSize(width, height)
	assert_positive_integer("width", width)
	assert_positive_integer("height", height)
	self.width = width
	self.height = height
end

---@param y integer
function Widget:setPosition(x, y)
	expect(1, x, "number")
	expect(2, y, "number")
	self.x = math.floor(x)
	self.y = math.floor(y)
end

---@since 0.1.0
---@param z number
function Widget:setZ(z)
	expect(1, z, "number")
	self.z = z
end


---@since 0.1.0
---@param borderConfig PixelUI.BorderConfig|boolean|nil
function Widget:setBorder(borderConfig)
	if borderConfig == nil then
		self.border = nil
		return
	end
	if borderConfig == false then

		self.border = nil
		return
	end
	if borderConfig == true then
		self.border = normalize_border(true)
		return
	end
	expect(1, borderConfig, "table", "boolean")
	self.border = normalize_border(borderConfig)
end


---@since 0.1.0
---@return boolean
function Widget:isFocused()
	return self._focused
end


---@since 0.1.0
---@param focused boolean
function Widget:setFocused(focused)
	focused = not not focused
	if self._focused == focused then
		return
	end

	self._focused = focused
	self:onFocusChanged(focused)
end

---@since 0.1.0
---@param _focused boolean
function Widget:onFocusChanged(_focused)
	-- optional override
end

---@since 0.1.0
---@return integer x
---@return integer y
---@return integer width
---@return integer height
function Widget:getAbsoluteRect()
	local ax, ay = compute_absolute_position(self)
	return ax, ay, self.width, self.height
end

---@since 0.1.0

---@param px integer
---@param py integer
---@return boolean
function Widget:containsPoint(px, py)
	local ax, ay, width, height = self:getAbsoluteRect()
	return px >= ax and px < ax + width and py >= ay and py < ay + height
end

---@since 0.1.0
---@param _textLayer Layer
---@param _pixelLayer Layer
function Widget:draw(_textLayer, _pixelLayer)
	error("draw needs implementation for widget", 2)
end

---@since 0.1.0
---@param _event string
---@return boolean consumed
function Widget:handleEvent(_event, ...)
	return false
end


function Frame:new(app, config)
	local instance = setmetatable({}, Frame)
	instance:_init_base(app, config)
	instance._children = {}
	instance._orderCounter = 0
	instance.title = config and config.title or nil
	instance.focusable = false
	return instance
end


---@since 0.1.0
---@param child PixelUI.Widget
function Frame:addChild(child)
	expect(1, child, "table")
	if child.app ~= self.app then
		error("Cannot add widget from a different PixelUI app", 2)

	end
	if child.parent and child.parent ~= self then
		local remove = rawget(child.parent, "removeChild")
		if type(remove) == "function" then
			remove(child.parent, child)
		end
	end
	child.parent = self

	self._orderCounter = self._orderCounter + 1
	child._orderIndex = self._orderCounter
	table.insert(self._children, child)
	return child
end

---@since 0.1.0

---@param child PixelUI.Widget
function Frame:removeChild(child)
	for index = 1, #self._children do
		if self._children[index] == child then
			table.remove(self._children, index)
			child.parent = nil
			if self.app and self.app._focusWidget == child then
				self.app:setFocus(nil)

			end
			return true
		end
	end
	return false
end

local function copy_children(list)

	local result = {}
	for i = 1, #list do
		result[i] = list[i]
	end
	return result
end

local function sort_children_ascending(list)

	table.sort(list, function(a, b)
		if a.z == b.z then
			return (a._orderIndex or 0) < (b._orderIndex or 0)
		end
		return a.z < b.z
	end)

end

---@since 0.1.0
---@return PixelUI.Widget[]
function Frame:getChildren()
	return copy_children(self._children)
end


---@since 0.1.0
---@param title string?
function Frame:setTitle(title)

	if title ~= nil then
		expect(1, title, "string")
	end
	self.title = title

end

---@since 0.1.0

---@param textLayer Layer
---@param pixelLayer Layer
function Frame:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or self.app.background

	local innerX, innerY = ax + 1, ay + 1
	local innerWidth = math.max(0, width - 2)
	local innerHeight = math.max(0, height - 2)

	if innerWidth > 0 and innerHeight > 0 then
		fill_rect(textLayer, innerX, innerY, innerWidth, innerHeight, bg, bg)
	elseif width > 0 and height > 0 then
		fill_rect(textLayer, ax, ay, width, height, bg, bg)
	end

	clear_border_characters(textLayer, ax, ay, width, height)

	local titleText = self.title
	if type(titleText) == "string" and #titleText > 0 then
		local titleWidth = innerWidth > 0 and innerWidth or width
		local titleX = innerWidth > 0 and innerX or ax
		local titleY = (height > 2) and (ay + 1) or ay
		if titleWidth > 0 then
			local truncated = titleText
			if #truncated > titleWidth then
				truncated = truncated:sub(1, titleWidth)
			end
			if #truncated < titleWidth then
				truncated = truncated .. string.rep(" ", titleWidth - #truncated)

			end
			textLayer.text(titleX, titleY, truncated, self.fg, bg)
		end
	end

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local children = copy_children(self._children)
	sort_children_ascending(children)
	for i = 1, #children do
		children[i]:draw(textLayer, pixelLayer)
	end
end

---@since 0.1.0
---@diagnostic disable-next-line: undefined-doc-param
---@param event string
function Frame:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if Widget.handleEvent(self, event, ...) then
		return true
	end

	local children = copy_children(self._children)
	sort_children_ascending(children)
	for index = #children, 1, -1 do
		if children[index]:handleEvent(event, ...) then
			return true
		end
	end


	return false
end


function Button:new(app, config)
	local instance = setmetatable({}, Button)
	instance:_init_base(app, config)
	instance.label = (config and config.label) or "Button"
	instance.onPress = config and config.onPress or nil
	instance.onRelease = config and config.onRelease or nil
	instance.onClick = config and config.onClick or nil
	if config and config.clickEffect ~= nil then
		instance.clickEffect = not not config.clickEffect
	else
		instance.clickEffect = true
	end
	instance._pressed = false
	instance.focusable = false
	return instance

end

---@since 0.1.0
---@param text string
function Button:setLabel(text)
	expect(1, text, "string")
	self.label = text
end

---@since 0.1.0
---@param handler fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?
function Button:setOnClick(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onClick = handler
end

---@since 0.1.0
---@param textLayer Layer
---@param pixelLayer Layer
function Button:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.gray
	local fg = self.fg or colors.white

	local drawBg = bg
	local drawFg = fg

	if self.clickEffect and self._pressed then
		drawBg, drawFg = drawFg, drawBg
	end

	local innerX, innerY = ax + 1, ay + 1
	local innerWidth = math.max(0, width - 2)
	local innerHeight = math.max(0, height - 2)

	if innerWidth > 0 and innerHeight > 0 then
		fill_rect(textLayer, innerX, innerY, innerWidth, innerHeight, drawBg, drawBg)
	else
		fill_rect(textLayer, ax, ay, width, height, drawBg, drawBg)
	end

	clear_border_characters(textLayer, ax, ay, width, height)

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, drawBg)
	end

	local label = self.label or ""
	local availableWidth = innerWidth > 0 and innerWidth or width
	if #label > availableWidth then
		label = label:sub(1, availableWidth)
	end
	local padding = 0
	if availableWidth > #label then
		padding = math.floor((availableWidth - #label) / 2)
	end
	local labelLine = string.rep(" ", padding) .. label
	if #labelLine < availableWidth then
		labelLine = labelLine .. string.rep(" ", availableWidth - #labelLine)
	end
	local labelX = innerWidth > 0 and innerX or ax
	local labelY
	if innerHeight > 0 then
		labelY = innerY + math.floor((innerHeight - 1) / 2)
	else
		labelY = ay
	end
	textLayer.text(labelX, labelY, labelLine, drawFg, drawBg)
end

---@since 0.1.0
---@diagnostic disable-next-line: undefined-doc-param
---@param event string
function Button:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local button, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(nil)
			self._pressed = true
			if self.onPress then
				self.onPress(self, button, x, y)
			end
			return true
		end
	elseif event == "mouse_drag" then
		local button, x, y = ...
		if self._pressed then
			if not self:containsPoint(x, y) then
				self._pressed = false
				if self.onRelease then
					self.onRelease(self, button, x, y)
				end
				return false
			end
			return true
		end
	elseif event == "mouse_up" then
		local button, x, y = ...
		if self._pressed then
			self._pressed = false
			if self:containsPoint(x, y) then
				self.app:setFocus(nil)
				if self.onRelease then
					self.onRelease(self, button, x, y)
				end
				if self.onClick then
					self.onClick(self, button, x, y)
				end
				return true
			end
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(nil)
			if self.onPress then
				self.onPress(self, 1, x, y)
			end
			if self.onRelease then
				self.onRelease(self, 1, x, y)
			end
			if self.onClick then
				self.onClick(self, 1, x, y)
			end
			return true
		end
	end

	return false
end

function Label:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = false
	baseConfig.height = math.max(1, math.floor(baseConfig.height or 1))
	baseConfig.width = math.max(1, math.floor(baseConfig.width or 1))
	local instance = setmetatable({}, Label)
	instance:_init_base(app, baseConfig)
	instance.focusable = false
	local text = config and config.text
	if text == nil then
		text = ""
	end
	instance.text = tostring(text)
	instance.wrap = not not (config and config.wrap)
	local align = (config and config.align) and tostring(config.align):lower() or "left"
	if align ~= "left" and align ~= "center" and align ~= "right" then
		align = "left"
	end
	instance.align = align
	local vertical = (config and config.verticalAlign) and tostring(config.verticalAlign):lower() or "top"
	if vertical == "center" then
		vertical = "middle"
	end
	if vertical ~= "top" and vertical ~= "middle" and vertical ~= "bottom" then
		vertical = "top"
	end
	instance.verticalAlign = vertical
	instance._lines = { "" }
	instance._lastInnerWidth = nil
	instance._lastText = nil
	instance._lastWrap = nil
	instance:_updateLines(true)
	return instance
end

function Label:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	return leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight
end

function Label:_wrapLine(line, width, out)
	if width <= 0 then
		out[#out + 1] = ""
		return
	end
	line = line:gsub("\r", "")
	if line == "" then
		out[#out + 1] = ""
		return
	end
	local remaining = line
	while #remaining > width do
		local segment = remaining:sub(1, width)
		local breakPos
		for index = width, 1, -1 do
			local ch = segment:sub(index, index)
			if ch:match("%s") then
				breakPos = index - 1
				break
			end
		end
		if breakPos and breakPos >= 1 then
			local chunk = remaining:sub(1, breakPos)
			chunk = chunk:gsub("%s+$", "")
			if chunk == "" then
				chunk = remaining:sub(1, width)
				breakPos = width
			end
			out[#out + 1] = chunk
			remaining = remaining:sub(breakPos + 1)
		else
			out[#out + 1] = segment
			remaining = remaining:sub(width + 1)
		end
		remaining = remaining:gsub("^%s+", "")
		if remaining == "" then
			break
		end
	end
	if remaining ~= "" then
		out[#out + 1] = remaining
	elseif #out == 0 then
		out[#out + 1] = ""
	end
end

function Label:_updateLines(force)
	local text = tostring(self.text or "")
	local wrapEnabled = not not self.wrap
	local _, _, _, _, innerWidth = self:_getInnerMetrics()
	if not force and self._lastText == text and self._lastWrap == wrapEnabled and self._lastInnerWidth == innerWidth then
		return
	end
	local lines = {}
	if text == "" then
		lines[1] = ""
	else
		local start = 1
		while true do
			local nl = text:find("\n", start, true)
			if not nl then
				local segment = text:sub(start)
				segment = segment:gsub("\r", "")
				if wrapEnabled then
					self:_wrapLine(segment, innerWidth, lines)
				else
					lines[#lines + 1] = segment
				end
				break
			end
			local segment = text:sub(start, nl - 1)
			segment = segment:gsub("\r", "")
			if wrapEnabled then
				self:_wrapLine(segment, innerWidth, lines)
			else
				lines[#lines + 1] = segment
			end
			start = nl + 1
		end
	end
	if #lines == 0 then
		lines[1] = ""
	end
	self._lines = lines
	self._lastText = text
	self._lastWrap = wrapEnabled
	self._lastInnerWidth = innerWidth
end

function Label:setText(text)
	if text == nil then
		text = ""
	end
	text = tostring(text)
	if self.text ~= text then
		self.text = text
		self:_updateLines(true)
	end
end

function Label:getText()
	return self.text
end

function Label:setWrap(wrap)
	wrap = not not wrap
	if self.wrap ~= wrap then
		self.wrap = wrap
		self:_updateLines(true)
	end
end

function Label:isWrapping()
	return self.wrap
end

function Label:setHorizontalAlign(align)
	if align == nil then
		align = "left"
	else
		expect(1, align, "string")
	end
	local normalized = align:lower()
	if normalized ~= "left" and normalized ~= "center" and normalized ~= "right" then
		error("Invalid horizontal alignment '" .. align .. "'", 2)
	end
	if self.align ~= normalized then
		self.align = normalized
	end
end

function Label:setVerticalAlign(align)
	if align == nil then
		align = "top"
	else
		expect(1, align, "string")
	end
	local normalized = align:lower()
	if normalized == "center" then
		normalized = "middle"
	end
	if normalized ~= "top" and normalized ~= "middle" and normalized ~= "bottom" then
		error("Invalid vertical alignment '" .. align .. "'", 2)
	end
	if self.verticalAlign ~= normalized then
		self.verticalAlign = normalized
	end
end

function Label:setSize(width, height)
	Widget.setSize(self, width, height)
	self:_updateLines(true)
end

function Label:setBorder(borderConfig)
	Widget.setBorder(self, borderConfig)
	self:_updateLines(true)
end

function Label:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or self.app.background or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)

	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	local innerX = ax + leftPad
	local innerY = ay + topPad

	self:_updateLines(false)
	local lines = self._lines or { "" }
	local lineCount = #lines
	if lineCount == 0 then
		lines = { "" }
		lineCount = 1
	end

	if innerWidth > 0 and innerHeight > 0 then
		local displayCount = math.min(lineCount, innerHeight)
		local startLine = 1
		if lineCount > displayCount then
			if self.verticalAlign == "bottom" then
				startLine = lineCount - displayCount + 1
			elseif self.verticalAlign == "middle" then
				startLine = math.floor((lineCount - displayCount) / 2) + 1
			end
		end
		local topPadding = 0
		if innerHeight > displayCount then
			if self.verticalAlign == "bottom" then
				topPadding = innerHeight - displayCount
			elseif self.verticalAlign == "middle" then
				topPadding = math.floor((innerHeight - displayCount) / 2)
			end
		end
		local rowY = innerY + topPadding
		for offset = 0, displayCount - 1 do
			local line = lines[startLine + offset] or ""
			if #line > innerWidth then
				line = line:sub(1, innerWidth)
			end
			local drawX = innerX
			if self.align == "center" then
				drawX = innerX + math.floor((innerWidth - #line) / 2)
			elseif self.align == "right" then
				drawX = innerX + innerWidth - #line
			end
			if drawX < innerX then
				drawX = innerX
			end
			if drawX + #line > innerX + innerWidth then
				drawX = innerX + innerWidth - #line
			end
			if #line > 0 then
				textLayer.text(drawX, rowY, line, fg, bg)
			end
			rowY = rowY + 1
		end
	end

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end
end

function CheckBox:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	local label = "Option"
	if config and config.label ~= nil then
		label = tostring(config.label)
	end
	baseConfig.focusable = true
	baseConfig.height = baseConfig.height or 1
	baseConfig.width = baseConfig.width or math.max(4, #label + 4)
	local instance = setmetatable({}, CheckBox)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.label = label
	instance.allowIndeterminate = not not (config and config.allowIndeterminate)
	instance.indeterminate = not not (config and config.indeterminate)
	if not instance.allowIndeterminate then
		instance.indeterminate = false
	end
	instance.checked = not instance.indeterminate and not not (config and config.checked)
	instance.onChange = config and config.onChange or nil
	instance.focusBg = config and config.focusBg or colors.lightGray
	instance.focusFg = config and config.focusFg or colors.black
	return instance
end

function CheckBox:_notifyChange()
	if self.onChange then
		self.onChange(self, self.checked, self.indeterminate)
	end
end

function CheckBox:_setState(checked, indeterminate, suppressEvent)
	checked = not not checked
	indeterminate = not not indeterminate
	if indeterminate then
		checked = false
	end
	if not self.allowIndeterminate then
		indeterminate = false
	end
	local changed = (self.checked ~= checked) or (self.indeterminate ~= indeterminate)
	if not changed then
		return false
	end
	self.checked = checked
	self.indeterminate = indeterminate
	if not suppressEvent then
		self:_notifyChange()
	end
	return true
end

function CheckBox:setLabel(text)
	expect(1, text, "string")
	self.label = text
end

function CheckBox:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

function CheckBox:setAllowIndeterminate(allow)
	allow = not not allow
	if self.allowIndeterminate == allow then
		return
	end
	self.allowIndeterminate = allow
	if not allow and self.indeterminate then
		self:_setState(self.checked, false, true)
		self:_notifyChange()
	end
end

function CheckBox:setChecked(checked)
	expect(1, checked, "boolean")
	self:_setState(checked, false, false)
end

function CheckBox:isChecked()
	return self.checked
end

function CheckBox:setIndeterminate(indeterminate)
	if not self.allowIndeterminate then
		if indeterminate then
			error("Indeterminate state is disabled for this CheckBox", 2)
		end
		return
	end
	expect(1, indeterminate, "boolean")
	self:_setState(self.checked, indeterminate, false)
end

function CheckBox:isIndeterminate()
	return self.indeterminate
end

function CheckBox:toggle()
	self:_activate()
end

function CheckBox:_activate()
	if self.allowIndeterminate then
		if self.indeterminate then
			self:_setState(false, false, false)
		elseif self.checked then
			self:_setState(false, true, false)
		else
			self:_setState(true, false, false)
		end
	else
		if self.indeterminate then
			self:_setState(true, false, false)
		else
			self:_setState(not self.checked, false, false)
		end
	end
end

function CheckBox:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local baseBg = self.bg or colors.black
	local baseFg = self.fg or colors.white
	local drawBg = baseBg
	local drawFg = baseFg

	if self:isFocused() then
		drawBg = self.focusBg or drawBg
		drawFg = self.focusFg or drawFg
	end

	fill_rect(textLayer, ax, ay, width, height, drawBg, drawBg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, drawBg)
	end

	if width <= 0 or height <= 0 then
		return
	end

	local indicatorChar = " "
	if self.indeterminate then
		indicatorChar = "-"
	elseif self.checked then
		indicatorChar = "x"
	end

	local indicator = "[" .. indicatorChar .. "]"
	local buffer = {}
	buffer[#buffer + 1] = indicator
	local used = #indicator
	if width > used then
		buffer[#buffer + 1] = " "
		used = used + 1
	end
	if width > used then
		local label = self.label or ""
		local remaining = width - used
		if #label > remaining then
			label = label:sub(1, remaining)
		end
		buffer[#buffer + 1] = label
		used = used + #label
	end
	local content = table.concat(buffer)
	if #content < width then
		content = content .. string.rep(" ", width - #content)
	elseif #content > width then
		content = content:sub(1, width)
	end

	local textY = ay + math.floor((height - 1) / 2)
	textLayer.text(ax, textY, content, drawFg, drawBg)
end

function CheckBox:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_activate()
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_activate()
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.space or keyCode == keys.enter then
			self:_activate()
			return true
		end
	end

	return false
end

function Toggle:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.height = math.max(1, math.floor(baseConfig.height or 3))
	baseConfig.width = math.max(4, math.floor(baseConfig.width or 10))
	local instance = setmetatable({}, Toggle)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	local initialValue = config.value
	if initialValue == nil then
		initialValue = config.on
	end
	instance.value = not not initialValue
	instance.labelOn = (config and config.labelOn) or "On"
	instance.labelOff = (config and config.labelOff) or "Off"
	instance.trackColorOn = (config and config.trackColorOn) or colors.lightBlue
	instance.trackColorOff = (config and config.trackColorOff) or colors.gray
	instance.thumbColor = (config and config.thumbColor) or colors.white
	instance.onLabelColor = config and config.onLabelColor or nil
	instance.offLabelColor = config and config.offLabelColor or nil
	instance.focusBg = config and config.focusBg or colors.lightGray
	instance.focusFg = config and config.focusFg or colors.black
	instance.showLabel = not (config and config.showLabel == false)
	instance.disabled = not not (config and config.disabled)
	instance.onChange = config and config.onChange or nil
	return instance
end

function Toggle:_emitChange()
	if self.onChange then
		self.onChange(self, self.value)
	end
end

function Toggle:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

function Toggle:setValue(value, suppressEvent)
	value = not not value
	if self.value == value then
		return
	end
	self.value = value
	if not suppressEvent then
		self:_emitChange()
	end
end

function Toggle:isOn()
	return self.value
end

function Toggle:toggle()
	if self.disabled then
		return
	end
	self:setValue(not self.value)
end

function Toggle:setLabels(onLabel, offLabel)
	if onLabel ~= nil then
		expect(1, onLabel, "string")
		self.labelOn = onLabel
	end
	if offLabel ~= nil then
		expect(2, offLabel, "string")
		self.labelOff = offLabel
	end
end

function Toggle:setShowLabel(show)
	self.showLabel = not not show
end

function Toggle:setDisabled(disabled)
	disabled = not not disabled
	if self.disabled == disabled then
		return
	end
	self.disabled = disabled
end

function Toggle:isDisabled()
	return self.disabled
end

function Toggle:setColors(onColor, offColor, thumbColor, onLabelColor, offLabelColor)
	if onColor ~= nil then
		expect(1, onColor, "number")
		self.trackColorOn = onColor
	end
	if offColor ~= nil then
		expect(2, offColor, "number")
		self.trackColorOff = offColor
	end
	if thumbColor ~= nil then
		expect(3, thumbColor, "number")
		self.thumbColor = thumbColor
	end
	if onLabelColor ~= nil then
		expect(4, onLabelColor, "number")
		self.onLabelColor = onLabelColor
	end
	if offLabelColor ~= nil then
		expect(5, offLabelColor, "number")
		self.offLabelColor = offLabelColor
	end
end

function Toggle:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local border = self.border
	local leftPad = (border and border.left) and border.thickness or 0
	local rightPad = (border and border.right) and border.thickness or 0
	local topPad = (border and border.top) and border.thickness or 0
	local bottomPad = (border and border.bottom) and border.thickness or 0

	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerHeight = math.max(0, height - topPad - bottomPad)

	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end

	local trackX = innerX
	local trackY = innerY
	local trackWidth = innerWidth
	local trackHeight = innerHeight

	local offColor = self.trackColorOff or colors.gray
	local onColor = self.trackColorOn or colors.lightBlue
	local activeColor = self.value and onColor or offColor

	fill_rect(textLayer, trackX, trackY, trackWidth, trackHeight, activeColor, activeColor)

	local knobWidth = math.max(1, math.floor(trackWidth / 2))
	if trackWidth >= 4 then
		knobWidth = math.max(2, knobWidth)
	end
	if knobWidth > trackWidth then
		knobWidth = trackWidth
	end
	local knobX
	if self.value then
		knobX = trackX + trackWidth - knobWidth
	else
		knobX = trackX
	end
	if knobX < trackX then
		knobX = trackX
	end
	if knobX + knobWidth > trackX + trackWidth then
		knobX = trackX + trackWidth - knobWidth
	end

	local knobColor = self.thumbColor or colors.white
	if self:isFocused() then
		knobColor = self.focusBg or knobColor
	end
	fill_rect(textLayer, knobX, trackY, knobWidth, trackHeight, knobColor, knobColor)

	local labelText = ""
	if self.showLabel then
		if self.value then
			labelText = self.labelOn or "On"
		else
			labelText = self.labelOff or "Off"
		end
	end
	if labelText ~= "" and trackHeight > 0 then
		local available = math.max(0, trackWidth - 2)
		if available > 0 and #labelText > available then
			labelText = labelText:sub(1, available)
		end
		local textColor = fg
		if self.value then
			textColor = self.onLabelColor or fg
		else
			textColor = self.offLabelColor or fg
		end
		local textY = trackY + math.floor((trackHeight - 1) / 2)
		local textX = trackX + math.floor((trackWidth - #labelText) / 2)
		if textX < trackX then
			textX = trackX
		end
		if textX + #labelText - 1 > trackX + trackWidth - 1 then
			textX = trackX + trackWidth - #labelText
		end
		if #labelText > 0 then
			textLayer.text(textX, textY, labelText, textColor, activeColor)
		end
	end

	if self:isFocused() then
		local outline = self.focusFg or colors.white
		if trackWidth > 1 then
			for dx = 0, trackWidth - 1 do
				pixelLayer.pixel(trackX + dx, trackY, outline)
				if trackHeight > 1 then
					pixelLayer.pixel(trackX + dx, trackY + trackHeight - 1, outline)
				end
			end
		end
		if trackHeight > 1 then
			for dy = 0, trackHeight - 1 do
				pixelLayer.pixel(trackX, trackY + dy, outline)
				if trackWidth > 1 then
					pixelLayer.pixel(trackX + trackWidth - 1, trackY + dy, outline)
				end
			end
		end
	end

	if self.disabled then
		for dx = 0, trackWidth - 1, 2 do
			local column = trackX + dx
			pixelLayer.pixel(column, trackY, colors.gray)
			if trackHeight > 1 then
				pixelLayer.pixel(column, trackY + trackHeight - 1, colors.gray)
			end
		end
	end
end

function Toggle:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" or event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			if self.disabled then
				return true
			end
			self.app:setFocus(self)
			self:toggle()
			return true
		end
	elseif event == "key" then
		if not self:isFocused() or self.disabled then
			return false
		end
		local keyCode = ...
		if keyCode == keys.space or keyCode == keys.enter then
			self:toggle()
			return true
		end
	elseif event == "char" then
		if not self:isFocused() or self.disabled then
			return false
		end
		local ch = ...
		if ch == " " then
			self:toggle()
			return true
		end
	end

	return false
end

function RadioButton:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	local label = "Option"
	if config and config.label ~= nil then
		label = tostring(config.label)
	end
	baseConfig.focusable = true
	baseConfig.height = baseConfig.height or 1
	baseConfig.width = baseConfig.width or math.max(4, #label + 4)
	local instance = setmetatable({}, RadioButton)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.label = label
	if config and config.value ~= nil then
		instance.value = config.value
	else
		instance.value = label
	end
	if config and config.group ~= nil then
		if type(config.group) ~= "string" then
			error("RadioButton group must be a string", 2)
		end
		instance.group = config.group
	else
		instance.group = nil
	end
	instance.selected = not not (config and config.selected)
	instance.onChange = config and config.onChange or nil
	instance.focusBg = config and config.focusBg or colors.lightGray
	instance.focusFg = config and config.focusFg or colors.black
	instance._registeredGroup = nil
	instance._dotChar = RADIO_DOT_CHAR
	if instance.group and instance.app then
		instance:_registerWithGroup()
		if instance.selected then
			instance.app:_selectRadioInGroup(instance.group, instance, true)
		else
			local groups = instance.app._radioGroups
			if groups then
				local entry = groups[instance.group]
				if entry and entry.selected and entry.selected ~= instance then
					instance.selected = false
				end
			end
		end
	end
	instance:_applySelection(instance.selected, true)
	return instance
end

function RadioButton:_registerWithGroup()
	if self.app and self.group then
		self.app:_registerRadioButton(self)
	end
end

function RadioButton:_unregisterFromGroup()
	if self.app and self._registeredGroup then
		self.app:_unregisterRadioButton(self)
	end
end

function RadioButton:_notifyChange()
	if self.onChange then
		self.onChange(self, self.selected, self.value)
	end
end

function RadioButton:_applySelection(selected, suppressEvent)
	selected = not not selected
	if self.selected == selected then
		return
	end
	self.selected = selected
	if not suppressEvent then
		self:_notifyChange()
	end
end

function RadioButton:setLabel(text)
	expect(1, text, "string")
	self.label = text
end

function RadioButton:setValue(value)
	self.value = value
end

function RadioButton:getValue()
	return self.value
end

function RadioButton:setGroup(group)
	expect(1, group, "string", "nil")
	if self.group == group then
		return
	end
	self:_unregisterFromGroup()
	self.group = group
	if self.group then
		self:_registerWithGroup()
	end
end

function RadioButton:getGroup()
	return self.group
end

function RadioButton:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

function RadioButton:setSelected(selected)
	selected = not not selected
	if self.group and self.app then
		if selected then
			self.app:_selectRadioInGroup(self.group, self, false)
		else
			local groups = self.app._radioGroups
			local entry = groups and groups[self.group]
			if entry and entry.selected == self then
				self.app:_selectRadioInGroup(self.group, nil, false)
			else
				self:_applySelection(false, false)
			end
		end
		return
	end
	if self.selected == selected then
		return
	end
	self:_applySelection(selected, false)
end

function RadioButton:isSelected()
	return self.selected
end

function RadioButton:_activate()
	if self.group then
		if not self.selected then
			self:setSelected(true)
		end
	else
		self:setSelected(not self.selected)
	end
end

function RadioButton:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local baseBg = self.bg or colors.black
	local baseFg = self.fg or colors.white
	local drawBg = baseBg
	local drawFg = baseFg

	if self:isFocused() then
		drawBg = self.focusBg or drawBg
		drawFg = self.focusFg or drawFg
	end

	fill_rect(textLayer, ax, ay, width, height, drawBg, drawBg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, drawBg)
	end

	local textY = ay + math.floor((height - 1) / 2)
	local dot = self.selected and (self._dotChar or "*") or " "
	local indicator = "(" .. dot .. ")"
	local label = self.label or ""
	local display = indicator
	if #label > 0 then
		display = display .. " " .. label
	end
	if #display > width then
		display = display:sub(1, width)
	elseif #display < width then
		display = display .. string.rep(" ", width - #display)
	end
	if width > 0 then
		textLayer.text(ax, textY, display, drawFg, drawBg)
	end
end

function RadioButton:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_activate()
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_activate()
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.space or keyCode == keys.enter then
			self:_activate()
			return true
		end
	end

	return false
end

function ProgressBar:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = false
	baseConfig.height = baseConfig.height or 1
	baseConfig.width = baseConfig.width or 12
	local instance = setmetatable({}, ProgressBar)
	instance:_init_base(app, baseConfig)
	instance.focusable = false
	instance.min = type(config.min) == "number" and config.min or 0
	instance.max = type(config.max) == "number" and config.max or 1
	if instance.max <= instance.min then
		instance.max = instance.min + 1
	end
	local value = config.value
	if type(value) ~= "number" then
		value = instance.min
	end
	instance.value = instance:_clampValue(value)
	instance.trackColor = (config.trackColor) or colors.gray
	instance.fillColor = (config.fillColor) or colors.lightBlue
	instance.textColor = (config.textColor) or instance.fg or colors.white
	instance.label = config.label or nil
	instance.showPercent = not not config.showPercent
	instance.indeterminate = not not config.indeterminate
	instance.indeterminateSpeed = math.max(0.1, config.indeterminateSpeed or 1.2)
	instance._indeterminateProgress = 0
	instance._animationHandle = nil
	if not instance.border then
		instance.border = normalize_border(true)
	end
	if instance.indeterminate then
		instance:_startIndeterminateAnimation()
	end
	return instance
end

function ProgressBar:_clampValue(value)
	if type(value) ~= "number" then
		value = self.min
	end
	if value < self.min then
		return self.min
	end
	if value > self.max then
		return self.max
	end
	return value
end

function ProgressBar:_stopIndeterminateAnimation()
	if self._animationHandle then
		self._animationHandle:cancel()
		self._animationHandle = nil
	end
	self._indeterminateProgress = 0
end

function ProgressBar:_startIndeterminateAnimation()
	if not self.app or self._animationHandle then
		return
	end
	local duration = self.indeterminateSpeed or 1.2
	self._animationHandle = self.app:animate({
		duration = duration,
		easing = easings.linear,
		update = function(_, rawProgress)
			self._indeterminateProgress = rawProgress or 0
		end,
		onComplete = function()
			self._animationHandle = nil
			if self.indeterminate then
				self:_startIndeterminateAnimation()
			else
				self._indeterminateProgress = 0
			end
		end,
		onCancel = function()
			self._animationHandle = nil
		end
	})
end

function ProgressBar:setRange(minValue, maxValue)
	expect(1, minValue, "number")
	expect(2, maxValue, "number")
	if maxValue <= minValue then
		error("ProgressBar max must be greater than min", 2)
	end
	self.min = minValue
	self.max = maxValue
	self.value = self:_clampValue(self.value)
end

function ProgressBar:getRange()
	return self.min, self.max
end

function ProgressBar:setValue(value)
	if self.indeterminate then
		return
	end
	expect(1, value, "number")
	value = self:_clampValue(value)
	if value ~= self.value then
		self.value = value
	end
end

function ProgressBar:getValue()
	return self.value
end

function ProgressBar:getPercent()
	local range = self.max - self.min
	if range <= 0 then
		return 0
	end
	return (self.value - self.min) / range
end

function ProgressBar:setIndeterminate(indeterminate)
	indeterminate = not not indeterminate
	if self.indeterminate == indeterminate then
		return
	end
	self.indeterminate = indeterminate
	if indeterminate then
		self:_startIndeterminateAnimation()
	else
		self:_stopIndeterminateAnimation()
	end
end

function ProgressBar:isIndeterminate()
	return self.indeterminate
end

function ProgressBar:setLabel(text)
	if text ~= nil then
		expect(1, text, "string")
	end
	self.label = text
end

function ProgressBar:setShowPercent(show)
	self.showPercent = not not show
end

function ProgressBar:setColors(trackColor, fillColor, textColor)
	if trackColor ~= nil then
		expect(1, trackColor, "number")
		self.trackColor = trackColor
	end
	if fillColor ~= nil then
		expect(2, fillColor, "number")
		self.fillColor = fillColor
	end
	if textColor ~= nil then
		expect(3, textColor, "number")
		self.textColor = textColor
	end
end

function ProgressBar:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local trackColor = self.trackColor or (self.bg or colors.gray)
	local fillColor = self.fillColor or colors.lightBlue
	local textColor = self.textColor or (self.fg or colors.white)

	fill_rect(textLayer, ax, ay, width, height, trackColor, trackColor)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, trackColor)
	end

	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0

	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerHeight = math.max(0, height - topPad - bottomPad)

	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end

	fill_rect(textLayer, innerX, innerY, innerWidth, innerHeight, trackColor, trackColor)

	local fillWidth = 0
	local segmentStart = 0
	local segmentWidth = 0

	if self.indeterminate then
		segmentWidth = math.max(1, math.floor(innerWidth / 3))
		if segmentWidth > innerWidth then
			segmentWidth = innerWidth
		end
		local offsetRange = innerWidth - segmentWidth
		local progress = self._indeterminateProgress or 0
		if progress < 0 then progress = 0 end
		if progress > 1 then progress = 1 end
		segmentStart = math.floor(offsetRange * progress + 0.5)
		fill_rect(textLayer, innerX + segmentStart, innerY, segmentWidth, innerHeight, fillColor, fillColor)
	else
		local ratio = self:getPercent()
		if ratio < 0 then ratio = 0 end
		if ratio > 1 then ratio = 1 end
		fillWidth = math.floor(innerWidth * ratio + 0.5)
		if fillWidth > 0 then
			fill_rect(textLayer, innerX, innerY, fillWidth, innerHeight, fillColor, fillColor)
		end
	end

	local text = self.label or ""
	if self.showPercent and not self.indeterminate then
		local percent = math.floor(self:getPercent() * 100 + 0.5)
		local percentText = tostring(percent) .. "%"
		if text ~= "" then
			text = text .. " " .. percentText
		else
			text = percentText
		end
	end

	if text ~= "" and innerHeight > 0 then
		if #text > innerWidth then
			text = text:sub(1, innerWidth)
		end
		local textY = innerY + math.floor((innerHeight - 1) / 2)
		local startX = innerX + math.floor((innerWidth - #text) / 2)
		if startX < innerX then
			startX = innerX
		end
		for i = 1, #text do
			local ch = text:sub(i, i)
			local column = (startX - innerX) + (i - 1)
			local bgColor = trackColor
			if self.indeterminate then
				if column >= segmentStart and column < segmentStart + segmentWidth then
					bgColor = fillColor
				end
			else
				if column < fillWidth then
					bgColor = fillColor
				end
			end
			textLayer.text(startX + i - 1, textY, ch, textColor, bgColor)
		end
	end
end

function ProgressBar:handleEvent(_event, ...)
	return false
end

function Slider:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.width = baseConfig.width or 12
	if baseConfig.height == nil then
		baseConfig.height = config.showValue and 2 or 1
	end
	local instance = setmetatable({}, Slider)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.min = type(config.min) == "number" and config.min or 0
	instance.max = type(config.max) == "number" and config.max or 1
	if instance.max <= instance.min then
		instance.max = instance.min + 1
	end
	if config.step ~= nil then
		if type(config.step) ~= "number" then
			error("Slider step must be a number", 2)
		end
		instance.step = config.step > 0 and config.step or 0
	else
		instance.step = 0
	end
	instance.range = not not config.range
	instance.showValue = not not config.showValue
	instance.trackColor = config.trackColor or colors.gray
	instance.fillColor = config.fillColor or colors.lightBlue
	instance.handleColor = config.handleColor or colors.white
	if config.formatValue ~= nil then
		if type(config.formatValue) ~= "function" then
			error("Slider formatValue must be a function", 2)
		end
		instance.formatValue = config.formatValue
	else
		instance.formatValue = nil
	end
	instance.onChange = config.onChange
	instance._activeHandle = nil
	instance._focusedHandle = instance.range and "lower" or "single"
	instance._dragging = false

	if instance.range then
		local startValue
		local endValue
		if type(config.value) == "table" then
			startValue = config.value[1]
			endValue = config.value[2]
		end
		if type(config.startValue) == "number" then
			startValue = config.startValue
		end
		if type(config.endValue) == "number" then
			endValue = config.endValue
		end
		if type(startValue) ~= "number" then
			startValue = instance.min
		end
		if type(endValue) ~= "number" then
			endValue = instance.max
		end
		if startValue > endValue then
			startValue, endValue = endValue, startValue
		end
		instance.lowerValue = instance:_applyStep(startValue)
		instance.upperValue = instance:_applyStep(endValue)
		if instance.lowerValue > instance.upperValue then
			instance.lowerValue, instance.upperValue = instance.upperValue, instance.lowerValue
		end
	else
		local value = config.value
		if type(value) ~= "number" then
			value = instance.min
		end
		instance.value = instance:_applyStep(value)
	end

	if not instance.border then
		instance.border = normalize_border(true)
	end

	return instance
end

function Slider:_clampValue(value)
	if type(value) ~= "number" then
		value = self.min
	end
	if value < self.min then
		return self.min
	end
	if value > self.max then
		return self.max
	end
	return value
end

function Slider:_applyStep(value)
	value = self:_clampValue(value)
	local step = self.step or 0
	if step > 0 then
		local units = (value - self.min) / step
		value = self.min + math.floor(units + 0.5) * step
		value = self:_clampValue(value)
	end
	return value
end

function Slider:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local ax, ay = self:getAbsoluteRect()
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	local innerX = ax + leftPad
	local innerY = ay + topPad
	return innerX, innerY, innerWidth, innerHeight, leftPad, topPad, bottomPad
end

function Slider:_valueToPosition(value, width)
	if width <= 1 then
		return 0
	end
	local range = self.max - self.min
	local ratio = 0
	if range > 0 then
		ratio = (value - self.min) / range
	end
	if ratio < 0 then
		ratio = 0
	elseif ratio > 1 then
		ratio = 1
	end
	return math.floor(ratio * (width - 1) + 0.5)
end

function Slider:_positionToValue(position, width)
	if width <= 1 then
		return self.min
	end
	if position < 0 then
		position = 0
	elseif position > width - 1 then
		position = width - 1
	end
	local ratio = position / (width - 1)
	local value = self.min + (self.max - self.min) * ratio
	return self:_applyStep(value)
end

function Slider:_notifyChange()
	if not self.onChange then
		return
	end
	if self.range then
		self.onChange(self, self.lowerValue, self.upperValue)
	else
		self.onChange(self, self.value)
	end
end

function Slider:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

function Slider:_setSingleValue(value, suppressEvent)
	value = self:_applyStep(value)
	if self.value ~= value then
		self.value = value
		if not suppressEvent then
			self:_notifyChange()
		end
		return true
	end
	return false
end

function Slider:setValue(value)
	if self.range then
		return
	end
	expect(1, value, "number")
	self:_setSingleValue(value, false)
end

function Slider:getValue()
	return self.value
end

function Slider:_setLowerValue(value, suppressEvent)
	value = self:_applyStep(value)
	if value < self.min then
		value = self.min
	end
	if value > self.upperValue then
		value = self.upperValue
	end
	if self.lowerValue ~= value then
		self.lowerValue = value
		if not suppressEvent then
			self:_notifyChange()
		end
		return true
	end
	return false
end

function Slider:_setUpperValue(value, suppressEvent)
	value = self:_applyStep(value)
	if value > self.max then
		value = self.max
	end
	if value < self.lowerValue then
		value = self.lowerValue
	end
	if self.upperValue ~= value then
		self.upperValue = value
		if not suppressEvent then
			self:_notifyChange()
		end
		return true
	end
	return false
end

function Slider:setRangeValues(lower, upper, suppressEvent)
	if not self.range then
		return
	end
	if lower == nil then
		lower = self.lowerValue or self.min
	end
	if upper == nil then
		upper = self.upperValue or self.max
	end
	expect(1, lower, "number")
	expect(2, upper, "number")
	if lower > upper then
		lower, upper = upper, lower
	end
	local changed = false
	changed = self:_setLowerValue(lower, true) or changed
	changed = self:_setUpperValue(upper, true) or changed
	if changed and not suppressEvent then
		self:_notifyChange()
	end
end

function Slider:getRangeValues()
	return self.lowerValue, self.upperValue
end

function Slider:setRangeLimits(minValue, maxValue)
	expect(1, minValue, "number")
	expect(2, maxValue, "number")
	if maxValue <= minValue then
		error("Slider max must be greater than min", 2)
	end
	self.min = minValue
	self.max = maxValue
	if self.range then
		local changed = false
		changed = self:_setLowerValue(self.lowerValue, true) or changed
		changed = self:_setUpperValue(self.upperValue, true) or changed
		if changed then
			self:_notifyChange()
		end
	else
		if self:_setSingleValue(self.value, true) then
			self:_notifyChange()
		end
	end
end

function Slider:setStep(step)
	if step == nil then
		step = 0
	else
	expect(1, step, "number")
	end
	if step <= 0 then
		self.step = 0
	else
		self.step = step
	end
	if self.range then
		local changed = false
		changed = self:_setLowerValue(self.lowerValue, true) or changed
		changed = self:_setUpperValue(self.upperValue, true) or changed
		if changed then
			self:_notifyChange()
		end
	else
		if self:_setSingleValue(self.value, true) then
			self:_notifyChange()
		end
	end
end

function Slider:setShowValue(show)
	self.showValue = not not show
end

function Slider:setColors(trackColor, fillColor, handleColor)
	if trackColor ~= nil then
		expect(1, trackColor, "number")
		self.trackColor = trackColor
	end
	if fillColor ~= nil then
		expect(2, fillColor, "number")
		self.fillColor = fillColor
	end
	if handleColor ~= nil then
		expect(3, handleColor, "number")
		self.handleColor = handleColor
	end
end

function Slider:_formatNumber(value)
	local step = self.step or 0
	local result
	if step > 0 then
		local decimals = 0
		local probe = step
		while probe < 1 and decimals < 4 do
			probe = probe * 10
			decimals = decimals + 1
		end
		local fmt = "%0." .. tostring(decimals) .. "f"
		result = fmt:format(value)
	else
		result = string.format("%0.2f", value)
	end
	if result:find(".", 1, true) then
		result = result:gsub("0+$", "")
		result = result:gsub("%.$", "")
	end
	return result
end

function Slider:_formatDisplayValue()
	if self.formatValue then
		local ok, output
		if self.range then
			ok, output = pcall(self.formatValue, self, self.lowerValue, self.upperValue)
		else
			ok, output = pcall(self.formatValue, self, self.value)
		end
		if ok and type(output) == "string" then
			return output
		end
	end
	if self.range then
		return self:_formatNumber(self.lowerValue) .. " - " .. self:_formatNumber(self.upperValue)
	end
	return self:_formatNumber(self.value)
end

function Slider:_getStepForNudge(multiplier)
	local step = self.step or 0
	if step <= 0 then
		step = (self.max - self.min) / math.max(1, (self.range and 20 or 40))
	end
	if step <= 0 then
		step = 1
	end
	if multiplier and multiplier > 1 then
		step = step * multiplier
	end
	return step
end

function Slider:_positionFromPoint(x)
	local innerX, _, innerWidth = self:_getInnerMetrics()
	if innerWidth <= 0 then
		return nil, innerWidth
	end
	local pos = math.floor(x - innerX)
	if pos < 0 then
		pos = 0
	elseif pos > innerWidth - 1 then
		pos = innerWidth - 1
	end
	return pos, innerWidth
end

function Slider:_beginInteraction(x)
	local pos, innerWidth = self:_positionFromPoint(x)
	if not pos then
		return false
	end
	if self.range then
		local lowerPos = self:_valueToPosition(self.lowerValue, innerWidth)
		local upperPos = self:_valueToPosition(self.upperValue, innerWidth)
		local handle = self._focusedHandle or "lower"
		local distLower = math.abs(pos - lowerPos)
		local distUpper = math.abs(pos - upperPos)
		if distLower == distUpper then
			if pos > upperPos then
				handle = "upper"
			elseif pos < lowerPos then
				handle = "lower"
			end
		elseif distLower < distUpper then
			handle = "lower"
		else
			handle = "upper"
		end
		self._activeHandle = handle
		self._focusedHandle = handle
		local value = self:_positionToValue(pos, innerWidth)
		if handle == "lower" then
			self:_setLowerValue(value)
		else
			self:_setUpperValue(value)
		end
	else
		self._activeHandle = "single"
		self._focusedHandle = "single"
		local value = self:_positionToValue(pos, innerWidth)
		self:_setSingleValue(value)
	end
	return true
end

function Slider:_updateInteraction(x)
	if not self._activeHandle then
		return false
	end
	local pos, innerWidth = self:_positionFromPoint(x)
	if not pos then
		return false
	end
	local value = self:_positionToValue(pos, innerWidth)
	if self._activeHandle == "lower" then
		self:_setLowerValue(value)
	elseif self._activeHandle == "upper" then
		self:_setUpperValue(value)
	else
		self:_setSingleValue(value)
	end
	return true
end

function Slider:_endInteraction()
	self._activeHandle = nil
	self._dragging = false
end

function Slider:_switchFocusedHandle()
	if not self.range then
		return
	end
	if self._focusedHandle == "lower" then
		self._focusedHandle = "upper"
	else
		self._focusedHandle = "lower"
	end
end

function Slider:_nudgeValue(stepMultiplier)
	if stepMultiplier == 0 then
		return
	end
	local direction = stepMultiplier >= 0 and 1 or -1
	local magnitude = math.abs(stepMultiplier)
	local amount = self:_getStepForNudge(magnitude)
	amount = amount * direction
	if self.range then
		local handle = self._focusedHandle or "lower"
		if handle == "upper" then
			self:_setUpperValue(self.upperValue + amount)
		else
			self:_setLowerValue(self.lowerValue + amount)
		end
	else
		self:_setSingleValue(self.value + amount)
	end
end

function Slider:onFocusChanged(focused)
	if focused then
		if self.range then
			if self._focusedHandle ~= "lower" and self._focusedHandle ~= "upper" then
				self._focusedHandle = "lower"
			end
		else
			self._focusedHandle = "single"
		end
	end
end

function Slider:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or self.app.background or colors.black
	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)

	local innerX, innerY, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		if self.border then
			draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
		end
		return
	end

	local trackY
	local labelY = nil
	if self.showValue and innerHeight >= 2 then
		labelY = innerY
		trackY = innerY + innerHeight - 1
	else
		trackY = innerY + math.floor((innerHeight - 1) / 2)
	end

	fill_rect(textLayer, innerX, trackY, innerWidth, 1, self.trackColor, self.trackColor)

	local focusHandle
	if self:isFocused() then
		focusHandle = self._activeHandle or self._focusedHandle
	end

	local function drawHandle(column, handleId)
		if column < 0 or column >= innerWidth then
			return
		end
		local color = self.handleColor or colors.white
		if focusHandle and handleId == focusHandle then
			color = self.fg or colors.white
		end
		textLayer.text(innerX + column, trackY, " ", color, color)
	end

	if self.range then
		local lowerPos = self:_valueToPosition(self.lowerValue, innerWidth)
		local upperPos = self:_valueToPosition(self.upperValue, innerWidth)
		if upperPos < lowerPos then
			lowerPos, upperPos = upperPos, lowerPos
		end
		local fillWidth = upperPos - lowerPos + 1
		if fillWidth > 0 then
			fill_rect(textLayer, innerX + lowerPos, trackY, fillWidth, 1, self.fillColor, self.fillColor)
		end
		drawHandle(lowerPos, "lower")
		drawHandle(upperPos, "upper")
	else
		local pos = self:_valueToPosition(self.value, innerWidth)
		local fillWidth = pos + 1
		if fillWidth > 0 then
			fill_rect(textLayer, innerX, trackY, fillWidth, 1, self.fillColor, self.fillColor)
		end
		drawHandle(pos, "single")
	end

	if self.showValue and labelY then
		local text = self:_formatDisplayValue()
		if text and text ~= "" then
			if #text > innerWidth then
				text = text:sub(1, innerWidth)
			end
			local textX = innerX + math.floor((innerWidth - #text) / 2)
			if textX < innerX then
				textX = innerX
			end
			textLayer.text(textX, labelY, text, self.fg or colors.white, bg)
		end
	end

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end
end

function Slider:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self._dragging = true
			return self:_beginInteraction(x)
		end
	elseif event == "mouse_drag" then
		local _, x, y = ...
		if self._activeHandle then
			return self:_updateInteraction(x)
		elseif self._dragging and self:containsPoint(x, y) then
			return self:_beginInteraction(x)
		end
	elseif event == "mouse_up" then
		local _, x = ...
		local handled = false
		if self._activeHandle then
			handled = self:_updateInteraction(x)
		end
		if self._dragging then
			handled = true
		end
		self:_endInteraction()
		return handled
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_beginInteraction(x)
			self:_endInteraction()
			return true
		end
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			if direction > 0 then
				self:_nudgeValue(1)
			elseif direction < 0 then
				self:_nudgeValue(-1)
			end
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.left or keyCode == keys.down then
			self:_nudgeValue(-1)
			return true
		elseif keyCode == keys.right or keyCode == keys.up then
			self:_nudgeValue(1)
			return true
		elseif keyCode == keys.home then
			if self.range then
				self:setRangeValues(self.min, self.upperValue)
				self._focusedHandle = "lower"
			else
				self:setValue(self.min)
			end
			return true
		elseif keyCode == keys["end"] then
			if self.range then
				self:setRangeValues(self.lowerValue, self.max)
				self._focusedHandle = "upper"
			else
				self:setValue(self.max)
			end
			return true
		elseif keyCode == keys.tab then
			if self.range then
				self:_switchFocusedHandle()
				return true
			end
		elseif keyCode == keys.pageUp then
			self:_nudgeValue(-5)
			return true
		elseif keyCode == keys.pageDown then
			self:_nudgeValue(5)
			return true
		end
	elseif event == "key_up" then
		if self._activeHandle then
			self:_endInteraction()
		end
	end

	return false
end

function Table:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.width = math.max(8, math.floor(baseConfig.width or 24))
	baseConfig.height = math.max(3, math.floor(baseConfig.height or 7))
	local instance = setmetatable({}, Table)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.headerBg = config.headerBg or instance.bg or colors.gray
	instance.headerFg = config.headerFg or instance.fg or colors.white
	instance.rowBg = config.rowBg or instance.bg or colors.black
	instance.rowFg = config.rowFg or instance.fg or colors.white
	instance.highlightBg = config.highlightBg or colors.lightBlue
	instance.highlightFg = config.highlightFg or colors.black
	instance.zebra = not not config.zebra
	instance.zebraBg = config.zebraBg or colors.gray
	instance.placeholder = config.placeholder or "No rows"
	instance.allowRowSelection = config.selectable ~= false
	instance.sortColumn = config.sortColumn
	instance.sortDirection = (config.sortDirection == "desc") and "desc" or "asc"
	instance.onSelect = config.onSelect or nil
	instance.onSort = config.onSort or nil
	instance.columns = {}
	instance.data = {}
	instance._rows = {}
	instance._columnMetrics = {}
	instance._totalColumnWidth = 0
	instance.scrollOffset = 1
	instance.selectedIndex = 0
	instance.typeSearchTimeout = config.typeSearchTimeout or 0.75
	instance._typeSearch = { buffer = "", lastTime = 0 }
	instance.columns = instance:_normalizeColumns(config.columns or {})
	instance:_recomputeColumnMetrics()
	instance:setData(config.data or {})
	if config.selectedIndex then
		instance:setSelectedIndex(config.selectedIndex, true)
	end
	if instance.sortColumn then
		instance:setSort(instance.sortColumn, instance.sortDirection, true)
	end
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance.scrollbar = normalize_scrollbar(config.scrollbar, instance.bg or colors.black, instance.fg or colors.white)
	instance:_ensureSelectionVisible()
	return instance
end

function Table:_normalizeColumns(columns)
	local normalized = {}
	if type(columns) == "table" then
		for i = 1, #columns do
			local col = columns[i]
			if type(col) ~= "table" then
				error("Table column configuration must be a table", 3)
			end
			local id = col.id or col.key or col.title
			if type(id) ~= "string" or id == "" then
				error("Table column is missing an id", 3)
			end
			local entry = {
				id = id,
				title = col.title or id,
				key = col.key or id,
				accessor = col.accessor,
				format = col.format,
				comparator = col.comparator,
				color = col.color,
				align = col.align or "left",
				sortable = col.sortable ~= false,
				width = math.max(3, math.floor(col.width or 10))
			}
			normalized[#normalized + 1] = entry
		end
	end
	return normalized
end

function Table:_recomputeColumnMetrics()
	self._columnMetrics = {}
	local total = 0
	for index = 1, #self.columns do
		local col = self.columns[index]
		col.width = math.max(3, math.floor(col.width or 10))
		self._columnMetrics[index] = {
			offset = total,
			width = col.width
		}
		total = total + col.width
	end
	self._totalColumnWidth = total
end

function Table:_ensureColumnsForData()
	if #self.columns > 0 then
		return
	end
	local first = self.data[1]
	if type(first) == "table" then
		local inferred = {}
		for key, value in pairs(first) do
			if type(key) == "string" then
				inferred[#inferred + 1] = {
					id = key,
					title = key,
					key = key,
					align = "left",
					sortable = true,
					width = math.max(3, math.min(20, tostring(value or ""):len() + 2))
				}
			end
		end
		table.sort(inferred, function(a, b)
			return a.id < b.id
		end)
		if #inferred == 0 then
			inferred[1] = {
				id = "value",
				title = "Value",
				key = "value",
				align = "left",
				sortable = true,
				accessor = function(row)
					if type(row) == "table" then
						local parts = {}
						local index = 0
						for key, value in pairs(row) do
							index = index + 1
							if index > 4 then
								parts[#parts + 1] = "..."
								break
							end
							parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
						end
						table.sort(parts, function(a, b)
							return a < b
						end)
						return "{" .. table.concat(parts, ", ") .. "}"
					end
					return tostring(row)
				end,
				width = math.max(6, self.width - 2)
			}
		end
		self.columns = inferred
	else
		self.columns = {
			{
				id = "value",
				title = "Value",
				align = "left",
				sortable = true,
				accessor = function(row)
					return row
				end,
				width = math.max(6, self.width - 2)
			}
		}
	end
	self:_recomputeColumnMetrics()
end

function Table:setColumns(columns)
	if columns ~= nil then
		expect(1, columns, "table")
	end
	self.columns = self:_normalizeColumns(columns or {})
	self:_recomputeColumnMetrics()
	self:_ensureColumnsForData()
	self:_refreshRows()
end

function Table:getColumns()
	local copy = {}
	for i = 1, #self.columns do
		copy[i] = clone_table(self.columns[i])
	end
	return copy
end

function Table:setData(data)
	expect(1, data, "table")
	local rows = {}
	for i = 1, #data do
		rows[i] = data[i]
	end
	self.data = rows
	self:_ensureColumnsForData()
	self:_refreshRows()
end

function Table:getData()
	local copy = {}
	for i = 1, #self.data do
		copy[i] = self.data[i]
	end
	return copy
end

function Table:_refreshRows()
	self._rows = {}
	for index = 1, #self.data do
		self._rows[index] = index
	end
	if self.sortColumn then
		self:_applySort(self.sortColumn, self.sortDirection or "asc", true)
	end
	if self.allowRowSelection then
		if #self._rows == 0 then
			self.selectedIndex = 0
		elseif self.selectedIndex < 1 or self.selectedIndex > #self._rows then
			self.selectedIndex = 1
		end
	else
		self.selectedIndex = 0
	end
	self:_clampScroll()
	self:_ensureSelectionVisible()
end

function Table:_getColumnById(columnId)
	if not columnId then
		return nil
	end
	for i = 1, #self.columns do
		if self.columns[i].id == columnId then
			return self.columns[i]
		end
	end
	return nil
end

function Table:_applySort(columnId, direction, suppressEvent)
	local column = self:_getColumnById(columnId)
	if not column or column.sortable == false then
		return
	end
	self.sortColumn = column.id
	self.sortDirection = direction == "desc" and "desc" or "asc"
	local descending = self.sortDirection == "desc"
	local comparator = column.comparator
	table.sort(self._rows, function(aIndex, bIndex)
		local aRow = self.data[aIndex]
		local bRow = self.data[bIndex]
		local aValue = Table._resolveColumnValue(column, aRow)
		local bValue = Table._resolveColumnValue(column, bRow)
		local cmp = 0
		if comparator then
			local ok, result = pcall(comparator, aValue, bValue, aRow, bRow, column)
			if ok and type(result) == "number" then
				cmp = result
			end
		end
		if cmp == 0 then
			if type(aValue) == "number" and type(bValue) == "number" then
				if aValue < bValue then
					cmp = -1
				elseif aValue > bValue then
					cmp = 1
				else
					cmp = 0
				end
			else
				local aStr = tostring(aValue or ""):lower()
				local bStr = tostring(bValue or ""):lower()
				if aStr < bStr then
					cmp = -1
				elseif aStr > bStr then
					cmp = 1
				else
					cmp = 0
				end
			end
		end
		if cmp == 0 then
			return aIndex < bIndex
		end
		if descending then
			return cmp > 0
		end
		return cmp < 0
	end)
	if not suppressEvent and self.onSort then
		self.onSort(self, self.sortColumn, self.sortDirection)
	end
	self:_ensureSelectionVisible()
end

function Table:setSort(columnId, direction, suppressEvent)
	if columnId == nil then
		self.sortColumn = nil
		self.sortDirection = "asc"
		self:_refreshRows()
		return
	end
	self:_applySort(columnId, direction or self.sortDirection, suppressEvent)
end

function Table:getSort()
	return self.sortColumn, self.sortDirection
end

function Table:setOnSort(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onSort = handler
end

function Table:setScrollbar(scrollbar)
	self.scrollbar = normalize_scrollbar(scrollbar, self.bg or colors.black, self.fg or colors.white)
	self:_clampScroll()
end

function Table:setOnSelect(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onSelect = handler
end

function Table:getSelectedIndex()
	return self.selectedIndex
end

function Table:getSelectedRow()
	if self.selectedIndex >= 1 and self.selectedIndex <= #self._rows then
		return self.data[self._rows[self.selectedIndex]]
	end
	return nil
end

function Table:setSelectedIndex(index, suppressEvent)
	if not self.allowRowSelection then
		self.selectedIndex = 0
		return
	end
	if #self._rows == 0 then
		self.selectedIndex = 0
		self.scrollOffset = 1
		return
	end
	expect(1, index, "number")
	index = math.floor(index)
	if index < 1 then
		index = 1
	elseif index > #self._rows then
		index = #self._rows
	end
	local changed = index ~= self.selectedIndex
	self.selectedIndex = index
	self:_ensureSelectionVisible()
	if changed and not suppressEvent then
		self:_notifySelect()
	end
end

function Table:_notifySelect()
	if self.onSelect then
		self.onSelect(self, self:getSelectedRow(), self.selectedIndex)
	end
end

function Table:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local ax, ay = self:getAbsoluteRect()
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	local innerX = ax + leftPad
	local innerY = ay + topPad
	return innerX, innerY, innerWidth, innerHeight
end

function Table:_computeLayoutMetrics()
	local innerX, innerY, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		return {
			innerX = innerX,
			innerY = innerY,
			innerWidth = innerWidth,
			innerHeight = innerHeight,
			headerHeight = 0,
			rowsHeight = 0,
			contentWidth = 0,
			scrollbarWidth = 0,
			scrollbarStyle = nil,
			scrollbarX = innerX
		}
	end
	local headerHeight = innerHeight >= 1 and 1 or 0
	local rowsHeight = math.max(0, innerHeight - headerHeight)
	local scrollbarWidth, scrollbarStyle = resolve_scrollbar(self.scrollbar, #self._rows, rowsHeight, innerWidth)
	if scrollbarWidth > 0 and innerWidth - scrollbarWidth < 1 then
		scrollbarWidth = math.max(0, innerWidth - 1)
		if scrollbarWidth <= 0 then
			scrollbarWidth = 0
			scrollbarStyle = nil
		end
	end
	local contentWidth = innerWidth - scrollbarWidth
	if contentWidth < 1 then
		contentWidth = innerWidth
		scrollbarWidth = 0
		scrollbarStyle = nil
	end
	return {
		innerX = innerX,
		innerY = innerY,
		innerWidth = innerWidth,
		innerHeight = innerHeight,
		headerHeight = headerHeight,
		rowsHeight = rowsHeight,
		contentWidth = contentWidth,
		scrollbarWidth = scrollbarWidth,
		scrollbarStyle = scrollbarStyle,
		scrollbarX = innerX + contentWidth
	}
end

function Table:_getRowsVisible()
	local metrics = self:_computeLayoutMetrics()
	if metrics.innerWidth <= 0 or metrics.innerHeight <= 0 or metrics.contentWidth <= 0 then
		return 0
	end
	local rows = metrics.rowsHeight
	if rows < 0 then
		rows = 0
	end
	return rows
end

function Table:_clampScroll()
	local rowsVisible = self:_getRowsVisible()
	if #self._rows == 0 or rowsVisible <= 0 then
		self.scrollOffset = 1
		return
	end
	local maxOffset = math.max(1, #self._rows - rowsVisible + 1)
	if self.scrollOffset < 1 then
		self.scrollOffset = 1
	elseif self.scrollOffset > maxOffset then
		self.scrollOffset = maxOffset
	end
end

function Table:_ensureSelectionVisible()
	self:_clampScroll()
	if not self.allowRowSelection or self.selectedIndex < 1 or self.selectedIndex > #self._rows then
		return
	end
	local rowsVisible = self:_getRowsVisible()
	if rowsVisible <= 0 then
		return
	end
	if self.selectedIndex < self.scrollOffset then
		self.scrollOffset = self.selectedIndex
	elseif self.selectedIndex > self.scrollOffset + rowsVisible - 1 then
		self.scrollOffset = self.selectedIndex - rowsVisible + 1
	end
	self:_clampScroll()
end

function Table:_rowFromPoint(x, y)
	if not self:containsPoint(x, y) then
		return nil
	end
	local metrics = self:_computeLayoutMetrics()
	if metrics.innerWidth <= 0 or metrics.innerHeight <= 0 or metrics.contentWidth <= 0 then
		return nil
	end
	local rowStartY = metrics.innerY + metrics.headerHeight
	if y < rowStartY or y >= rowStartY + metrics.rowsHeight then
		return nil
	end
	if x < metrics.innerX or x >= metrics.innerX + metrics.contentWidth then
		return nil
	end
	local relativeRow = y - rowStartY
	if relativeRow < 0 or relativeRow >= metrics.rowsHeight then
		return nil
	end
	local index = self.scrollOffset + relativeRow
	if index < 1 or index > #self._rows then
		return nil
	end
	return index
end

function Table:_columnFromPoint(x, y)
	if not self:containsPoint(x, y) then
		return nil
	end
	local metrics = self:_computeLayoutMetrics()
	if metrics.innerWidth <= 0 or metrics.innerHeight <= 0 or metrics.contentWidth <= 0 then
		return nil
	end
	if metrics.headerHeight <= 0 or y ~= metrics.innerY then
		return nil
	end
	if x < metrics.innerX or x >= metrics.innerX + metrics.contentWidth then
		return nil
	end
	local remaining = metrics.contentWidth
	local cursor = metrics.innerX
	for i = 1, #self.columns do
		local width = math.max(1, math.min(self.columns[i].width, remaining))
		if i == #self.columns then
			width = metrics.innerX + metrics.contentWidth - cursor
		end
		if width <= 0 then
			break
		end
		if x >= cursor and x < cursor + width then
			return self.columns[i], i
		end
		cursor = cursor + width
		remaining = metrics.contentWidth - (cursor - metrics.innerX)
		if remaining <= 0 then
			break
		end
	end
	return nil
end

function Table._resolveColumnValue(column, row)
	if column.accessor then
		local ok, value = pcall(column.accessor, row, column)
		if ok then
			return value
		end
	end
	if type(row) == "table" then
		local key = column.key or column.id
		return row[key]
	end
	return row
end

function Table:_formatCell(column, row, value)
	if column.format then
		local ok, formatted = pcall(column.format, value, row, column)
		if ok and formatted ~= nil then
			value = formatted
		end
	end
	if value == nil then
		value = ""
	end
	return tostring(value)
end

function Table:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end
	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)

	local metrics = self:_computeLayoutMetrics()
	local innerWidth = metrics.innerWidth
	local innerHeight = metrics.innerHeight
	local contentWidth = metrics.contentWidth
	if innerWidth <= 0 or innerHeight <= 0 or contentWidth <= 0 then
		if self.border then
			draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
		end
		return
	end

	local innerX = metrics.innerX
	local innerY = metrics.innerY
	local headerHeight = metrics.headerHeight
	local rowsHeight = metrics.rowsHeight
	local scrollbarWidth = metrics.scrollbarWidth
	local scrollbarStyle = metrics.scrollbarStyle

	local headerBg = self.headerBg or bg
	local headerFg = self.headerFg or fg
	if headerHeight > 0 then
		textLayer.text(innerX, innerY, string.rep(" ", contentWidth), headerBg, headerBg)
		local cursorX = innerX
		local remaining = contentWidth
		for index = 1, #self.columns do
			local column = self.columns[index]
			local colWidth = math.max(1, math.min(column.width, remaining))
			if index == #self.columns then
				colWidth = math.max(1, remaining)
			end
			if colWidth <= 0 then
				break
			end
			local title = column.title or column.id
			local indicator = ""
			if self.sortColumn == column.id then
				indicator = self.sortDirection == "desc" and "v" or "^"
			end
			if indicator ~= "" and colWidth >= 2 then
				if #title >= colWidth then
					title = title:sub(1, colWidth - 1)
				end
				title = title .. indicator
			elseif colWidth > #title then
				title = title .. string.rep(" ", colWidth - #title)
			else
				title = title:sub(1, colWidth)
			end
			textLayer.text(cursorX, innerY, title, headerFg, headerBg)
			cursorX = cursorX + colWidth
			remaining = contentWidth - (cursorX - innerX)
			if remaining <= 0 then
				break
			end
		end
	end

	local rowStartY = innerY + headerHeight
	local rowsVisible = rowsHeight
	local baseRowBg = self.rowBg or bg
	local baseRowFg = self.rowFg or fg

	if rowsVisible <= 0 then
		if scrollbarWidth > 0 then
			local sbBg = (scrollbarStyle and scrollbarStyle.background) or bg
			fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
		end
		if self.border then
			draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
		end
		return
	end

	if #self._rows == 0 then
		for rowOffset = 0, rowsVisible - 1 do
			local drawY = rowStartY + rowOffset
			textLayer.text(innerX, drawY, string.rep(" ", contentWidth), baseRowFg, baseRowBg)
		end
		if self.placeholder and self.placeholder ~= "" then
			local message = self.placeholder
			if #message > contentWidth then
				message = message:sub(1, contentWidth)
			end
			local centerRow = rowsVisible > 0 and math.min(rowsVisible - 1, math.floor(rowsVisible / 2)) or 0
			local messageY = rowStartY + centerRow
			local messageX = innerX + math.floor((contentWidth - #message) / 2)
			if messageX < innerX then
				messageX = innerX
			end
			textLayer.text(messageX, messageY, message, colors.lightGray, baseRowBg)
		end
	else
		for rowOffset = 0, rowsVisible - 1 do
			local dataIndex = self.scrollOffset + rowOffset
			local drawY = rowStartY + rowOffset
			if dataIndex > #self._rows then
				textLayer.text(innerX, drawY, string.rep(" ", contentWidth), baseRowFg, baseRowBg)
			else
				local absoluteIndex = self._rows[dataIndex]
				local row = self.data[absoluteIndex]
				local isSelected = self.allowRowSelection and dataIndex == self.selectedIndex
				local rowBg = baseRowBg
				local rowFg = baseRowFg
				if isSelected then
					rowBg = self.highlightBg or colors.lightGray
					rowFg = self.highlightFg or colors.black
				elseif self.zebra and (dataIndex % 2 == 0) then
					rowBg = self.zebraBg or rowBg
				end
				local drawX = innerX
				local remainingWidth = contentWidth
				for colIndex = 1, #self.columns do
					local column = self.columns[colIndex]
					local colWidth = math.max(1, math.min(column.width, remainingWidth))
					if colIndex == #self.columns then
						colWidth = math.max(1, remainingWidth)
					end
					if colWidth <= 0 then
						break
					end
					local value = Table._resolveColumnValue(column, row)
					value = self:_formatCell(column, row, value)
					if #value > colWidth then
						value = value:sub(1, colWidth)
					end
					if column.align == "right" then
						if #value < colWidth then
							value = string.rep(" ", colWidth - #value) .. value
						end
					elseif column.align == "center" then
						local pad = colWidth - #value
						local left = math.floor(pad / 2)
						local right = pad - left
						value = string.rep(" ", left) .. value .. string.rep(" ", right)
					else
						if #value < colWidth then
							value = value .. string.rep(" ", colWidth - #value)
						end
					end
					local cellFg = rowFg
					if column.color then
						if type(column.color) == "number" then
							cellFg = column.color
						elseif type(column.color) == "function" then
							local ok, customColor = pcall(column.color, value, row, column, isSelected)
							if ok and type(customColor) == "number" then
								cellFg = customColor
							end
						end
					end
					textLayer.text(drawX, drawY, value, cellFg, rowBg)
					drawX = drawX + colWidth
					remainingWidth = contentWidth - (drawX - innerX)
					if remainingWidth <= 0 then
						break
					end
				end
			end
		end
	end

	if scrollbarWidth > 0 then
		local sbBg = (scrollbarStyle and scrollbarStyle.background) or bg
		fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
		if scrollbarStyle and rowsVisible > 0 then
			local zeroOffset = math.max(0, self.scrollOffset - 1)
			draw_vertical_scrollbar(textLayer, metrics.scrollbarX, rowStartY, rowsVisible, #self._rows, rowsVisible, zeroOffset, scrollbarStyle)
		end
	end

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end
end

function Table:_handleTypeSearch(ch)
	if not ch or ch == "" then
		return
	end
	local entry = self._typeSearch
	if not entry then
		entry = { buffer = "", lastTime = 0 }
		self._typeSearch = entry
	end
	local now = osLib.clock()
	local timeout = self.typeSearchTimeout or 0.75
	if now - (entry.lastTime or 0) > timeout then
		entry.buffer = ""
	end
	entry.buffer = (entry.buffer or "") .. ch:lower()
	entry.lastTime = now
	self:_searchForPrefix(entry.buffer)
end

function Table:_searchForPrefix(prefix)
	if not prefix or prefix == "" then
		return
	end
	if #self._rows == 0 then
		return
	end
	local start = self.selectedIndex >= 1 and self.selectedIndex or 0
	for offset = 1, #self._rows do
		local index = ((start + offset - 1) % #self._rows) + 1
		local row = self.data[self._rows[index]]
		local firstColumn = self.columns[1]
		local value = Table._resolveColumnValue(firstColumn, row)
		local text = tostring(value or ""):lower()
		if text:sub(1, #prefix) == prefix then
			self:setSelectedIndex(index)
			return
		end
	end
end

function Table:onFocusChanged(focused)
	if not focused and self._typeSearch then
		self._typeSearch.buffer = ""
		self._typeSearch.lastTime = 0
	end
end

function Table:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	local function handlePointer(x, y)
		if not self:containsPoint(x, y) then
			return false
		end
		self.app:setFocus(self)
		local metrics = self:_computeLayoutMetrics()
		if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 and metrics.rowsHeight > 0 then
			local sbX = metrics.scrollbarX
			local rowStartY = metrics.innerY + metrics.headerHeight
			if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= rowStartY and y < rowStartY + metrics.rowsHeight then
				local relativeY = y - rowStartY
				local zeroOffset = math.max(0, self.scrollOffset - 1)
				local newOffset = scrollbar_click_to_offset(relativeY, metrics.rowsHeight, #self._rows, metrics.rowsHeight, zeroOffset)
				if newOffset ~= zeroOffset then
					self.scrollOffset = newOffset + 1
					self:_clampScroll()
				end
				return true
			end
		end
		local column = self:_columnFromPoint(x, y)
		if column then
			local direction = self.sortDirection
			if self.sortColumn == column.id then
				direction = direction == "asc" and "desc" or "asc"
			else
				direction = "asc"
			end
			if column.sortable ~= false then
				self:setSort(column.id, direction)
			end
			return true
		end
		local index = self:_rowFromPoint(x, y)
		if index then
			self:setSelectedIndex(index)
			return true
		end
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		return handlePointer(x, y)
	elseif event == "monitor_touch" then
		local _, x, y = ...
		return handlePointer(x, y)
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self.scrollOffset = self.scrollOffset + direction
			self:_clampScroll()
			return true
		end
	elseif event == "char" then
		if self:isFocused() and self.allowRowSelection then
			local ch = ...
			self:_handleTypeSearch(ch)
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.up then
			if self.allowRowSelection and #self._rows > 0 then
				self:setSelectedIndex(math.max(1, (self.selectedIndex > 0) and (self.selectedIndex - 1) or 1))
			end
			return true
		elseif keyCode == keys.down then
			if self.allowRowSelection and #self._rows > 0 then
				self:setSelectedIndex(math.min(#self._rows, (self.selectedIndex > 0 and self.selectedIndex or 0) + 1))
			end
			return true
		elseif keyCode == keys.home then
			if self.allowRowSelection and #self._rows > 0 then
				self:setSelectedIndex(1)
			else
				self.scrollOffset = 1
			end
			return true
		elseif keyCode == keys["end"] then
			if self.allowRowSelection and #self._rows > 0 then
				self:setSelectedIndex(#self._rows)
			else
				self.scrollOffset = math.max(1, #self._rows - self:_getRowsVisible() + 1)
				self:_clampScroll()
			end
			return true
		elseif keyCode == keys.pageUp then
			local step = math.max(1, self:_getRowsVisible() - 1)
			self.scrollOffset = self.scrollOffset - step
			self:_clampScroll()
			if self.allowRowSelection and self.selectedIndex > 0 then
				self:setSelectedIndex(math.max(1, self.selectedIndex - step), true)
				self:_notifySelect()
			end
			return true
		elseif keyCode == keys.pageDown then
			local step = math.max(1, self:_getRowsVisible() - 1)
			self.scrollOffset = self.scrollOffset + step
			self:_clampScroll()
			if self.allowRowSelection and self.selectedIndex > 0 then
				self:setSelectedIndex(math.min(#self._rows, self.selectedIndex + step), true)
				self:_notifySelect()
			end
			return true
		elseif keyCode == keys.enter then
			if self.allowRowSelection then
				self:_notifySelect()
			end
			return true
		elseif keyCode == keys.space then
			if self.allowRowSelection then
				self:_notifySelect()
			end
			return true
		end
	end
	return false
end

function TreeView:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.height = math.max(3, math.floor(baseConfig.height or 7))
	baseConfig.width = math.max(6, math.floor(baseConfig.width or 20))
	local instance = setmetatable({}, TreeView)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.highlightBg = (config and config.highlightBg) or colors.lightGray
	instance.highlightFg = (config and config.highlightFg) or colors.black
	instance.placeholder = (config and config.placeholder) or nil
	instance.indentWidth = math.max(1, math.floor((config and config.indentWidth) or 2))
	local symbols = (config and config.toggleSymbols) or {}
	instance.toggleSymbols = {
		expanded = tostring(symbols.expanded or "-"),
		collapsed = tostring(symbols.collapsed or "+"),
		leaf = tostring(symbols.leaf or " ")
	}
	instance.onSelect = config and config.onSelect or nil
	instance.onToggle = config and config.onToggle or nil
	instance.nodes = {}
	instance._flatNodes = {}
	instance.scrollOffset = 1
	instance.selectedNode = nil
	instance._selectedIndex = 0
	instance.typeSearchTimeout = (config and config.typeSearchTimeout) or 0.75
	instance._typeSearch = { buffer = "", lastTime = 0 }
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance.scrollbar = normalize_scrollbar(config and config.scrollbar, instance.bg or colors.black, instance.fg or colors.white)
	instance:setNodes((config and config.nodes) or {})
	return instance
end

function TreeView:setOnSelect(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onSelect = handler
end

function TreeView:setOnToggle(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onToggle = handler
end

function TreeView:setScrollbar(scrollbar)
	self.scrollbar = normalize_scrollbar(scrollbar, self.bg or colors.black, self.fg or colors.white)
	self:_ensureSelectionVisible()
end

function TreeView:_copyNodes(source, parent)
	local list = {}
	if type(source) ~= "table" then
		return list
	end
	for i = 1, #source do
		local entry = source[i]
		if entry ~= nil then
			local node
			if type(entry) == "string" then
				node = {
					label = entry,
					data = nil,
					expanded = false
				}
			elseif type(entry) == "table" then
				node = {
					label = entry.label and tostring(entry.label) or string.format("Node %d", i),
					data = entry.data,
					expanded = not not entry.expanded
				}
			else
				node = {
					label = tostring(entry),
					data = nil,
					expanded = false
				}
			end
			node.parent = parent
			if entry and type(entry.children) == "table" and #entry.children > 0 then
				node.children = self:_copyNodes(entry.children, node)
				if node.expanded == nil then
					node.expanded = false
				end
			else
				node.children = {}
				node.expanded = false
			end
			list[#list + 1] = node
		end
	end
	return list
end

function TreeView:setNodes(nodes)
	nodes = nodes or {}
	expect(1, nodes, "table")
	local previousNode = self.selectedNode
	local previousIndex = self._selectedIndex
	self.nodes = self:_copyNodes(nodes, nil)
	self.scrollOffset = 1
	self.selectedNode = nil
	self._selectedIndex = 0
	self:_rebuildFlatNodes()
	local currentNode = self.selectedNode
	if previousNode ~= currentNode or self._selectedIndex ~= previousIndex then
		self:_notifySelect()
	end
end

function TreeView:getSelectedNode()
	return self.selectedNode
end

function TreeView:setSelectedNode(node)
	if node == nil then
		if self.selectedNode ~= nil then
			self.selectedNode = nil
			self._selectedIndex = 0
			self:_notifySelect()
		end
		return
	end
	self:_selectNode(node, false)
end

function TreeView:expandNode(node)
	self:_toggleNode(node, true)
end

function TreeView:collapseNode(node)
	self:_toggleNode(node, false)
end

function TreeView:toggleNode(node)
	self:_toggleNode(node, nil)
end

function TreeView:_rebuildFlatNodes()
	local flat = {}
	local function traverse(children, depth)
		for i = 1, #children do
			local node = children[i]
			flat[#flat + 1] = { node = node, depth = depth }
			if node.expanded and node.children and #node.children > 0 then
				traverse(node.children, depth + 1)
			end
		end
	end
	traverse(self.nodes, 0)
	self._flatNodes = flat
	local index = self:_findVisibleIndex(self.selectedNode)
	if index then
		self._selectedIndex = index
	elseif #flat > 0 then
		self._selectedIndex = 1
		self.selectedNode = flat[1].node
	else
		self._selectedIndex = 0
		self.selectedNode = nil
	end
	self:_ensureSelectionVisible()
end

function TreeView:_findVisibleIndex(target)
	if target == nil then
		return nil
	end
	local flat = self._flatNodes
	for i = 1, #flat do
		if flat[i].node == target then
			return i
		end
	end
	return nil
end

function TreeView:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	return leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight
end

function TreeView:_getInnerHeight()
	local _, _, _, _, _, innerHeight = self:_getInnerMetrics()
	if innerHeight < 1 then
		innerHeight = 1
	end
	return innerHeight
end

function TreeView:_computeLayoutMetrics()
	local ax, ay = self:getAbsoluteRect()
	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	local innerX = ax + leftPad
	local innerY = ay + topPad
	if innerWidth <= 0 or innerHeight <= 0 then
		return {
			innerX = innerX,
			innerY = innerY,
			innerWidth = innerWidth,
			innerHeight = innerHeight,
			contentWidth = 0,
			scrollbarWidth = 0,
			scrollbarStyle = nil,
			scrollbarX = innerX
		}
	end
	local scrollbarWidth, scrollbarStyle = resolve_scrollbar(self.scrollbar, #self._flatNodes, innerHeight, innerWidth)
	if scrollbarWidth > 0 and innerWidth - scrollbarWidth < 1 then
		scrollbarWidth = math.max(0, innerWidth - 1)
		if scrollbarWidth <= 0 then
			scrollbarWidth = 0
			scrollbarStyle = nil
		end
	end
	local contentWidth = innerWidth - scrollbarWidth
	if contentWidth < 1 then
		contentWidth = innerWidth
		scrollbarWidth = 0
		scrollbarStyle = nil
	end
	return {
		innerX = innerX,
		innerY = innerY,
		innerWidth = innerWidth,
		innerHeight = innerHeight,
		contentWidth = contentWidth,
		scrollbarWidth = scrollbarWidth,
		scrollbarStyle = scrollbarStyle,
		scrollbarX = innerX + contentWidth
	}
end

function TreeView:_ensureSelectionVisible()
	local count = #self._flatNodes
	local innerHeight = self:_getInnerHeight()
	if count == 0 then
		self.scrollOffset = 1
		return
	end
	if self._selectedIndex < 1 then
		self._selectedIndex = 1
	elseif self._selectedIndex > count then
		self._selectedIndex = count
	end
	if self.scrollOffset < 1 then
		self.scrollOffset = 1
	end
	local maxOffset = math.max(1, count - innerHeight + 1)
	if self.scrollOffset > maxOffset then
		self.scrollOffset = maxOffset
	end
	if self._selectedIndex < self.scrollOffset then
		self.scrollOffset = self._selectedIndex
	elseif self._selectedIndex > self.scrollOffset + innerHeight - 1 then
		self.scrollOffset = self._selectedIndex - innerHeight + 1
		if self.scrollOffset > maxOffset then
			self.scrollOffset = maxOffset
		end
	end
end

function TreeView:_setSelectedIndex(index, suppressEvent)
	local count = #self._flatNodes
	if count == 0 then
		self.selectedNode = nil
		self._selectedIndex = 0
		self.scrollOffset = 1
		if not suppressEvent then
			self:_notifySelect()
		end
		return
	end
	if index < 1 then
		index = 1
	elseif index > count then
		index = count
	end
	self._selectedIndex = index
	self.selectedNode = self._flatNodes[index].node
	self:_ensureSelectionVisible()
	if not suppressEvent then
		self:_notifySelect()
	end
end

function TreeView:_selectNode(node, suppressEvent)
	if not node then
		return
	end
	local parent = node.parent
	while parent do
		if not parent.expanded then
			parent.expanded = true
		end
		parent = parent.parent
	end
	self:_rebuildFlatNodes()
	local index = self:_findVisibleIndex(node)
	if index then
		self:_setSelectedIndex(index, suppressEvent)
	end
end

function TreeView:_moveSelection(delta)
	if delta == 0 then
		return
	end
	local count = #self._flatNodes
	if count == 0 then
		return
	end
	local index = self._selectedIndex
	if index < 1 then
		index = 1
	end
	index = index + delta
	if index < 1 then
		index = 1
	elseif index > count then
		index = count
	end
	self:_setSelectedIndex(index, false)
end

function TreeView:_scrollBy(delta)
	if delta == 0 then
		return
	end
	local count = #self._flatNodes
	if count == 0 then
		self.scrollOffset = 1
		return
	end
	local innerHeight = self:_getInnerHeight()
	local maxOffset = math.max(1, count - innerHeight + 1)
	self.scrollOffset = math.min(maxOffset, math.max(1, self.scrollOffset + delta))
end

function TreeView:_rowFromPoint(x, y)
	if not self:containsPoint(x, y) then
		return nil
	end
	local metrics = self:_computeLayoutMetrics()
	if metrics.innerWidth <= 0 or metrics.innerHeight <= 0 or metrics.contentWidth <= 0 then
		return nil
	end
	local innerX = metrics.innerX
	local innerY = metrics.innerY
	if x < innerX or x >= innerX + metrics.contentWidth then
		return nil
	end
	if y < innerY or y >= innerY + metrics.innerHeight then
		return nil
	end
	local row = y - innerY
	local index = self.scrollOffset + row
	if index < 1 or index > #self._flatNodes then
		return nil
	end
	return index, innerX, metrics.contentWidth
end

function TreeView:_toggleNode(node, expand)
	if not node or not node.children or #node.children == 0 then
		return false
	end
	local newState
	if expand == nil then
		newState = not node.expanded
	else
		newState = not not expand
	end
	if node.expanded == newState then
		return false
	end
	node.expanded = newState
	self:_rebuildFlatNodes()
	if self.onToggle then
		self.onToggle(self, node, newState)
	end
	return true
end

function TreeView:_notifySelect()
	if self.onSelect then
		self.onSelect(self, self.selectedNode, self._selectedIndex)
	end
end

function TreeView:onFocusChanged(focused)
	if not focused and self._typeSearch then
		self._typeSearch.buffer = ""
		self._typeSearch.lastTime = 0
	end
end

function TreeView:_searchForPrefix(prefix)
	if not prefix or prefix == "" then
		return
	end
	local flat = self._flatNodes
	local count = #flat
	if count == 0 then
		return
	end
	local start = self._selectedIndex >= 1 and self._selectedIndex or 0
	for offset = 1, count do
		local index = ((start + offset - 1) % count) + 1
		local node = flat[index].node
		local label = node and node.label or ""
		if label:lower():sub(1, #prefix) == prefix then
			self:_setSelectedIndex(index, false)
			return
		end
	end
end

function TreeView:_handleTypeSearch(ch)
	if not ch or ch == "" then
		return
	end
	local entry = self._typeSearch
	if not entry then
		entry = { buffer = "", lastTime = 0 }
		self._typeSearch = entry
	end
	local now = osLib.clock()
	local timeout = self.typeSearchTimeout or 0.75
	if now - (entry.lastTime or 0) > timeout then
		entry.buffer = ""
	end
	entry.buffer = entry.buffer .. ch:lower()
	entry.lastTime = now
	self:_searchForPrefix(entry.buffer)
end

function TreeView:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local metrics = self:_computeLayoutMetrics()
	local innerWidth = metrics.innerWidth
	local innerHeight = metrics.innerHeight
	local contentWidth = metrics.contentWidth
	local scrollbarWidth = metrics.scrollbarWidth
	local scrollbarStyle = metrics.scrollbarStyle
	if innerWidth <= 0 or innerHeight <= 0 or contentWidth <= 0 then
		return
	end

	local innerX = metrics.innerX
	local innerY = metrics.innerY
	local flat = self._flatNodes
	local count = #flat

	if count == 0 then
		for row = 0, innerHeight - 1 do
			textLayer.text(innerX, innerY + row, string.rep(" ", contentWidth), fg, bg)
		end
		local placeholder = self.placeholder
		if type(placeholder) == "string" and #placeholder > 0 then
			local display = placeholder
			if #display > contentWidth then
				display = display:sub(1, contentWidth)
			end
			local startX = innerX + math.floor((contentWidth - #display) / 2)
			if startX < innerX then
				startX = innerX
			end
			textLayer.text(startX, innerY, display, colors.lightGray, bg)
		end
		if scrollbarWidth > 0 then
			local sbBg = (scrollbarStyle and scrollbarStyle.background) or bg
			fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
			if scrollbarStyle then
				draw_vertical_scrollbar(textLayer, metrics.scrollbarX, innerY, innerHeight, 0, innerHeight, 0, scrollbarStyle)
			end
		end
		return
	end

	for row = 0, innerHeight - 1 do
		local lineY = innerY + row
		local index = self.scrollOffset + row
		if index > count then
			textLayer.text(innerX, lineY, string.rep(" ", contentWidth), fg, bg)
		else
			local entry = flat[index]
			local node = entry.node
			local depth = entry.depth or 0
			local indent = depth * self.indentWidth
			if indent > contentWidth - 1 then
				indent = contentWidth - 1
			end
			if indent < 0 then
				indent = 0
			end
			local spaces = indent > 0 and string.rep(" ", indent) or ""
			local symbol
			if node and node.children and #node.children > 0 then
				symbol = node.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
			else
				symbol = self.toggleSymbols.leaf
			end
			symbol = tostring(symbol or " ")
			local remaining = contentWidth - indent
			local line = spaces
			if remaining > 0 then
				local glyph = symbol:sub(1, 1)
				line = line .. glyph
				remaining = remaining - 1
			end
			if remaining > 0 then
				line = line .. " "
				remaining = remaining - 1
			end
			if remaining > 0 then
				local label = (node and node.label) or ""
				if #label > remaining then
					label = label:sub(1, remaining)
				end
				line = line .. label
				remaining = remaining - #label
			end
			if remaining > 0 then
				line = line .. string.rep(" ", remaining)
			elseif #line > contentWidth then
				line = line:sub(1, contentWidth)
			end
			local drawBg = bg
			local drawFg = fg
			if index == self._selectedIndex then
				drawBg = self.highlightBg or colors.lightGray
				drawFg = self.highlightFg or colors.black
			end
			textLayer.text(innerX, lineY, line, drawFg, drawBg)
		end
	end

	if scrollbarWidth > 0 then
		local sbBg = (scrollbarStyle and scrollbarStyle.background) or bg
		fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
		if scrollbarStyle then
			draw_vertical_scrollbar(textLayer, metrics.scrollbarX, innerY, innerHeight, #self._flatNodes, innerHeight, math.max(0, self.scrollOffset - 1), scrollbarStyle)
		end
	end
end

function TreeView:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		local index, contentX, contentWidth = self:_rowFromPoint(x, y)
		if index then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.innerHeight then
					local relativeY = y - metrics.innerY
					local zeroOffset = math.max(0, self.scrollOffset - 1)
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.innerHeight, #self._flatNodes, metrics.innerHeight, zeroOffset)
					if newOffset ~= zeroOffset then
						self.scrollOffset = newOffset + 1
						self:_ensureSelectionVisible()
					end
					return true
				end
			end
			local entry = self._flatNodes[index]
			if entry then
				local indent = entry.depth * self.indentWidth
				if indent < 0 then
					indent = 0
				end
				if indent > contentWidth - 1 then
					indent = contentWidth - 1
				end
				local toggleX = contentX + indent
				if entry.node and entry.node.children and #entry.node.children > 0 and indent < contentWidth then
					local symbolWidth = #tostring(self.toggleSymbols.collapsed or "+")
					if symbolWidth < 1 then
						symbolWidth = 1
					end
					if x >= toggleX and x < toggleX + symbolWidth then
						self:_toggleNode(entry.node, nil)
						return true
					end
				end
			end
			self:_setSelectedIndex(index, false)
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		local index, contentX, contentWidth = self:_rowFromPoint(x, y)
		if index then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.innerHeight then
					local relativeY = y - metrics.innerY
					local zeroOffset = math.max(0, self.scrollOffset - 1)
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.innerHeight, #self._flatNodes, metrics.innerHeight, zeroOffset)
					if newOffset ~= zeroOffset then
						self.scrollOffset = newOffset + 1
						self:_ensureSelectionVisible()
					end
					return true
				end
			end
			local entry = self._flatNodes[index]
			if entry then
				local indent = entry.depth * self.indentWidth
				if indent < 0 then
					indent = 0
				end
				if indent > contentWidth - 1 then
					indent = contentWidth - 1
				end
				local toggleX = contentX + indent
				if entry.node and entry.node.children and #entry.node.children > 0 and indent < contentWidth then
					local symbolWidth = #tostring(self.toggleSymbols.collapsed or "+")
					if symbolWidth < 1 then
						symbolWidth = 1
					end
					if x >= toggleX and x < toggleX + symbolWidth then
						self:_toggleNode(entry.node, nil)
						return true
					end
				end
			end
			self:_setSelectedIndex(index, false)
			return true
		end
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			if direction > 0 then
				self:_scrollBy(1)
			elseif direction < 0 then
				self:_scrollBy(-1)
			end
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.up then
			self:_moveSelection(-1)
			return true
		elseif keyCode == keys.down then
			self:_moveSelection(1)
			return true
		elseif keyCode == keys.pageUp then
			self:_moveSelection(-self:_getInnerHeight())
			return true
		elseif keyCode == keys.pageDown then
			self:_moveSelection(self:_getInnerHeight())
			return true
		elseif keyCode == keys.home then
			self:_setSelectedIndex(1, false)
			return true
		elseif keyCode == keys["end"] then
			self:_setSelectedIndex(#self._flatNodes, false)
			return true
		elseif keyCode == keys.left then
			local node = self.selectedNode
			if node then
				if node.children and #node.children > 0 and node.expanded then
					self:_toggleNode(node, false)
					return true
				elseif node.parent then
					self:_selectNode(node.parent, false)
					return true
				end
			end
		elseif keyCode == keys.right then
			local node = self.selectedNode
			if node and node.children and #node.children > 0 then
				if not node.expanded then
					self:_toggleNode(node, true)
				else
					local child = node.children[1]
					if child then
						self:_selectNode(child, false)
					end
				end
				return true
			end
		elseif keyCode == keys.enter or keyCode == keys.space then
			local node = self.selectedNode
			if node and node.children and #node.children > 0 then
				self:_toggleNode(node, nil)
			else
				self:_notifySelect()
			end
			return true
		end
	elseif event == "char" then
		local ch = ...
		if self:isFocused() and ch and #ch > 0 then
			self:_handleTypeSearch(ch:sub(1, 1))
			return true
		end
	elseif event == "paste" then
		local text = ...
		if self:isFocused() and text and #text > 0 then
			self:_handleTypeSearch(text:sub(1, 1))
			return true
		end
	end

	return false
end

local function chart_clamp(value, minValue, maxValue)
	if value < minValue then
		return minValue
	end
	if value > maxValue then
		return maxValue
	end
	return value
end

local function chart_draw_line(pixelLayer, x0, y0, x1, y1, color)
	if not pixelLayer then
		return
	end
	color = color or colors.white
	local dx = math.abs(x1 - x0)
	local sx = x0 < x1 and 1 or -1
	local dy = -math.abs(y1 - y0)
	local sy = y0 < y1 and 1 or -1
	local err = dx + dy
	while true do
		pixelLayer.pixel(x0, y0, color)
		if x0 == x1 and y0 == y1 then
			break
		end
		local e2 = 2 * err
		if e2 >= dy then
			err = err + dy
			x0 = x0 + sx
		end
		if e2 <= dx then
			err = err + dx
			y0 = y0 + sy
		end
	end
end

function Chart:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.height = math.max(3, math.floor(baseConfig.height or 8))
	baseConfig.width = math.max(6, math.floor(baseConfig.width or 18))
	local instance = setmetatable({}, Chart)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.data = {}
	instance.labels = {}
	instance.chartType = "bar"
	instance.showAxis = not (config and config.showAxis == false)
	instance.showLabels = not (config and config.showLabels == false)
	instance.placeholder = (config and config.placeholder) or "No data"
	instance.barColor = (config and config.barColor) or colors.lightBlue
	instance.highlightColor = (config and config.highlightColor) or colors.orange
	instance.axisColor = (config and config.axisColor) or (instance.fg or colors.white)
	instance.lineColor = (config and config.lineColor) or (instance.fg or colors.white)
	if config and type(config.rangePadding) == "number" then
		instance.rangePadding = math.max(0, config.rangePadding)
	else
		instance.rangePadding = 0.05
	end
	if config and type(config.minValue) == "number" then
		instance.minValue = config.minValue
	else
		instance.minValue = nil
	end
	if config and type(config.maxValue) == "number" then
		instance.maxValue = config.maxValue
	else
		instance.maxValue = nil
	end
	instance.onSelect = config and config.onSelect or nil
	instance.selectedIndex = nil
	instance._lastLayout = nil
	if config and config.chartType then
		instance:setChartType(config.chartType)
	end
	if config and config.labels then
		instance:setLabels(config.labels)
	end
	if config and config.data then
		instance:setData(config.data)
	end
	if config and config.selectedIndex then
		instance:setSelectedIndex(config.selectedIndex, true)
	else
		instance:_clampSelection(true)
	end
	return instance
end

function Chart:_emitSelect()
	if self.onSelect then
		local index = self.selectedIndex
		local value = index and self.data[index] or nil
		self.onSelect(self, index, value)
	end
end

function Chart:_clampSelection(suppressEvent)
	local count = #self.data
	if count == 0 then
		if self.selectedIndex ~= nil then
			self.selectedIndex = nil
			if not suppressEvent then
				self:_emitSelect()
			end
		end
		return
	end
	local index = self.selectedIndex
	if type(index) ~= "number" then
		index = 1
	else
		index = math.floor(index)
		if index < 1 then
			index = 1
		elseif index > count then
			index = count
		end
	end
	if self.selectedIndex ~= index then
		self.selectedIndex = index
		if not suppressEvent then
			self:_emitSelect()
		end
	end
end

function Chart:setData(data)
	expect(1, data, "table")
	local cleaned = {}
	for i = 1, #data do
		local value = data[i]
		if type(value) ~= "number" then
			value = tonumber(value) or 0
		end
		cleaned[i] = value
	end
	self.data = cleaned
	self:_clampSelection(false)
end

function Chart:getData()
	return self.data
end

function Chart:setLabels(labels)
	if labels == nil then
		self.labels = {}
		return
	end
	expect(1, labels, "table")
	local cleaned = {}
	for i = 1, #labels do
		local label = labels[i]
		if label ~= nil then
			cleaned[i] = tostring(label)
		end
	end
	self.labels = cleaned
end

function Chart:getLabels()
	return self.labels
end

function Chart:getLabel(index)
	if type(index) ~= "number" then
		return nil
	end
	if not self.labels then
		return nil
	end
	return self.labels[math.floor(index)]
end

function Chart:setChartType(chartType)
	if chartType == nil then
		return
	end
	expect(1, chartType, "string")
	local normalized = chartType:lower()
	if normalized ~= "bar" and normalized ~= "line" then
		error("Chart type must be 'bar' or 'line'", 2)
	end
	self.chartType = normalized
end

function Chart:setShowAxis(show)
	self.showAxis = not not show
end

function Chart:setShowLabels(show)
	self.showLabels = not not show
end

function Chart:setPlaceholder(text)
	if text ~= nil then
		expect(1, text, "string")
	end
	self.placeholder = text or ""
end

function Chart:setRange(minValue, maxValue)
	if minValue ~= nil then
		expect(1, minValue, "number")
	end
	if maxValue ~= nil then
		expect(2, maxValue, "number")
	end
	self.minValue = minValue
	self.maxValue = maxValue
end

function Chart:setRangePadding(padding)
	expect(1, padding, "number")
	if padding < 0 then
		padding = 0
	end
	self.rangePadding = padding
end

function Chart:setOnSelect(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onSelect = handler
end

function Chart:setSelectedIndex(index, suppressEvent)
	if index == nil then
		if self.selectedIndex ~= nil then
			self.selectedIndex = nil
			if not suppressEvent then
				self:_emitSelect()
			end
		end
		return false
	end
	expect(1, index, "number")
	local count = #self.data
	if count == 0 then
		if self.selectedIndex ~= nil then
			self.selectedIndex = nil
			if not suppressEvent then
				self:_emitSelect()
			end
		end
		return false
	end
	local clamped = math.floor(index)
	if clamped < 1 then
		clamped = 1
	elseif clamped > count then
		clamped = count
	end
	if self.selectedIndex == clamped then
		return false
	end
	self.selectedIndex = clamped
	if not suppressEvent then
		self:_emitSelect()
	end
	return true
end

function Chart:getSelectedIndex()
	return self.selectedIndex
end

function Chart:getSelectedValue()
	local index = self.selectedIndex
	if not index then
		return nil
	end
	return self.data[index]
end

function Chart:onFocusChanged(focused)
	if focused then
		self:_clampSelection(true)
	end
end

function Chart:_indexFromPoint(px)
	local layout = self._lastLayout
	if not layout or not layout.bars then
		return nil
	end
	local bars = layout.bars
	for i = 1, #bars do
		local span = bars[i]
		if px >= span.left and px <= span.right then
			return i
		end
	end
	if px < layout.innerX or px >= layout.innerX + layout.innerWidth then
		return nil
	end
	if layout.innerWidth <= 0 then
		return nil
	end
	local relative = px - layout.innerX
	local index = math.floor(relative * layout.dataCount / layout.innerWidth) + 1
	if index < 1 or index > layout.dataCount then
		return nil
	end
	return index
end

function Chart:_moveSelection(delta)
	if delta == 0 then
		return false
	end
	local count = #self.data
	if count == 0 then
		return false
	end
	local index = self.selectedIndex or (delta > 0 and 0 or count + 1)
	index = index + delta
	if index < 1 then
		index = 1
	elseif index > count then
		index = count
	end
	return self:setSelectedIndex(index, false)
end

function Chart:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local border = self.border
	local borderThickness = (border and border.thickness) or 0
	local leftPad = (border and border.left) and borderThickness or 0
	local rightPad = (border and border.right) and borderThickness or 0
	local topPad = (border and border.top) and borderThickness or 0
	local bottomPad = (border and border.bottom) and borderThickness or 0

	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerHeight = math.max(0, height - topPad - bottomPad)

	self._lastLayout = nil

	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end

	local dataCount = #self.data
	if dataCount == 0 then
		local placeholder = self.placeholder or ""
		if placeholder ~= "" then
			local text = placeholder
			if #text > innerWidth then
				text = text:sub(1, innerWidth)
			end
			local textX = innerX + math.floor((innerWidth - #text) / 2)
			if textX < innerX then
				textX = innerX
			end
			local textY = innerY + math.floor((innerHeight - 1) / 2)
			textLayer.text(textX, textY, text, colors.lightGray, bg)
		end
		return
	end

	local labelHeight = (self.showLabels and innerHeight >= 2) and 1 or 0
	local axisHeight = (self.showAxis and (innerHeight - labelHeight) >= 2) and 1 or 0
	local plotHeight = innerHeight - axisHeight - labelHeight
	if plotHeight < 1 then
		plotHeight = innerHeight
		axisHeight = 0
		labelHeight = 0
	end

	local plotTop = innerY
	local plotBottom = plotTop + plotHeight - 1
	local axisY = axisHeight > 0 and (plotBottom + 1) or nil
	local labelY
	if labelHeight > 0 then
		if axisY then
			labelY = axisY + 1
		else
			labelY = plotBottom + 1
		end
		if labelY > innerY + innerHeight - 1 then
			labelY = innerY + innerHeight - 1
		end
	end

	local computedMin = math.huge
	local computedMax = -math.huge
	for i = 1, dataCount do
		local value = self.data[i] or 0
		if value < computedMin then
			computedMin = value
		end
		if value > computedMax then
			computedMax = value
		end
	end
	if computedMin == math.huge then
		computedMin = 0
	end
	if computedMax == -math.huge then
		computedMax = 0
	end
	local minValue = type(self.minValue) == "number" and self.minValue or computedMin
	local maxValue = type(self.maxValue) == "number" and self.maxValue or computedMax
	if maxValue == minValue then
		maxValue = maxValue + 1
		minValue = minValue - 1
	end
	local range = maxValue - minValue
	if range <= 0 then
		range = 1
		maxValue = minValue + range
	end
	local padding = self.rangePadding or 0
	if padding > 0 then
		local span = maxValue - minValue
		local padAmount = span * padding
		if padAmount == 0 then
			padAmount = padding
		end
		minValue = minValue - padAmount
		maxValue = maxValue + padAmount
		range = maxValue - minValue
		if range <= 0 then
			range = 1
			maxValue = minValue + range
		end
	end

	local bars = {}
	for i = 1, dataCount do
		local left = innerX + math.floor((i - 1) * innerWidth / dataCount)
		local right = innerX + math.floor(i * innerWidth / dataCount) - 1
		if right < left then
			right = left
		end
		if right > innerX + innerWidth - 1 then
			right = innerX + innerWidth - 1
		end
		local widthPixels = right - left + 1
		if widthPixels < 1 then
			widthPixels = 1
		end
		bars[i] = {
			left = left,
			right = right,
			width = widthPixels,
			center = left + math.floor((widthPixels - 1) / 2)
		}
	end

	if self.chartType == "bar" then
		for i = 1, dataCount do
			local value = self.data[i] or 0
			local ratio = 0
			if range > 0 then
				ratio = (value - minValue) / range
			end
			ratio = chart_clamp(ratio, 0, 1)
			local barHeight = math.floor(ratio * plotHeight + 0.5)
			if plotHeight > 0 and barHeight <= 0 and value > minValue then
				barHeight = 1
			end
			if barHeight > plotHeight then
				barHeight = plotHeight
			end
			if barHeight < 1 then
				barHeight = 1
			end
			local top = plotBottom - barHeight + 1
			if top < plotTop then
				top = plotTop
				barHeight = plotBottom - plotTop + 1
			end
			local color = self.barColor or fg
			if self.selectedIndex == i then
				color = self.highlightColor or color
			end
			fill_rect(textLayer, bars[i].left, top, bars[i].width, barHeight, color, color)
		end
	else
		local points = {}
		for i = 1, dataCount do
			local value = self.data[i] or 0
			local ratio = 0
			if range > 0 then
				ratio = (value - minValue) / range
			end
			ratio = chart_clamp(ratio, 0, 1)
			local offsetRange = math.max(plotHeight - 1, 0)
			local pointY = plotBottom - math.floor(ratio * offsetRange + 0.5)
			if pointY < plotTop then
				pointY = plotTop
			end
			if pointY > plotBottom then
				pointY = plotBottom
			end
			points[i] = { x = bars[i].center, y = pointY }
		end
		for i = 2, #points do
			local prev = points[i - 1]
			local current = points[i]
			chart_draw_line(pixelLayer, prev.x, prev.y, current.x, current.y, self.lineColor or fg)
		end
		for i = 1, #points do
			local point = points[i]
			local color = self.lineColor or fg
			local marker = "o"
			if self.selectedIndex == i then
				color = self.highlightColor or colors.orange
				marker = "O"
			end
			textLayer.text(point.x, point.y, marker, color, bg)
		end
	end

	if axisY then
		fill_rect(textLayer, innerX, axisY, innerWidth, 1, bg, bg)
		local axisLine = string.rep("-", innerWidth)
		textLayer.text(innerX, axisY, axisLine, self.axisColor or fg, bg)
	end

	if labelY then
		fill_rect(textLayer, innerX, labelY, innerWidth, 1, bg, bg)
		local labels = self.labels or {}
		for i = 1, dataCount do
			local label = labels[i]
			if label and label ~= "" then
				label = tostring(label)
				local span = bars[i]
				local maxWidth = span.width
				if maxWidth > 0 and #label > maxWidth then
					label = label:sub(1, maxWidth)
				end
				local labelX = span.left + math.floor((span.width - #label) / 2)
				if labelX < span.left then
					labelX = span.left
				end
				if labelX + #label - 1 > span.right then
					labelX = span.right - #label + 1
				end
				local color = (self.selectedIndex == i) and (self.highlightColor or colors.orange) or (self.axisColor or fg)
				textLayer.text(labelX, labelY, label, color, bg)
			end
		end
	end

	self._lastLayout = {
		innerX = innerX,
		innerWidth = innerWidth,
		dataCount = dataCount,
		bars = bars
	}
end

function Chart:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" or event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			local index = self:_indexFromPoint(x)
			if index then
				self:setSelectedIndex(index, false)
			end
			return true
		end
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			if direction > 0 then
				self:_moveSelection(1)
			elseif direction < 0 then
				self:_moveSelection(-1)
			end
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.left then
			self:_moveSelection(-1)
			return true
		elseif keyCode == keys.right then
			self:_moveSelection(1)
			return true
		elseif keyCode == keys.home then
			self:setSelectedIndex(1, false)
			return true
		elseif keyCode == keys["end"] then
			local count = #self.data
			if count > 0 then
				self:setSelectedIndex(count, false)
			end
			return true
		elseif keyCode == keys.enter or keyCode == keys.space then
			self:_emitSelect()
			return true
		end
	end

	return false
end

function List:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.height = baseConfig.height or 5
	baseConfig.width = baseConfig.width or 16
	local instance = setmetatable({}, List)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.items = {}
	if config and type(config.items) == "table" then
		for i = 1, #config.items do
			local value = config.items[i]
			if value ~= nil then
				instance.items[#instance.items + 1] = tostring(value)
			end
		end
	end
	if type(config.selectedIndex) == "number" then
		instance.selectedIndex = math.floor(config.selectedIndex)
	elseif #instance.items > 0 then
		instance.selectedIndex = 1
	else
		instance.selectedIndex = 0
	end
	instance.highlightBg = (config and config.highlightBg) or colors.lightGray
	instance.highlightFg = (config and config.highlightFg) or colors.black
	instance.placeholder = (config and config.placeholder) or nil
	instance.onSelect = config and config.onSelect or nil
	instance.scrollOffset = 1
	instance.typeSearchTimeout = (config and config.typeSearchTimeout) or 0.75
	instance._typeSearch = { buffer = "", lastTime = 0 }
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance.scrollbar = normalize_scrollbar(config and config.scrollbar, instance.bg or colors.black, instance.fg or colors.white)
	instance:_normalizeSelection(true)
	return instance
end

function List:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	return leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight
end

function List:_getInnerHeight()
	local _, _, _, _, _, innerHeight = self:_getInnerMetrics()
	if innerHeight < 1 then
		innerHeight = 1
	end
	return innerHeight
end

function List:_computeLayoutMetrics()
	local ax, ay = self:getAbsoluteRect()
	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	local innerX = ax + leftPad
	local innerY = ay + topPad
	if innerWidth <= 0 or innerHeight <= 0 then
		return {
			innerX = innerX,
			innerY = innerY,
			innerWidth = innerWidth,
			innerHeight = innerHeight,
			contentWidth = 0,
			scrollbarWidth = 0,
			scrollbarStyle = nil,
			scrollbarX = innerX
		}
	end
	local scrollbarWidth, scrollbarStyle = resolve_scrollbar(self.scrollbar, #self.items, innerHeight, innerWidth)
	if scrollbarWidth > 0 and innerWidth - scrollbarWidth < 1 then
		scrollbarWidth = math.max(0, innerWidth - 1)
		if scrollbarWidth <= 0 then
			scrollbarWidth = 0
			scrollbarStyle = nil
		end
	end
	local contentWidth = innerWidth - scrollbarWidth
	if contentWidth < 1 then
		contentWidth = innerWidth
		scrollbarWidth = 0
		scrollbarStyle = nil
	end
	return {
		innerX = innerX,
		innerY = innerY,
		innerWidth = innerWidth,
		innerHeight = innerHeight,
		contentWidth = contentWidth,
		scrollbarWidth = scrollbarWidth,
		scrollbarStyle = scrollbarStyle,
		scrollbarX = innerX + contentWidth
	}
end

function List:_clampScroll()
	local innerHeight = self:_getInnerHeight()
	local maxOffset = math.max(1, #self.items - innerHeight + 1)
	if self.scrollOffset < 1 then
		self.scrollOffset = 1
	elseif self.scrollOffset > maxOffset then
		self.scrollOffset = maxOffset
	end
end

function List:_ensureSelectionVisible()
	if self.selectedIndex < 1 or self.selectedIndex > #self.items then
		self:_clampScroll()
		return
	end
	local innerHeight = self:_getInnerHeight()
	if self.selectedIndex < self.scrollOffset then
		self.scrollOffset = self.selectedIndex
	elseif self.selectedIndex > self.scrollOffset + innerHeight - 1 then
		self.scrollOffset = self.selectedIndex - innerHeight + 1
	end
	self:_clampScroll()
end

function List:_normalizeSelection(silent)
	local count = #self.items
	if count == 0 then
		self.selectedIndex = 0
		self.scrollOffset = 1
		return
	end
	if self.selectedIndex < 1 then
		self.selectedIndex = 1
	elseif self.selectedIndex > count then
		self.selectedIndex = count
	end
	self:_ensureSelectionVisible()
	if not silent then
		self:_notifySelect()
	end
end

function List:getItems()
	local copy = {}
	for i = 1, #self.items do
		copy[i] = self.items[i]
	end
	return copy
end

function List:setItems(items)
	expect(1, items, "table")
	local list = {}
	for i = 1, #items do
		local value = items[i]
		if value ~= nil then
			list[#list + 1] = tostring(value)
		end
	end
	local previousItem = self:getSelectedItem()
	local previousIndex = self.selectedIndex
	self.items = list
	if #list == 0 then
		self.selectedIndex = 0
		self.scrollOffset = 1
		if (previousIndex ~= 0 or previousItem ~= nil) and self.onSelect then
			self.onSelect(self, nil, 0)
		end
		return
	end
	self:_normalizeSelection(true)
	local currentItem = self:getSelectedItem()
	if (previousIndex ~= self.selectedIndex) or (previousItem ~= currentItem) then
		self:_notifySelect()
	end
end

function List:getSelectedItem()
	if self.selectedIndex >= 1 and self.selectedIndex <= #self.items then
		return self.items[self.selectedIndex]
	end
	return nil
end

function List:setSelectedIndex(index, suppressEvent)
	if #self.items == 0 then
		self.selectedIndex = 0
		self.scrollOffset = 1
		return
	end
	expect(1, index, "number")
	index = math.floor(index)
	if index < 1 then
		index = 1
	elseif index > #self.items then
		index = #self.items
	end
	if self.selectedIndex ~= index then
		self.selectedIndex = index
		self:_ensureSelectionVisible()
		if not suppressEvent then
			self:_notifySelect()
		end
	else
		self:_ensureSelectionVisible()
	end
end

function List:getSelectedIndex()
	return self.selectedIndex
end

function List:setOnSelect(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onSelect = handler
end

function List:setPlaceholder(placeholder)
	if placeholder ~= nil then
		expect(1, placeholder, "string")
	end
	self.placeholder = placeholder
end

function List:setHighlightColors(bg, fg)
	if bg ~= nil then
		expect(1, bg, "number")
		self.highlightBg = bg
	end
	if fg ~= nil then
		expect(2, fg, "number")
		self.highlightFg = fg
	end
end

function List:setScrollbar(scrollbar)
	self.scrollbar = normalize_scrollbar(scrollbar, self.bg or colors.black, self.fg or colors.white)
	self:_clampScroll()
end

function List:_notifySelect()
	if self.onSelect then
		self.onSelect(self, self:getSelectedItem(), self.selectedIndex)
	end
end

function List:onFocusChanged(focused)
	if not focused and self._typeSearch then
		self._typeSearch.buffer = ""
		self._typeSearch.lastTime = 0
	end
end

function List:_itemIndexFromPoint(x, y)
	if not self:containsPoint(x, y) then
		return nil
	end
	local metrics = self:_computeLayoutMetrics()
	if metrics.innerWidth <= 0 or metrics.innerHeight <= 0 or metrics.contentWidth <= 0 then
		return nil
	end
	local innerX = metrics.innerX
	local innerY = metrics.innerY
	if x < innerX or x >= innerX + metrics.contentWidth then
		return nil
	end
	if y < innerY or y >= innerY + metrics.innerHeight then
		return nil
	end
	local row = y - innerY
	local index = self.scrollOffset + row
	if index < 1 or index > #self.items then
		return nil
	end
	return index
end

function List:_moveSelection(delta)
	if #self.items == 0 then
		return
	end
	local index = self.selectedIndex
	if index < 1 then
		index = 1
	end
	index = index + delta
	if index < 1 then
		index = 1
	elseif index > #self.items then
		index = #self.items
	end
	self:setSelectedIndex(index)
end

function List:_scrollBy(delta)
	if delta == 0 then
		return
	end
	self.scrollOffset = self.scrollOffset + delta
	self:_clampScroll()
end

function List:_handleTypeSearch(ch)
	if not ch or ch == "" then
		return
	end
	local entry = self._typeSearch
	if not entry then
		entry = { buffer = "", lastTime = 0 }
		self._typeSearch = entry
	end
	local now = osLib.clock()
	local timeout = self.typeSearchTimeout or 0.75
	if now - (entry.lastTime or 0) > timeout then
		entry.buffer = ""
	end
	entry.buffer = entry.buffer .. ch:lower()
	entry.lastTime = now
	self:_searchForPrefix(entry.buffer)
end

function List:_searchForPrefix(prefix)
	if not prefix or prefix == "" then
		return
	end
	local count = #self.items
	if count == 0 then
		return
	end
	local start = self.selectedIndex >= 1 and self.selectedIndex or 0
	for offset = 1, count do
		local index = ((start + offset - 1) % count) + 1
		local item = self.items[index]
		if item and item:lower():sub(1, #prefix) == prefix then
			self:setSelectedIndex(index)
			return
		end
	end
end

function List:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local metrics = self:_computeLayoutMetrics()
	local innerWidth = metrics.innerWidth
	local innerHeight = metrics.innerHeight
	local contentWidth = metrics.contentWidth
	if innerWidth <= 0 or innerHeight <= 0 or contentWidth <= 0 then
		return
	end
	local innerX = metrics.innerX
	local innerY = metrics.innerY
	local scrollbarWidth = metrics.scrollbarWidth
	local scrollbarStyle = metrics.scrollbarStyle

	local count = #self.items
	local baseBg = bg
	local highlightBg = self.highlightBg or colors.lightGray
	local highlightFg = self.highlightFg or colors.black

	if count == 0 then
		for row = 0, innerHeight - 1 do
			textLayer.text(innerX, innerY + row, string.rep(" ", contentWidth), fg, baseBg)
		end
		if scrollbarWidth > 0 then
			local sbBg = (scrollbarStyle and scrollbarStyle.background) or baseBg
			fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
		end
		local placeholder = self.placeholder
		if type(placeholder) == "string" and #placeholder > 0 then
			local display = placeholder
			if #display > contentWidth then
				display = display:sub(1, contentWidth)
			end
			local startX = innerX + math.floor((contentWidth - #display) / 2)
			if startX < innerX then
				startX = innerX
			end
			textLayer.text(startX, innerY, display, colors.lightGray, baseBg)
		end
		if scrollbarStyle then
			draw_vertical_scrollbar(textLayer, metrics.scrollbarX, innerY, innerHeight, 0, innerHeight, 0, scrollbarStyle)
		end
		return
	end

	for row = 0, innerHeight - 1 do
		local lineY = innerY + row
		local index = self.scrollOffset + row
		if index > count then
			textLayer.text(innerX, lineY, string.rep(" ", contentWidth), fg, baseBg)
		else
			local item = self.items[index] or ""
			if #item > contentWidth then
				item = item:sub(1, contentWidth)
			end
			local padded = item
			if #padded < contentWidth then
				padded = padded .. string.rep(" ", contentWidth - #padded)
			end
			local drawBg = baseBg
			local drawFg = fg
			if index == self.selectedIndex then
				drawBg = highlightBg
				drawFg = highlightFg
			end
			textLayer.text(innerX, lineY, padded, drawFg, drawBg)
		end
	end

	if scrollbarWidth > 0 then
		local sbBg = (scrollbarStyle and scrollbarStyle.background) or baseBg
		fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, innerHeight, sbBg, sbBg)
		if scrollbarStyle then
			draw_vertical_scrollbar(textLayer, metrics.scrollbarX, innerY, innerHeight, #self.items, innerHeight, math.max(0, self.scrollOffset - 1), scrollbarStyle)
		end
	end
end

function List:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.innerHeight then
					local relativeY = y - metrics.innerY
					local zeroOffset = math.max(0, self.scrollOffset - 1)
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.innerHeight, #self.items, metrics.innerHeight, zeroOffset)
					if newOffset ~= zeroOffset then
						self.scrollOffset = newOffset + 1
						self:_clampScroll()
					end
					return true
				end
			end
			local index = self:_itemIndexFromPoint(x, y)
			if index then
				self:setSelectedIndex(index)
			end
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.innerHeight then
					local relativeY = y - metrics.innerY
					local zeroOffset = math.max(0, self.scrollOffset - 1)
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.innerHeight, #self.items, metrics.innerHeight, zeroOffset)
					if newOffset ~= zeroOffset then
						self.scrollOffset = newOffset + 1
						self:_clampScroll()
					end
					return true
				end
			end
			local index = self:_itemIndexFromPoint(x, y)
			if index then
				self:setSelectedIndex(index)
			end
			return true
		end
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			if direction > 0 then
				self:_scrollBy(1)
			elseif direction < 0 then
				self:_scrollBy(-1)
			end
			return true
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.up then
			self:_moveSelection(-1)
			return true
		elseif keyCode == keys.down then
			self:_moveSelection(1)
			return true
		elseif keyCode == keys.pageUp then
			self:_moveSelection(-self:_getInnerHeight())
			return true
		elseif keyCode == keys.pageDown then
			self:_moveSelection(self:_getInnerHeight())
			return true
		elseif keyCode == keys.home then
			if #self.items > 0 then
				self:setSelectedIndex(1)
			end
			return true
		elseif keyCode == keys["end"] then
			if #self.items > 0 then
				self:setSelectedIndex(#self.items)
			end
			return true
		elseif keyCode == keys.enter or keyCode == keys.space then
			self:_notifySelect()
			return true
		end
	elseif event == "char" then
		local ch = ...
		if self:isFocused() and ch and #ch > 0 then
			self:_handleTypeSearch(ch:sub(1, 1))
			return true
		end
	elseif event == "paste" then
		local text = ...
		if self:isFocused() and text and #text > 0 then
			self:_handleTypeSearch(text:sub(1, 1))
			return true
		end
	end

	return false
end

function ComboBox:new(app, config)
	config = config or {}
	local baseConfig = clone_table(config) or {}
	baseConfig.focusable = true
	baseConfig.height = baseConfig.height or 3
	baseConfig.width = baseConfig.width or 16
	local instance = setmetatable({}, ComboBox)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.items = {}
	if config and type(config.items) == "table" then
		for i = 1, #config.items do
			local value = config.items[i]
			if value ~= nil then
				instance.items[#instance.items + 1] = tostring(value)
			end
		end
	end
	instance.dropdownBg = (config and config.dropdownBg) or colors.black
	instance.dropdownFg = (config and config.dropdownFg) or colors.white
	instance.highlightBg = (config and config.highlightBg) or colors.lightBlue
	instance.highlightFg = (config and config.highlightFg) or colors.black
	instance.placeholder = (config and config.placeholder) or "Select..."
	instance.onChange = config and config.onChange or nil
	if config and type(config.selectedIndex) == "number" then
		instance.selectedIndex = math.floor(config.selectedIndex)
	elseif #instance.items > 0 then
		instance.selectedIndex = 1
	else
		instance.selectedIndex = 0
	end
	instance:_normalizeSelection()
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance._open = false
	instance._hoverIndex = nil
	return instance
end

function ComboBox:_normalizeSelection()
	if #self.items == 0 then
		self.selectedIndex = 0
		return
	end
	if self.selectedIndex < 1 then
		self.selectedIndex = 1
	elseif self.selectedIndex > #self.items then
		self.selectedIndex = #self.items
	end
end

function ComboBox:setItems(items)
	expect(1, items, "table")
	local list = {}
	for i = 1, #items do
		local value = items[i]
		if value ~= nil then
			list[#list + 1] = tostring(value)
		end
	end
	local previousItem = self:getSelectedItem()
	local previousIndex = self.selectedIndex
	self.items = list
	if #list == 0 then
		self.selectedIndex = 0
		if previousIndex ~= 0 or previousItem ~= nil then
			self:_notifyChange()
		end
		self:_setOpen(false)
		return
	end
	self:_normalizeSelection()
	local currentItem = self:getSelectedItem()
	if previousIndex ~= self.selectedIndex or previousItem ~= currentItem then
		self:_notifyChange()
	end
	if self._open then
		self._hoverIndex = self.selectedIndex
	end
end

function ComboBox:getSelectedItem()
	if self.selectedIndex >= 1 and self.selectedIndex <= #self.items then
		return self.items[self.selectedIndex]
	end
	return nil
end

function ComboBox:setSelectedIndex(index, suppressEvent)
	if index == nil then
		return
	end
	expect(1, index, "number")
	if #self.items == 0 then
		self.selectedIndex = 0
		return
	end
	index = math.floor(index)
	if index < 1 then
		index = 1
	elseif index > #self.items then
		index = #self.items
	end
	if self.selectedIndex ~= index then
		self.selectedIndex = index
		if not suppressEvent then
			self:_notifyChange()
		end
	end
	if self._open then
		self._hoverIndex = self.selectedIndex
	end
end

function ComboBox:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

function ComboBox:_notifyChange()
	if self.onChange then
		self.onChange(self, self:getSelectedItem(), self.selectedIndex)
	end
end

function ComboBox:_setOpen(open)
	open = not not open
	if open and #self.items == 0 then
		open = false
	end
	if self._open == open then
		return
	end
	self._open = open
	if open then
		if self.app then
			self.app:_registerPopup(self)
		end
		if self.selectedIndex >= 1 and self.selectedIndex <= #self.items then
			self._hoverIndex = self.selectedIndex
		elseif #self.items > 0 then
			self._hoverIndex = 1
		else
			self._hoverIndex = nil
		end
	else
		if self.app then
			self.app:_unregisterPopup(self)
		end
		self._hoverIndex = nil
	end
end

function ComboBox:onFocusChanged(focused)
	if not focused then
		self:_setOpen(false)
	end
end

function ComboBox:_isPointInDropdown(x, y)
	if not self._open or #self.items == 0 then
		return false
	end
	local ax, ay, width, height = self:getAbsoluteRect()
	local startY = ay + height
	return x >= ax and x < ax + width and y >= startY and y < startY + #self.items
end

function ComboBox:_indexFromPoint(x, y)
	if not self:_isPointInDropdown(x, y) then
		return nil
	end
	local _, ay, _, height = self:getAbsoluteRect()
	local index = y - (ay + height) + 1
	if index < 1 or index > #self.items then
		return nil
	end
	return index
end

function ComboBox:_handlePress(x, y)
	local ax, ay, width, height = self:getAbsoluteRect()
	if width <= 0 or height <= 0 then
		return false
	end

	if self:containsPoint(x, y) then
		self.app:setFocus(self)
		if self._open then
			self:_setOpen(false)
		else
			self:_setOpen(true)
		end
		return true
	end

	if self:_isPointInDropdown(x, y) then
		local index = self:_indexFromPoint(x, y)
		if index then
			self:setSelectedIndex(index)
		end
		self.app:setFocus(self)
		self:_setOpen(false)
		return true
	end

	if self._open then
		self:_setOpen(false)
	end
	return false
end

function ComboBox:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end

	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0

	local innerX = ax + leftPad
	local innerWidth = math.max(0, width - leftPad - rightPad)
	local innerY = ay + topPad
	local innerHeight = math.max(0, height - topPad - bottomPad)

	local arrowWidth = innerWidth > 0 and 1 or 0
	local contentWidth = math.max(0, innerWidth - arrowWidth)
	local textY
	if innerHeight > 0 then
		textY = innerY + math.floor((innerHeight - 1) / 2)
	else
		textY = ay
	end

	local display = self:getSelectedItem()
	if not display or display == "" then
		display = self.placeholder or ""
	end

	if contentWidth > 0 then
		if #display > contentWidth then
			display = display:sub(1, contentWidth)
		end
		local padding = math.max(0, contentWidth - #display)
		local padded = display .. string.rep(" ", padding)
		textLayer.text(innerX, textY, padded, fg, bg)
	end

	if arrowWidth > 0 then
		local arrow = self._open and string.char(30) or string.char(31)
		local arrowX = innerX + innerWidth - 1
		textLayer.text(arrowX, textY, arrow, fg, bg)
	end
end

function ComboBox:_drawDropdown(textLayer, pixelLayer)
	if not self._open or #self.items == 0 or self.visible == false then
		return
	end

	local ax, ay, width, height = self:getAbsoluteRect()
	local dropdownY = ay + height
	local dropHeight = #self.items
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local itemX = ax + leftPad
	local itemWidth = math.max(0, width - leftPad - rightPad)
	local highlightIndex = self._hoverIndex or (self.selectedIndex > 0 and self.selectedIndex or nil)
	local bottomPad = (border and border.bottom) and 1 or 0
	local dropdownHeight = dropHeight + bottomPad

	fill_rect(textLayer, ax, dropdownY, width, dropdownHeight, self.dropdownBg, self.dropdownBg)
	clear_border_characters(textLayer, ax, dropdownY, width, dropdownHeight)

	for index = 1, dropHeight do
		local itemY = dropdownY + index - 1
		local item = self.items[index] or ""
		local isHighlighted = highlightIndex ~= nil and highlightIndex == index
		local itemBg = isHighlighted and (self.highlightBg or self.dropdownBg) or self.dropdownBg
		local itemFg = isHighlighted and (self.highlightFg or self.dropdownFg) or self.dropdownFg
		if itemWidth > 0 then
			local label = item
			if #label > itemWidth then
				label = label:sub(1, itemWidth)
			end
			local padding = math.max(0, itemWidth - #label)
			local padded = label .. string.rep(" ", padding)
			textLayer.text(itemX, itemY, padded, itemFg, itemBg)
		end
	end

	if self.border then
		local dropBorder = clone_table(self.border)
		if dropBorder then
			dropBorder.top = false
			draw_border(pixelLayer, ax, dropdownY, width, dropdownHeight, dropBorder, self.dropdownBg)
		end
	end
end

function ComboBox:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		return self:_handlePress(x, y)
	elseif event == "monitor_touch" then
		local _, x, y = ...
		return self:_handlePress(x, y)
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) or self:_isPointInDropdown(x, y) then
			self.app:setFocus(self)
			if direction > 0 then
				self:setSelectedIndex(self.selectedIndex + 1)
			elseif direction < 0 then
				self:setSelectedIndex(self.selectedIndex - 1)
			end
			return true
		end
	elseif event == "mouse_move" then
		local x, y = ...
		if self._open then
			self._hoverIndex = self:_indexFromPoint(x, y)
		end
	elseif event == "mouse_drag" then
		local _, x, y = ...
		if self._open then
			self._hoverIndex = self:_indexFromPoint(x, y)
		end
	elseif event == "key" then
		if not self:isFocused() then
			return false
		end
		local keyCode = ...
		if keyCode == keys.down then
			self:setSelectedIndex(self.selectedIndex + 1)
			return true
		elseif keyCode == keys.up then
			self:setSelectedIndex(self.selectedIndex - 1)
			return true
		elseif keyCode == keys.home then
			self:setSelectedIndex(1)
			return true
		elseif keyCode == keys["end"] then
			self:setSelectedIndex(#self.items)
			return true
		elseif keyCode == keys.enter or keyCode == keys.space then
			if self._open then
				self:_setOpen(false)
			else
				self:_setOpen(true)
			end
			return true
		elseif keyCode == keys.escape then
			if self._open then
				self:_setOpen(false)
				return true
			end
		end
	elseif event == "char" then
		if not self:isFocused() or #self.items == 0 then
			return false
		end
		local ch = ...
		if ch and #ch > 0 then
			local lower = ch:sub(1, 1):lower()
			local start = self.selectedIndex >= 1 and self.selectedIndex or 0
			for offset = 1, #self.items do
				local index = ((start + offset - 1) % #self.items) + 1
				local item = self.items[index]
				if item and item:sub(1, 1):lower() == lower then
					self:setSelectedIndex(index)
					return true
				end
			end
		end
	end

	return false
end

local TextBox = {}
TextBox.__index = TextBox
setmetatable(TextBox, { __index = Widget })

local LUA_KEYWORDS = {
	["and"] = true,
	["break"] = true,
	["do"] = true,
	["else"] = true,
	["elseif"] = true,
	["end"] = true,
	["false"] = true,
	["for"] = true,
	["function"] = true,
	["goto"] = true,
	["if"] = true,
	["in"] = true,
	["local"] = true,
	["nil"] = true,
	["not"] = true,
	["or"] = true,
	["repeat"] = true,
	["return"] = true,
	["then"] = true,
	["true"] = true,
	["until"] = true,
	["while"] = true
}

local LUA_BUILTINS = {
	print = true,
	ipairs = true,
	pairs = true,
	next = true,
	math = true,
	table = true,
	string = true,
	coroutine = true,
	os = true,
	tonumber = true,
	tostring = true,
	type = true,
	pcall = true,
	xpcall = true,
	select = true
}

local function split_lines(text)
	if text == nil or text == "" then
		return { "" }
	end
	local result = {}
	local startIndex = 1
	local length = #text
	while startIndex <= length do
		local newline = text:find("\n", startIndex, true)
		if not newline then
			result[#result + 1] = text:sub(startIndex)
			break
		end
		result[#result + 1] = text:sub(startIndex, newline - 1)
		startIndex = newline + 1
		if startIndex > length then
			result[#result + 1] = ""
			break
		end
	end
	if #result == 0 then
		result[1] = ""
	end
	return result
end

local function join_lines(lines)
	return table.concat(lines, "\n")
end

local function clampi(value, minValue, maxValue)
	if value < minValue then
		return minValue
	end
	if value > maxValue then
		return maxValue
	end
	return value
end

local function compare_positions(aLine, aCol, bLine, bCol)
	if aLine < bLine then
		return -1
	end
	if aLine > bLine then
		return 1
	end
	if aCol < bCol then
		return -1
	end
	if aCol > bCol then
		return 1
	end
	return 0
end

local function position_in_range(line, col, startLine, startCol, endLine, endCol)
	if compare_positions(line, col, startLine, startCol) < 0 then
		return false
	end
	if compare_positions(line, col, endLine, endCol) >= 0 then
		return false
	end
	return true
end

local function normalize_syntax_config(config)
	if config == nil then
		return nil
	end
	if config == true then
		config = "lua"
	end
	if type(config) == "string" then
		if config == "lua" then
			return {
				language = "lua",
				keywords = LUA_KEYWORDS,
				builtins = LUA_BUILTINS,
				keywordColor = colors.orange,
				commentColor = colors.lightGray,
				stringColor = colors.yellow,
				numberColor = colors.cyan,
				builtinColor = colors.lightBlue
			}
		end
		return nil
	end
	if type(config) == "table" then
		local preset = {}
		for k, v in pairs(config) do
			preset[k] = v
		end
		if preset.language == "lua" then
			preset.keywords = preset.keywords or LUA_KEYWORDS
			preset.builtins = preset.builtins or LUA_BUILTINS
			if preset.keywordColor == nil then
				preset.keywordColor = colors.orange
			end
			if preset.commentColor == nil then
				preset.commentColor = colors.lightGray
			end
			if preset.stringColor == nil then
				preset.stringColor = colors.yellow
			end
			if preset.numberColor == nil then
				preset.numberColor = colors.cyan
			end
			if preset.builtinColor == nil then
				preset.builtinColor = colors.lightBlue
			end
		end
		return preset
	end
	return nil
end

function TextBox:new(app, config)
	config = config or {}
	local baseConfig = {}
	for k, v in pairs(config) do
		baseConfig[k] = v
	end
	baseConfig.focusable = true
	baseConfig.width = math.max(4, math.floor(baseConfig.width or 16))
	baseConfig.height = math.max(1, math.floor(baseConfig.height or (config.multiline ~= false and 5 or 1)))
	local instance = setmetatable({}, TextBox)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.placeholder = config.placeholder or ""
	instance.onChange = config.onChange or nil
	instance.onCursorMove = config.onCursorMove or nil
	instance.maxLength = config.maxLength or nil
	instance.multiline = config.multiline ~= false
	instance.tabWidth = math.max(1, math.floor(config.tabWidth or 4))
	instance.selectionBg = config.selectionBg or colors.lightGray
	instance.selectionFg = config.selectionFg or colors.black
	instance.overlayBg = config.overlayBg or colors.gray
	instance.overlayFg = config.overlayFg or colors.white
	instance.overlayActiveBg = config.overlayActiveBg or colors.orange
	instance.overlayActiveFg = config.overlayActiveFg or colors.black
	instance.autocomplete = config.autocomplete
	instance.autocompleteAuto = not not config.autocompleteAuto
	instance.autocompleteMaxItems = math.max(1, math.floor(config.autocompleteMaxItems or 5))
	instance.autocompleteBg = config.autocompleteBg or colors.gray
	instance.autocompleteFg = config.autocompleteFg or colors.white
	instance.autocompleteGhostColor = config.autocompleteGhostColor or colors.lightGray
	instance.syntax = normalize_syntax_config(config.syntax)
	instance._lines = { "" }
	instance.text = ""
	instance._cursorLine = 1
	instance._cursorCol = 1
	instance._preferredCol = 1
	instance._selectionAnchor = nil
	instance._scrollX = 0
	instance._scrollY = 0
	instance._shiftDown = false
	instance._ctrlDown = false
	instance._dragging = false
	instance._dragButton = nil
	instance._dragAnchor = nil
	instance._find = {
		visible = false,
		activeField = "find",
		findText = "",
		replaceText = "",
		matchCase = false,
		matches = {},
		index = 0
	}
	instance._autocompleteState = {
		visible = false,
		items = {},
		selectedIndex = 1,
		anchorLine = 1,
		anchorCol = 1,
		prefix = "",
		ghost = "",
		trigger = "auto"
	}
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance.scrollbar = normalize_scrollbar(config.scrollbar, instance.bg or colors.black, instance.fg or colors.white)
	instance:_setTextInternal(config.text or "", true, true)
	if config.cursorPos then
		instance:_moveCursorToIndex(config.cursorPos)
	end
	instance:_ensureCursorVisible()
	return instance
end

function TextBox:setOnCursorMove(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onCursorMove = handler
end

function TextBox:setScrollbar(scrollbar)
	self.scrollbar = normalize_scrollbar(scrollbar, self.bg or colors.black, self.fg or colors.white)
end

function TextBox:onFocusChanged(_focused)
	self:_ensureCursorVisible()
end

function TextBox:_applyMaxLength(text)
	if not self.maxLength then
		return text
	end
	if #text <= self.maxLength then
		return text
	end
	return text:sub(1, self.maxLength)
end

function TextBox:_syncTextFromLines()
	self.text = join_lines(self._lines)
end

function TextBox:_setTextInternal(text, resetCursor, suppressEvent)
	text = tostring(text or "")
	text = self:_applyMaxLength(text)
	self._lines = split_lines(text)
	self:_syncTextFromLines()
	if resetCursor then
		self._cursorLine = #self._lines
		self._cursorCol = (#self._lines[#self._lines] or 0) + 1
	else
		self._cursorLine = clampi(self._cursorLine, 1, #self._lines)
		local currentLine = self._lines[self._cursorLine] or ""
		self._cursorCol = clampi(self._cursorCol, 1, #currentLine + 1)
	end
	self._preferredCol = self._cursorCol
	self._selectionAnchor = nil
	self:_ensureCursorVisible()
	if not suppressEvent then
		self:_notifyChange()
		self:_notifyCursorChange()
	end
end

function TextBox:_indexToPosition(index)
	index = clampi(index or 1, 1, #self.text + 1)
	local remaining = index - 1
	for line = 1, #self._lines do
		local lineText = self._lines[line]
		local lineLength = #lineText
		if remaining <= lineLength then
			return line, remaining + 1
		end
		remaining = remaining - (lineLength + 1)
	end
	local lastLine = #self._lines
	local lastLength = #self._lines[lastLine]
	return lastLine, lastLength + 1
end

function TextBox:_moveCursorToIndex(index)
	local line, col = self:_indexToPosition(index)
	self:_setCursorPosition(line, col)
end

function TextBox:getCursorPosition()
	return self._cursorLine, self._cursorCol
end

function TextBox:getLineCount()
	return #self._lines
end

function TextBox:_getInnerMetrics()
	local border = self.border
	local leftPad = (border and border.left) and 1 or 0
	local rightPad = (border and border.right) and 1 or 0
	local topPad = (border and border.top) and 1 or 0
	local bottomPad = (border and border.bottom) and 1 or 0
	local ax, ay = self:getAbsoluteRect()
	local innerX = ax + leftPad
	local innerY = ay + topPad
	local innerWidth = math.max(0, self.width - leftPad - rightPad)
	local innerHeight = math.max(0, self.height - topPad - bottomPad)
	return innerX, innerY, innerWidth, innerHeight, leftPad, topPad, bottomPad
end

function TextBox:_getOverlayHeight(innerHeight)
	if not self._find.visible then
		return 0
	end
	return math.min(2, innerHeight)
end

function TextBox:_computeLayoutMetrics()
	local ax, ay, width, height = self:getAbsoluteRect()
	local innerX, innerY, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		innerX = ax
		innerY = ay
		innerWidth = math.max(1, width)
		innerHeight = math.max(1, height)
	end
	local overlayHeight = self:_getOverlayHeight(innerHeight)
	local contentHeight = math.max(1, innerHeight - overlayHeight)
	local scrollbarWidth, scrollbarStyle = resolve_scrollbar(self.scrollbar, #self._lines, contentHeight, innerWidth)
	if scrollbarWidth > 0 and innerWidth - scrollbarWidth < 1 then
		if scrollbarStyle and (scrollbarStyle.alwaysVisible or #self._lines > contentHeight) then
			scrollbarWidth = math.max(0, innerWidth - 1)
		else
			scrollbarWidth = 0
			scrollbarStyle = nil
		end
	end
	if scrollbarWidth <= 0 then
		scrollbarWidth = 0
		scrollbarStyle = nil
	end
	local contentWidth = innerWidth - scrollbarWidth
	if contentWidth < 1 then
		contentWidth = innerWidth
		scrollbarWidth = 0
		scrollbarStyle = nil
	end
	return {
		innerX = innerX,
		innerY = innerY,
		innerWidth = innerWidth,
		innerHeight = innerHeight,
		contentWidth = contentWidth,
		contentHeight = contentHeight,
		overlayHeight = overlayHeight,
		scrollbarWidth = scrollbarWidth,
		scrollbarStyle = scrollbarStyle,
		scrollbarX = innerX + contentWidth
	}
end

function TextBox:_getContentSize()
	local metrics = self:_computeLayoutMetrics()
	return math.max(1, metrics.contentWidth), math.max(1, metrics.contentHeight)
end

function TextBox:_ensureCursorVisible()
	local contentWidth, contentHeight = self:_getContentSize()
	local firstVisibleLine = self._scrollY + 1
	local lastVisibleLine = self._scrollY + contentHeight
	if self._cursorLine < firstVisibleLine then
		self._scrollY = self._cursorLine - 1
	elseif self._cursorLine > lastVisibleLine then
		self._scrollY = self._cursorLine - contentHeight
	end
	if self._scrollY < 0 then
		self._scrollY = 0
	end
	local maxScrollY = math.max(0, #self._lines - contentHeight)
	if self._scrollY > maxScrollY then
		self._scrollY = maxScrollY
	end
	local firstVisibleCol = self._scrollX + 1
	local lastVisibleCol = self._scrollX + contentWidth
	if self._cursorCol < firstVisibleCol then
		self._scrollX = self._cursorCol - 1
	elseif self._cursorCol > lastVisibleCol then
		self._scrollX = self._cursorCol - contentWidth
	end
	if self._scrollX < 0 then
		self._scrollX = 0
	end
	local currentLine = self._lines[self._cursorLine] or ""
	local maxScrollX = math.max(0, #currentLine + 1 - contentWidth)
	if self._scrollX > maxScrollX then
		self._scrollX = maxScrollX
	end
end

function TextBox:_notifyChange()
	if self.onChange then
		self.onChange(self, self.text)
	end
end

function TextBox:_notifyCursorChange()
	if self.onCursorMove then
		self.onCursorMove(self, self._cursorLine, self._cursorCol, self:getSelectionLength())
	end
end

function TextBox:_hasSelection()
	if not self._selectionAnchor then
		return false
	end
	if self._selectionAnchor.line ~= self._cursorLine then
		return true
	end
	return self._selectionAnchor.col ~= self._cursorCol
end

function TextBox:getSelectionLength()
	if not self:_hasSelection() then
		return 0
	end
	local startLine, startCol, endLine, endCol = self:_getSelectionRange()
	local text = self:_collectRange(startLine, startCol, endLine, endCol)
	return #text
end

function TextBox:getSelectionText()
	if not self:_hasSelection() then
		return ""
	end
	local startLine, startCol, endLine, endCol = self:_getSelectionRange()
	return self:_collectRange(startLine, startCol, endLine, endCol)
end

function TextBox:_getSelectionRange()
	if not self:_hasSelection() then
		return nil
	end
	local anchor = self._selectionAnchor
	local anchorLine, anchorCol = anchor.line, anchor.col
	local cursorLine, cursorCol = self._cursorLine, self._cursorCol
	if compare_positions(anchorLine, anchorCol, cursorLine, cursorCol) <= 0 then
		return anchorLine, anchorCol, cursorLine, cursorCol
	else
		return cursorLine, cursorCol, anchorLine, anchorCol
	end
end

function TextBox:_collectRange(startLine, startCol, endLine, endCol)
	if startLine == endLine then
		return (self._lines[startLine] or ""):sub(startCol, endCol - 1)
	end
	local parts = {}
	parts[#parts + 1] = (self._lines[startLine] or ""):sub(startCol)
	for line = startLine + 1, endLine - 1 do
		parts[#parts + 1] = self._lines[line] or ""
	end
	parts[#parts + 1] = (self._lines[endLine] or ""):sub(1, endCol - 1)
	return table.concat(parts, "\n")
end

function TextBox:_clearSelection()
	self._selectionAnchor = nil
end

function TextBox:_removeRange(startLine, startCol, endLine, endCol)
	if startLine == endLine then
		local lineText = self._lines[startLine]
		self._lines[startLine] = lineText:sub(1, startCol - 1) .. lineText:sub(endCol)
	else
		local firstPart = self._lines[startLine]:sub(1, startCol - 1)
		local lastPart = self._lines[endLine]:sub(endCol)
		for line = endLine, startLine + 1, -1 do
			table.remove(self._lines, line)
		end
		self._lines[startLine] = firstPart .. lastPart
	end
	if #self._lines == 0 then
		self._lines[1] = ""
	end
end

function TextBox:_insertAt(line, col, text)
	if text == nil or text == "" then
		return line, col
	end
	local insertLines = split_lines(text)
	local current = self._lines[line]
	local before = current:sub(1, col - 1)
	local after = current:sub(col)
	self._lines[line] = before .. insertLines[1]
	local lastLineIndex = line
	for i = 2, #insertLines do
		lastLineIndex = lastLineIndex + 1
		table.insert(self._lines, lastLineIndex, insertLines[i])
	end
	self._lines[lastLineIndex] = self._lines[lastLineIndex] .. after
	local finalCol = (#self._lines[lastLineIndex] - #after) + 1
	return lastLineIndex, finalCol
end

function TextBox:_deleteSelection(suppressEvent)
	local startLine, startCol, endLine, endCol = self:_getSelectionRange()
	if not startLine then
		return 0
	end
	local removedText = self:_collectRange(startLine, startCol, endLine, endCol)
	self:_removeRange(startLine, startCol, endLine, endCol)
	self._cursorLine = startLine
	self._cursorCol = startCol
	self._preferredCol = self._cursorCol
	self:_clearSelection()
	self:_syncTextFromLines()
	self:_ensureCursorVisible()
	if not suppressEvent then
		self:_notifyChange()
	end
	self:_notifyCursorChange()
	return #removedText
end

function TextBox:_replaceSelection(text, suppressEvent)
	local removed = 0
	if self:_hasSelection() then
		removed = self:_deleteSelection(true)
	end
	local currentLength = #self.text
	if self.maxLength then
		local allowed = self.maxLength - currentLength
		if #text > allowed then
			text = text:sub(1, allowed)
		end
	end
	local insertLine, insertCol = self:_insertAt(self._cursorLine, self._cursorCol, text)
	self._cursorLine = insertLine
	self._cursorCol = insertCol
	self._preferredCol = self._cursorCol
	self:_clearSelection()
	self:_syncTextFromLines()
	self:_ensureCursorVisible()
	if not suppressEvent then
		self:_notifyChange()
	end
	self:_notifyCursorChange()
	return true
end

function TextBox:_insertTextAtCursor(text)
	if not text or text == "" then
		return false
	end
	return self:_replaceSelection(text, false)
end

function TextBox:_insertCharacter(ch)
	if not ch or ch == "" then
		return false
	end
	return self:_insertTextAtCursor(ch)
end

function TextBox:_insertNewline()
	if not self.multiline then
		return false
	end
	return self:_insertTextAtCursor("\n")
end

function TextBox:_insertTab()
	local spaces = string.rep(" ", self.tabWidth)
	return self:_insertTextAtCursor(spaces)
end

function TextBox:_deleteBackward()
	if self:_hasSelection() then
		return self:_deleteSelection(false) > 0
	end
	if self._cursorLine == 1 and self._cursorCol == 1 then
		return false
	end
	if self._cursorCol > 1 then
		local lineText = self._lines[self._cursorLine]
		self._lines[self._cursorLine] = lineText:sub(1, self._cursorCol - 2) .. lineText:sub(self._cursorCol)
		self._cursorCol = self._cursorCol - 1
	else
		local previousLine = self._lines[self._cursorLine - 1]
		local currentLine = self._lines[self._cursorLine]
		local previousLength = #previousLine
		self._lines[self._cursorLine - 1] = previousLine .. currentLine
		table.remove(self._lines, self._cursorLine)
		self._cursorLine = self._cursorLine - 1
		self._cursorCol = previousLength + 1
	end
	self._preferredCol = self._cursorCol
	self:_syncTextFromLines()
	self:_ensureCursorVisible()
	self:_notifyChange()
	self:_notifyCursorChange()
	return true
end

function TextBox:_deleteForward()
	if self:_hasSelection() then
		return self:_deleteSelection(false) > 0
	end
	local currentLine = self._lines[self._cursorLine]
	if self._cursorCol <= #currentLine then
		self._lines[self._cursorLine] = currentLine:sub(1, self._cursorCol - 1) .. currentLine:sub(self._cursorCol + 1)
	else
		if self._cursorLine >= #self._lines then
			return false
		end
		local nextLine = table.remove(self._lines, self._cursorLine + 1)
		self._lines[self._cursorLine] = currentLine .. nextLine
	end
	self:_syncTextFromLines()
	self:_ensureCursorVisible()
	self:_notifyChange()
	self:_notifyCursorChange()
	return true
end

function TextBox:_setCursorPosition(line, col, options)
	options = options or {}
	line = clampi(line, 1, #self._lines)
	local lineText = self._lines[line] or ""
	col = clampi(col, 1, #lineText + 1)
	if options.extendSelection then
		if not self._selectionAnchor then
			self._selectionAnchor = { line = self._cursorLine, col = self._cursorCol }
		end
	else
		self:_clearSelection()
	end
	self._cursorLine = line
	self._cursorCol = col
	if not options.preservePreferred then
		self._preferredCol = col
	end
	if self._selectionAnchor and self._selectionAnchor.line == self._cursorLine and self._selectionAnchor.col == self._cursorCol then
		self:_clearSelection()
	end
	self:_ensureCursorVisible()
	self:_notifyCursorChange()
	if not options.keepAutocomplete then
		self:_hideAutocomplete()
	end
end

function TextBox:_moveCursorLeft(extend)
	if self:_hasSelection() and not extend then
		local startLine, startCol = self:_getSelectionRange()
		self:_setCursorPosition(startLine, startCol)
		return
	end
	if self._cursorCol > 1 then
		self:_setCursorPosition(self._cursorLine, self._cursorCol - 1, { extendSelection = extend })
	elseif self._cursorLine > 1 then
		local targetLine = self._cursorLine - 1
		local targetCol = (#self._lines[targetLine] or 0) + 1
		self:_setCursorPosition(targetLine, targetCol, { extendSelection = extend })
	end
end

function TextBox:_moveCursorRight(extend)
	if self:_hasSelection() and not extend then
		local _, _, endLine, endCol = self:_getSelectionRange()
		self:_setCursorPosition(endLine, endCol)
		return
	end
	local lineText = self._lines[self._cursorLine]
	if self._cursorCol <= #lineText then
		self:_setCursorPosition(self._cursorLine, self._cursorCol + 1, { extendSelection = extend })
	elseif self._cursorLine < #self._lines then
		self:_setCursorPosition(self._cursorLine + 1, 1, { extendSelection = extend })
	end
end

function TextBox:_moveCursorVertical(delta, extend)
	local targetLine = clampi(self._cursorLine + delta, 1, #self._lines)
	local lineText = self._lines[targetLine] or ""
	local targetCol = clampi(self._preferredCol, 1, #lineText + 1)
	self:_setCursorPosition(targetLine, targetCol, { extendSelection = extend, preservePreferred = true })
end

function TextBox:_moveCursorUp(extend)
	self:_moveCursorVertical(-1, extend)
end

function TextBox:_moveCursorDown(extend)
	self:_moveCursorVertical(1, extend)
end

function TextBox:_moveCursorLineStart(extend)
	self:_setCursorPosition(self._cursorLine, 1, { extendSelection = extend })
end

function TextBox:_moveCursorLineEnd(extend)
	local lineText = self._lines[self._cursorLine]
	self:_setCursorPosition(self._cursorLine, #lineText + 1, { extendSelection = extend })
end

function TextBox:_moveCursorDocumentStart(extend)
	self:_setCursorPosition(1, 1, { extendSelection = extend })
end

function TextBox:_moveCursorDocumentEnd(extend)
	local lastLine = #self._lines
	local lastLength = #self._lines[lastLine]
	self:_setCursorPosition(lastLine, lastLength + 1, { extendSelection = extend })
end

function TextBox:_selectAll()
	self._selectionAnchor = { line = 1, col = 1 }
	self:_setCursorPosition(#self._lines, (#self._lines[#self._lines] or 0) + 1, { extendSelection = true, keepAutocomplete = true })
end

function TextBox:_scrollLines(delta)
	if delta == 0 then
		return
	end
	local _, contentHeight = self:_getContentSize()
	local maxScroll = math.max(0, #self._lines - contentHeight)
	self._scrollY = clampi(self._scrollY + delta, 0, maxScroll)
end

function TextBox:_scrollColumns(delta)
	if delta == 0 then
		return
	end
	local contentWidth = select(1, self:_getContentSize())
	local currentLine = self._lines[self._cursorLine] or ""
	local maxScroll = math.max(0, #currentLine - contentWidth)
	self._scrollX = clampi(self._scrollX + delta, 0, maxScroll)
end

function TextBox:_cursorFromPoint(x, y)
	local metrics = self:_computeLayoutMetrics()
	local contentX = metrics.innerX
	local contentY = metrics.innerY
	local contentWidth = math.max(1, metrics.contentWidth)
	local contentHeight = math.max(1, metrics.contentHeight)
	local relX = clampi(x - contentX, 0, contentWidth - 1)
	local relY = clampi(y - contentY, 0, contentHeight - 1)
	local line = clampi(self._scrollY + relY + 1, 1, #self._lines)
	local lineText = self._lines[line] or ""
	local col = clampi(self._scrollX + relX + 1, 1, #lineText + 1)
	return line, col
end

function TextBox:_computeSyntaxColors(lineText)
	local syntax = self.syntax
	if not syntax then
		return nil
	end
	local map = {}
	local defaultColor = syntax.defaultColor or self.fg or colors.white
	for i = 1, #lineText do
		map[i] = defaultColor
	end
	-- strings
	local i = 1
	while i <= #lineText do
		local ch = lineText:sub(i, i)
		if ch == '"' or ch == "'" then
			local quote = ch
			map[i] = syntax.stringColor or map[i]
			i = i + 1
			while i <= #lineText do
				map[i] = syntax.stringColor or map[i]
				local current = lineText:sub(i, i)
				if current == quote and lineText:sub(i - 1, i - 1) ~= "\\" then
					i = i + 1
					break
				end
				i = i + 1
			end
		else
			i = i + 1
		end
	end
	-- numbers
	for startIdx, numberValue, endIdx in lineText:gmatch("()(%d+%.?%d*)()") do
		if syntax.numberColor then
			for pos = startIdx, endIdx - 1 do
				if map[pos] == defaultColor then
					map[pos] = syntax.numberColor
				end
			end
		end
	end
	-- keywords/builtins
	for startIdx, word, endIdx in lineText:gmatch("()([%a_][%w_]*)()") do
		local lower = word:lower()
		if syntax.keywords and syntax.keywords[lower] then
			if syntax.keywordColor then
				for pos = startIdx, endIdx - 1 do
					if map[pos] == defaultColor then
						map[pos] = syntax.keywordColor
					end
				end
			end
		elseif syntax.builtins and syntax.builtins[word] then
			if syntax.builtinColor then
				for pos = startIdx, endIdx - 1 do
					if map[pos] == defaultColor then
						map[pos] = syntax.builtinColor
					end
				end
			end
		end
	end
	-- comments
	local commentStart = lineText:find("--", 1, true)
	if commentStart then
		local commentColor = syntax.commentColor or defaultColor
		for pos = commentStart, #lineText do
			map[pos] = commentColor
		end
	end
	return map
end

local function append_segment(segments, text, fg, bg)
	if text == "" then
		return
	end
	local last = segments[#segments]
	if last and last.fg == fg and last.bg == bg then
		last.text = last.text .. text
	else
		segments[#segments + 1] = { text = text, fg = fg, bg = bg }
	end
end

function TextBox:_buildLineSegments(lineIndex, contentWidth, baseFg, baseBg, selectionRange)
	local lineText = self._lines[lineIndex] or ""
	local colorMap = self:_computeSyntaxColors(lineText)
	local startCol = self._scrollX + 1
	local segments = {}
	for offset = 0, contentWidth - 1 do
		local col = startCol + offset
		local ch
		if col <= #lineText then
			ch = lineText:sub(col, col)
		else
			ch = " "
		end
		local fg = colorMap and colorMap[col] or baseFg
		local bg = baseBg
		if selectionRange and position_in_range(lineIndex, col, selectionRange.startLine, selectionRange.startCol, selectionRange.endLine, selectionRange.endCol) then
			bg = self.selectionBg
			fg = self.selectionFg
		end
		append_segment(segments, ch, fg, bg)
	end
	return segments, lineText, colorMap
end

function TextBox:_drawSegments(textLayer, x, y, segments)
	local cursor = x
	for i = 1, #segments do
		local seg = segments[i]
		if seg.text ~= "" then
			textLayer.text(cursor, y, seg.text, seg.fg, seg.bg)
			cursor = cursor + #seg.text
		end
	end
end

function TextBox:_drawFindOverlay(textLayer, innerX, innerY, contentWidth, innerHeight)
	if not self._find.visible then
		return
	end
	local overlayHeight = self:_getOverlayHeight(innerHeight)
	if overlayHeight <= 0 then
		return
	end
	local bg = self.overlayBg or self.bg or colors.gray
	local fg = self.overlayFg or self.fg or colors.white
	local activeBg = self.overlayActiveBg or colors.orange
	local activeFg = self.overlayActiveFg or colors.black
	local overlayY = innerY + innerHeight - overlayHeight
	for row = 0, overlayHeight - 1 do
		textLayer.text(innerX, overlayY + row, string.rep(" ", contentWidth), fg, bg)
	end
	local find = self._find
	local matches = #find.matches
	local indexDisplay = matches > 0 and string.format("%d/%d", math.max(1, find.index), matches) or "0/0"
	local caseDisplay = find.matchCase and "CASE" or "case"
	local findLabel = string.format("Find: %s  %s  %s", find.findText, indexDisplay, caseDisplay)
	local replaceLabel = "Replace: " .. find.replaceText
	local truncFind = findLabel
	if #truncFind > contentWidth then
		truncFind = truncFind:sub(1, contentWidth)
	end
	local truncReplace = replaceLabel
	if #truncReplace > contentWidth then
		truncReplace = truncReplace:sub(1, contentWidth)
	end
	textLayer.text(innerX, overlayY, truncFind .. string.rep(" ", math.max(0, contentWidth - #truncFind)), fg, bg)
	textLayer.text(innerX, overlayY + math.max(overlayHeight - 1, 0), truncReplace .. string.rep(" ", math.max(0, contentWidth - #truncReplace)), fg, bg)
	local activeX, activeY, activeText
	if find.activeField == "find" then
		activeX = innerX + 6
		activeY = overlayY
		activeText = find.findText
	else
		activeX = innerX + 9
		activeY = overlayY + math.max(overlayHeight - 1, 0)
		activeText = find.replaceText
	end
	local display = activeText
	if #display > contentWidth - (activeX - innerX) then
		display = display:sub(1, contentWidth - (activeX - innerX))
	end
	textLayer.text(activeX, activeY, display .. string.rep(" ", math.max(0, contentWidth - (activeX - innerX) - #display)), activeFg, activeBg)
	if overlayHeight >= 2 then
		local info = "Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
		if #info > contentWidth then
			info = info:sub(1, contentWidth)
		end
		textLayer.text(innerX, overlayY + overlayHeight - 1, info .. string.rep(" ", math.max(0, contentWidth - #info)), fg, bg)
	end
end

function TextBox:_hideAutocomplete()
	local ac = self._autocompleteState
	ac.visible = false
	ac.items = {}
	ac.ghost = ""
	ac.prefix = ""
	ac.trigger = "auto"
	ac.selectedIndex = 1
	ac.anchorLine = self._cursorLine
	ac.anchorCol = self._cursorCol
end

function TextBox:_updateAutocomplete(trigger)
	if not self.autocomplete then
		return
	end
	local lineText = self._lines[self._cursorLine] or ""
	local col = self._cursorCol - 1
	local startCol = col
	while startCol >= 1 do
		local ch = lineText:sub(startCol, startCol)
		if not ch:match("[%w_]") then
			break
		end
		startCol = startCol - 1
	end
	startCol = startCol + 1
	local prefix = lineText:sub(startCol, col)
	if prefix == "" and trigger ~= "manual" then
		self:_hideAutocomplete()
		return
	end
	local suggestions = {}
	if type(self.autocomplete) == "function" then
		local ok, result = pcall(self.autocomplete, self, prefix)
		if ok and type(result) == "table" then
			suggestions = result
		end
	elseif type(self.autocomplete) == "table" then
		suggestions = self.autocomplete
	end
	local items = {}
	local lowerPrefix = prefix:lower()
	for i = 1, #suggestions do
		local entry = suggestions[i]
		if type(entry) == "string" then
			local labelLower = entry:lower()
			if prefix == "" or labelLower:sub(1, #lowerPrefix) == lowerPrefix then
				items[#items + 1] = { label = entry, insert = entry }
			end
		elseif type(entry) == "table" and entry.label then
			local label = entry.label
			local labelLower = label:lower()
			if prefix == "" or labelLower:sub(1, #lowerPrefix) == lowerPrefix then
				items[#items + 1] = { label = label, insert = entry.insert or label }
			end
		end
	end
	if #items == 0 then
		self:_hideAutocomplete()
		return
	end
	local ac = self._autocompleteState
	ac.trigger = trigger or "auto"
	ac.visible = true
	ac.items = {}
	for i = 1, math.min(self.autocompleteMaxItems, #items) do
		ac.items[i] = items[i]
	end
	ac.selectedIndex = 1
	ac.anchorLine = self._cursorLine
	ac.anchorCol = startCol
	ac.prefix = prefix
	ac.ghost = self:_computeAutocompleteGhost(ac.items[ac.selectedIndex], ac.prefix, ac.trigger)
end

function TextBox:_computeAutocompleteGhost(item, prefix, trigger)
	if not item then
		return ""
	end
	local insertText = item.insert or item.label or ""
	if insertText == "" then
		return ""
	end
	if prefix == "" then
		if trigger == "manual" then
			return insertText
		end
		return ""
	end
	local lowerInsert = insertText:lower()
	local lowerPrefix = prefix:lower()
	if lowerInsert:sub(1, #prefix) ~= lowerPrefix then
		return ""
	end
	return insertText:sub(#prefix + 1)
end

function TextBox:_acceptAutocomplete()
	local ac = self._autocompleteState
	if not ac.visible or #ac.items == 0 then
		return false
	end
	local item = ac.items[ac.selectedIndex]
	if not item then
		return false
	end
	local endLine, endCol = self._cursorLine, self._cursorCol
	self._selectionAnchor = { line = ac.anchorLine, col = ac.anchorCol }
	self._cursorLine = endLine
	self._cursorCol = endCol
	self:_replaceSelection(item.insert or item.label or "", false)
	self:_hideAutocomplete()
	return true
end

function TextBox:_moveAutocompleteSelection(delta)
	local ac = self._autocompleteState
	if not ac.visible then
		return
	end
	local count = #ac.items
	if count == 0 then
		return
	end
	ac.selectedIndex = ((ac.selectedIndex - 1 + delta) % count) + 1
	ac.ghost = self:_computeAutocompleteGhost(ac.items[ac.selectedIndex], ac.prefix, ac.trigger)
end

function TextBox:_toggleFindOverlay(mode)
	local find = self._find
	if find.visible and (not mode or find.activeField == mode) then
		self:_closeFindOverlay()
		return
	end
	find.visible = true
	if mode then
		find.activeField = mode
	end
	if self:_hasSelection() and mode == "find" then
		find.findText = self:getSelectionText()
	end
	self:_updateFindMatches(true)
end

function TextBox:_closeFindOverlay()
	local find = self._find
	if find.visible then
		find.visible = false
		find.matches = {}
		find.index = 0
	end
end

function TextBox:_toggleFindField()
	local find = self._find
	if not find.visible then
		return
	end
	if find.activeField == "find" then
		find.activeField = "replace"
	else
		find.activeField = "find"
	end
end

function TextBox:_editFindFieldText(text)
	local find = self._find
	if not find.visible then
		return
	end
	text = tostring(text or "")
	text = text:gsub("[\r\n]", " ")
	if find.activeField == "find" then
		find.findText = find.findText .. text
		self:_updateFindMatches(true)
	elseif find.activeField == "replace" then
		find.replaceText = find.replaceText .. text
	end
end

function TextBox:_handleOverlayBackspace()
	local find = self._find
	if not find.visible then
		return false
	end
	if find.activeField == "find" then
		if #find.findText == 0 then
			return false
		end
		find.findText = find.findText:sub(1, -2)
		self:_updateFindMatches(true)
	else
		if #find.replaceText == 0 then
			return false
		end
		find.replaceText = find.replaceText:sub(1, -2)
	end
	return true
end

function TextBox:_updateFindMatches(resetIndex)
	local find = self._find
	find.matches = {}
	find.index = resetIndex and 0 or find.index
	if not find.visible or find.findText == "" then
		return
	end
	local search = find.findText
	local matchCase = find.matchCase
	for line = 1, #self._lines do
		local lineText = self._lines[line]
		local haystack = matchCase and lineText or lineText:lower()
		local needle = matchCase and search or search:lower()
		local startPos = 1
		while true do
			local s, e = haystack:find(needle, startPos, true)
			if not s then
				break
			end
			find.matches[#find.matches + 1] = {
				line = line,
				col = s,
				length = e - s + 1
			}
			startPos = s + 1
		end
	end
end

function TextBox:_selectMatch(match)
	if not match then
		return
	end
	self._selectionAnchor = { line = match.line, col = match.col }
	self:_setCursorPosition(match.line, match.col + match.length, { extendSelection = true, keepAutocomplete = true })
	self:_ensureCursorVisible()
	self:_notifyCursorChange()
end

function TextBox:_gotoMatch(step)
	local find = self._find
	if not find.visible then
		return false
	end
	self:_updateFindMatches(false)
	if #find.matches == 0 then
		return false
	end
	if find.index < 1 then
		local best = 1
		for i = 1, #find.matches do
			local match = find.matches[i]
			if compare_positions(match.line, match.col, self._cursorLine, self._cursorCol) >= 0 then
				best = i
				break
			end
		end
		find.index = best
	else
		find.index = ((find.index - 1 + step) % #find.matches) + 1
	end
	self:_selectMatch(find.matches[find.index])
	return true
end

function TextBox:_gotoNextMatch()
	return self:_gotoMatch(1)
end

function TextBox:_gotoPreviousMatch()
	return self:_gotoMatch(-1)
end

function TextBox:_replaceCurrentMatch()
	local find = self._find
	if not find.visible or #find.matches == 0 then
		return false
	end
	if find.index < 1 or find.index > #find.matches then
		find.index = 1
	end
	local match = find.matches[find.index]
	self._selectionAnchor = { line = match.line, col = match.col }
	self:_setCursorPosition(match.line, match.col + match.length, { extendSelection = true, keepAutocomplete = true })
	self:_replaceSelection(find.replaceText or "", false)
	self:_updateFindMatches(true)
	return true
end

function TextBox:_replaceAll()
	local find = self._find
	if not find.visible or find.findText == "" then
		return false
	end
	self:_updateFindMatches(true)
	if #find.matches == 0 then
		return false
	end
	for i = #find.matches, 1, -1 do
		local match = find.matches[i]
		local line = match.line
		local col = match.col
		local lineText = self._lines[line]
		self._lines[line] = lineText:sub(1, col - 1) .. (find.replaceText or "") .. lineText:sub(col + match.length)
	end
	self:_syncTextFromLines()
	self:_ensureCursorVisible()
	self:_notifyChange()
	self:_notifyCursorChange()
	self:_updateFindMatches(true)
	return true
end

function TextBox:_handleEscape()
	if self._find.visible then
		self:_closeFindOverlay()
		return true
	end
	if self:_hasSelection() then
		self:_clearSelection()
		self:_notifyCursorChange()
		return true
	end
	if self._autocompleteState.visible then
		self:_hideAutocomplete()
		return true
	end
	return false
end

function TextBox:_handleKey(keyCode, isHeld)
	if self._find.visible then
		if keyCode == keys.tab then
			self:_toggleFindField()
			return true
		elseif keyCode == keys.backspace then
			return self:_handleOverlayBackspace()
		elseif keyCode == keys.enter then
			if self._find.activeField == "find" then
				self:_gotoNextMatch()
			else
				self:_replaceCurrentMatch()
			end
			return true
		elseif keyCode == keys.delete then
			local find = self._find
			if find.activeField == "find" then
				find.findText = ""
				self:_updateFindMatches(true)
			else
				find.replaceText = ""
			end
			return true
		end
	end
	if self._ctrlDown then
		if keyCode == keys.a then
			self:_selectAll()
			return true
		elseif keyCode == keys.f then
			self:_toggleFindOverlay("find")
			return true
		elseif keyCode == keys.h then
			self:_toggleFindOverlay("replace")
			return true
		elseif keyCode == keys.g then
			if self._shiftDown then
				self:_gotoPreviousMatch()
			else
				self:_gotoNextMatch()
			end
			return true
		elseif keyCode == keys.space then
			self:_updateAutocomplete("manual")
			return true
		elseif keyCode == keys.r and self._shiftDown then
			self:_replaceAll()
			return true
		elseif keyCode == keys.f and self._shiftDown then
			local find = self._find
			find.matchCase = not find.matchCase
			self:_updateFindMatches(true)
			return true
		end
	end
	if self._autocompleteState.visible then
		if keyCode == keys.enter or keyCode == keys.tab then
			return self:_acceptAutocomplete()
		elseif keyCode == keys.up then
			self:_moveAutocompleteSelection(-1)
			return true
		elseif keyCode == keys.down then
			self:_moveAutocompleteSelection(1)
			return true
		elseif keyCode == keys.escape then
			self:_hideAutocomplete()
			return true
		end
	end
	if keyCode == keys.left then
		self:_moveCursorLeft(self._shiftDown)
		return true
	elseif keyCode == keys.right then
		self:_moveCursorRight(self._shiftDown)
		return true
	elseif keyCode == keys.up then
		self:_moveCursorUp(self._shiftDown)
		return true
	elseif keyCode == keys.down then
		self:_moveCursorDown(self._shiftDown)
		return true
	elseif keyCode == keys.home then
		if self._ctrlDown then
			self:_moveCursorDocumentStart(self._shiftDown)
		else
			self:_moveCursorLineStart(self._shiftDown)
		end
		return true
	elseif keyCode == keys["end"] then
		if self._ctrlDown then
			self:_moveCursorDocumentEnd(self._shiftDown)
		else
			self:_moveCursorLineEnd(self._shiftDown)
		end
		return true
	elseif keyCode == keys.backspace then
		return self:_deleteBackward()
	elseif keyCode == keys.delete then
		return self:_deleteForward()
	elseif keyCode == keys.enter then
		return self:_insertNewline()
	elseif keyCode == keys.tab then
		return self:_insertTab()
	elseif keyCode == keys.pageUp then
		self:_scrollLines(-math.max(1, select(2, self:_getContentSize()) - 1))
		return true
	elseif keyCode == keys.pageDown then
		self:_scrollLines(math.max(1, select(2, self:_getContentSize()) - 1))
		return true
	elseif keyCode == keys.escape then
		return self:_handleEscape()
	end
	return false
end

function TextBox:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end
	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white
	fill_rect(textLayer, ax, ay, width, height, bg, bg)
	clear_border_characters(textLayer, ax, ay, width, height)
	local metrics = self:_computeLayoutMetrics()
	local innerX = metrics.innerX
	local innerY = metrics.innerY
	local innerWidth = metrics.innerWidth
	local innerHeight = metrics.innerHeight
	local contentWidth = metrics.contentWidth
	local contentHeight = metrics.contentHeight
	local overlayHeight = metrics.overlayHeight
	local scrollbarWidth = metrics.scrollbarWidth
	local scrollbarStyle = metrics.scrollbarStyle
	local selectionRange
	local hasSelection = false
	if self:_hasSelection() then
		local startLine, startCol, endLine, endCol = self:_getSelectionRange()
		selectionRange = {
			startLine = startLine,
			startCol = startCol,
			endLine = endLine,
			endCol = endCol
		}
		hasSelection = true
	end
	local ac = self._autocompleteState
	local baseBg = bg
	for row = 0, contentHeight - 1 do
		local lineIndex = self._scrollY + row + 1
		local drawY = innerY + row
		if lineIndex > #self._lines then
			textLayer.text(innerX, drawY, string.rep(" ", contentWidth), fg, baseBg)
		else
			local segments, lineText, colorMap = self:_buildLineSegments(lineIndex, contentWidth, fg, baseBg, selectionRange)
			self:_drawSegments(textLayer, innerX, drawY, segments)
			if self:isFocused() and lineIndex == self._cursorLine then
				local cursorCol = self._cursorCol - self._scrollX - 1
				if cursorCol >= 0 and cursorCol < contentWidth then
					local ch
					if self._cursorCol <= #lineText then
						ch = lineText:sub(self._cursorCol, self._cursorCol)
					else
						ch = " "
					end
					local cursorFg = baseBg
					local cursorBg = fg
					textLayer.text(innerX + cursorCol, drawY, ch, cursorFg, cursorBg)
				end
			end
			if self:isFocused() and ac.visible and ac.ghost ~= "" and not hasSelection and lineIndex == ac.anchorLine then
				local ghostStartCol = ac.anchorCol + #ac.prefix
				local ghostOffset = ghostStartCol - self._scrollX - 1
				if ghostOffset < contentWidth then
					local ghostText = ac.ghost
					local lineLength = #lineText
					if ghostStartCol <= lineLength then
						local overlap = lineLength - ghostStartCol + 1
						if overlap >= #ghostText then
							ghostText = ""
						else
							ghostText = ghostText:sub(overlap + 1)
							ghostOffset = ghostOffset + overlap
						end
					end
					if ghostText ~= "" then
						if ghostOffset < 0 then
							local trim = -ghostOffset
							if trim >= #ghostText then
								ghostText = ""
							else
								ghostText = ghostText:sub(trim + 1)
								ghostOffset = 0
							end
						end
						if ghostText ~= "" and ghostOffset < contentWidth then
							local available = contentWidth - ghostOffset
							if available > 0 then
								if #ghostText > available then
									ghostText = ghostText:sub(1, available)
								end
								if ghostText ~= "" then
									textLayer.text(innerX + ghostOffset, drawY, ghostText, self.autocompleteGhostColor or colors.lightGray, baseBg)
								end
							end
						end
					end
				end
			end
		end
	end
	if self.text == "" and not self:isFocused() and self.placeholder ~= "" then
		local placeholder = self.placeholder
		if #placeholder > contentWidth then
			placeholder = placeholder:sub(1, contentWidth)
		end
		textLayer.text(innerX, innerY, placeholder .. string.rep(" ", math.max(0, contentWidth - #placeholder)), colors.lightGray, baseBg)
	end
	self:_drawFindOverlay(textLayer, innerX, innerY, contentWidth, innerHeight)
	if scrollbarStyle then
		local sbX = metrics.scrollbarX
		local sbBg = scrollbarStyle.background or bg
		fill_rect(textLayer, sbX, innerY, scrollbarWidth, contentHeight, sbBg, sbBg)
		draw_vertical_scrollbar(textLayer, sbX, innerY, contentHeight, #self._lines, contentHeight, self._scrollY, scrollbarStyle)
		if overlayHeight > 0 then
			fill_rect(textLayer, sbX, innerY + contentHeight, scrollbarWidth, overlayHeight, sbBg, sbBg)
		end
	elseif scrollbarWidth > 0 then
		fill_rect(textLayer, metrics.scrollbarX, innerY, scrollbarWidth, contentHeight + overlayHeight, bg, bg)
	end
	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end
end

function TextBox:handleEvent(event, ...)
	if not self.visible then
		return false
	end
	if event == "mouse_click" then
		local button, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.contentHeight then
					local relativeY = y - metrics.innerY
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.contentHeight, #self._lines, metrics.contentHeight, self._scrollY)
					if newOffset ~= self._scrollY then
						self._scrollY = newOffset
					end
					return true
				end
			end
			local line, col = self:_cursorFromPoint(x, y)
			if button == 1 then
				self:_setCursorPosition(line, col)
				self._dragging = true
				self._dragButton = button
				self._dragAnchor = { line = line, col = col }
			elseif button == 2 then
				self:_setCursorPosition(line, col)
			end
			return true
		end
	elseif event == "mouse_drag" then
		local button, x, y = ...
		if self._dragging and button == self._dragButton then
			local line, col = self:_cursorFromPoint(x, y)
			if not self._selectionAnchor and self._dragAnchor then
				self._selectionAnchor = { line = self._dragAnchor.line, col = self._dragAnchor.col }
			end
			self:_setCursorPosition(line, col, { extendSelection = true, keepAutocomplete = true })
			return true
		end
	elseif event == "mouse_up" then
		local button = ...
		if self._dragging and button == self._dragButton then
			self._dragging = false
			self._dragButton = nil
			self._dragAnchor = nil
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			local metrics = self:_computeLayoutMetrics()
			if metrics.scrollbarStyle and metrics.scrollbarWidth > 0 then
				local sbX = metrics.scrollbarX
				if x >= sbX and x < sbX + metrics.scrollbarWidth and y >= metrics.innerY and y < metrics.innerY + metrics.contentHeight then
					local relativeY = y - metrics.innerY
					local newOffset = scrollbar_click_to_offset(relativeY, metrics.contentHeight, #self._lines, metrics.contentHeight, self._scrollY)
					if newOffset ~= self._scrollY then
						self._scrollY = newOffset
					end
					return true
				end
			end
			local line, col = self:_cursorFromPoint(x, y)
			self:_setCursorPosition(line, col)
			return true
		end
	elseif event == "mouse_scroll" then
		local direction, x, y = ...
		if self:containsPoint(x, y) then
			self:_scrollLines(direction)
			return true
		end
	elseif event == "char" then
		local ch = ...
		if self:isFocused() then
			if self._find.visible then
				self:_editFindFieldText(ch)
				return true
			end
			local inserted = self:_insertCharacter(ch)
			if inserted and self.autocompleteAuto then
				self:_updateAutocomplete("auto")
			end
			return inserted
		end
	elseif event == "paste" then
		local text = ...
		if self:isFocused() then
			if self._find.visible then
				self:_editFindFieldText(text)
				return true
			end
			local inserted = self:_insertTextAtCursor(text)
			if inserted and self.autocompleteAuto then
				self:_updateAutocomplete("auto")
			end
			return inserted
		end
	elseif event == "key" then
		local keyCode, isHeld = ...
		if keyCode == keys.leftShift or keyCode == keys.rightShift then
			self._shiftDown = true
			return true
		elseif keyCode == keys.leftCtrl or keyCode == keys.rightCtrl then
			self._ctrlDown = true
			return true
		end
		if self:isFocused() then
			return self:_handleKey(keyCode, isHeld)
		end
	elseif event == "key_up" then
		local keyCode = ...
		if keyCode == keys.leftShift or keyCode == keys.rightShift then
			self._shiftDown = false
			if not self:_hasSelection() then
				self:_clearSelection()
			end
			return true
		elseif keyCode == keys.leftCtrl or keyCode == keys.rightCtrl then
			self._ctrlDown = false
			return true
		elseif keyCode == keys.escape then
			if self:_handleEscape() then
				return true
			end
		end
	end
	return false
end

function TextBox:setText(text, suppressEvent)
	expect(1, text, "string")
	self:_setTextInternal(text, true, suppressEvent)
end

function TextBox:getText()
	return self.text
end

function TextBox:setOnChange(handler)
	if handler ~= nil then
		expect(1, handler, "function")
	end
	self.onChange = handler
end

---@since 0.1.0
---@param options PixelUI.AppOptions?
---@return PixelUI.App
function pixelui.create(options)
	if options ~= nil then
		expect(1, options, "table")
	end
	options = options or {}

	local autoWindow = false
	local parentTerm
	local win = options.window
	if win == nil then
		parentTerm = term.current()
		local sw, sh = parentTerm.getSize()
		win = windowAPI.create(parentTerm, 1, 1, sw, sh, true)
		win.setVisible(true)
		autoWindow = true
	end

	local box = shrekbox.new(win)
	box.profiler.start_frame()
	box.profiler.start_region("user")
	local pixelLayer = box.add_pixel_layer(5, "pixelui_pixels")
	local layer = box.add_text_layer(10, "pixelui_ui")

	local sw, sh = win.getSize()
	local background = options.background or colors.black
	box.fill(background)
	local animationInterval = math.max(0.01, options.animationInterval or 0.05)

	---@type PixelUI.App
	local app = setmetatable({
		window = win,
		box = box,
		layer = layer,
		pixelLayer = pixelLayer,
		background = background,
		running = false,
		_autoWindow = autoWindow,
		_parentTerminal = parentTerm,
		_focusWidget = nil,
		_popupWidgets = {},
		_popupLookup = {},
		_animations = {},
		_animationTimer = nil,
		_animationInterval = animationInterval,
		_radioGroups = {},
		_threads = {},
		_threadTimers = {},
		_threadTicker = nil,
		_threadIdCounter = 0
	}, App)

	app.root = Frame:new(app, {
		x = 1,
		y = 1,
		width = sw,
		height = sh,
		bg = background,
		fg = colors.white,
		border = options.rootBorder,
		z = -math.huge
	})

	return app
end

---@since 0.1.0
---@return PixelUI.Frame
function App:getRoot()
	return self.root
end

---@since 0.1.0
---@param color PixelUI.Color
function App:setBackground(color)
	expect(1, color, "number")
	self.background = color
	self.box.fill(color)
end

---@since 0.1.0
---@return Layer
function App:getLayer()
	return self.layer
end

---@since 0.1.0
---@return Layer
function App:getPixelLayer()
	return self.pixelLayer
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Frame
function App:createFrame(config)
	return Frame:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Button
function App:createButton(config)
	return Button:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Label
function App:createLabel(config)
	return Label:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.CheckBox
function App:createCheckBox(config)
	return CheckBox:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Toggle
function App:createToggle(config)
	return Toggle:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.TextBox
function App:createTextBox(config)
	return TextBox:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.ComboBox
function App:createComboBox(config)
	return ComboBox:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.List
function App:createList(config)
	return List:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Table
function App:createTable(config)
	return Table:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.TreeView
function App:createTreeView(config)
	return TreeView:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Chart
function App:createChart(config)
	return Chart:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.RadioButton
function App:createRadioButton(config)
	return RadioButton:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.ProgressBar
function App:createProgressBar(config)
	return ProgressBar:new(self, config)
end

---@param config PixelUI.WidgetConfig?
---@return PixelUI.NotificationToast
function App:createNotificationToast(config)
	return NotificationToast:new(self, config)
end

---@param config PixelUI.WidgetConfig?
---@return PixelUI.LoadingRing
function App:createLoadingRing(config)
	return LoadingRing:new(self, config)
end

---@since 0.1.0
---@param config PixelUI.WidgetConfig?
---@return PixelUI.Slider
function App:createSlider(config)
	return Slider:new(self, config)
end

function App:_ensureAnimationTimer()
	if not self._animationTimer then
		self._animationTimer = osLib.startTimer(self._animationInterval)
	end
end

function App:_updateAnimations()
	local list = self._animations
	if not list or #list == 0 then
		return
	end
	local now = osLib.clock()
	local index = 1
	while index <= #list do
		local animation = list[index]
		if animation._cancelled then
			if animation.onCancel then
				animation.onCancel(animation.handle)
			end
			animation._finished = true
			table.remove(list, index)
		else
			if not animation.startTime then
				animation.startTime = now
			end
			local elapsed = now - animation.startTime
			local rawProgress
			if animation.duration <= 0 then
				rawProgress = 1
			else
				rawProgress = math.min(1, elapsed / animation.duration)
			end
			local eased = animation.easing(rawProgress)
			if animation.update then
				animation.update(eased, rawProgress, animation.handle)
			end
			if rawProgress >= 1 then
				animation._finished = true
				if animation.onComplete then
					animation.onComplete(animation.handle)
				end
				table.remove(list, index)
			else
				index = index + 1
			end
		end
	end
end

function App:_clearAnimations(invokeCancel)
	local list = self._animations
	if not list or #list == 0 then
		self._animations = {}
		self._animationTimer = nil
		return
	end
	if invokeCancel then
		for i = 1, #list do
			local animation = list[i]
			if animation and not animation._finished then
				if animation.onCancel then
					animation.onCancel(animation.handle)
				end
				animation._finished = true
			end
		end
	end
	self._animations = {}
	self._animationTimer = nil
end

---@since 0.1.0
---@param options PixelUI.AnimationOptions
---@return PixelUI.AnimationHandle
function App:animate(options)
	expect(1, options, "table")
	local update = options.update
	if update ~= nil and type(update) ~= "function" then
		error("options.update must be a function", 2)
	end
	local onComplete = options.onComplete
	if onComplete ~= nil and type(onComplete) ~= "function" then
		error("options.onComplete must be a function", 2)
	end
	local onCancel = options.onCancel
	if onCancel ~= nil and type(onCancel) ~= "function" then
		error("options.onCancel must be a function", 2)
	end
	local easing = options.easing
	if easing == nil then
		easing = easings.linear
	elseif type(easing) == "string" then
		easing = easings[easing]
		if not easing then
			error("Unknown easing '" .. options.easing .. "'", 2)
		end
	elseif type(easing) ~= "function" then
		error("options.easing must be a function or easing name", 2)
	end

	if options.duration ~= nil and type(options.duration) ~= "number" then
		error("options.duration must be a number", 2)
	end
	local duration = math.max(0.01, options.duration or 0.3)
	local animation = {
		update = update,
		onComplete = onComplete,
		onCancel = onCancel,
		easing = easing,
		duration = duration,
		startTime = osLib.clock()
	}

	local handle = {}
	function handle:cancel()
		if animation._finished or animation._cancelled then
			return
		end
		animation._cancelled = true
	end
	animation.handle = handle

	self._animations[#self._animations + 1] = animation
	if update then
		update(0, 0, handle)
	end
	self:_ensureAnimationTimer()
	return handle
end

local THREAD_STATUS_RUNNING = "running"
local THREAD_STATUS_COMPLETED = "completed"
local THREAD_STATUS_ERROR = "error"
local THREAD_STATUS_CANCELLED = "cancelled"

local THREAD_CANCEL_SIGNAL = {}

local function thread_safe_emit(listeners, prefix, ...)
	if not listeners then
		return
	end
	for i = 1, #listeners do
		local callback = listeners[i]
		local ok, err = pcall(callback, ...)
		if not ok then
			print(prefix .. tostring(err))
		end
	end
end

function ThreadHandle:getId()
	return self.id
end

function ThreadHandle:getName()
	return self.name
end

function ThreadHandle:setName(name)
	expect(1, name, "string")
	self.name = name
end

function ThreadHandle:getStatus()
	return self.status
end

function ThreadHandle:isRunning()
	return self.status == THREAD_STATUS_RUNNING
end

function ThreadHandle:isFinished()
	local status = self.status
	return status == THREAD_STATUS_COMPLETED or status == THREAD_STATUS_ERROR or status == THREAD_STATUS_CANCELLED
end

function ThreadHandle:isCancelled()
	return self._cancelRequested or self.status == THREAD_STATUS_CANCELLED
end

function ThreadHandle:cancel()
	if self.status ~= THREAD_STATUS_RUNNING then
		return false
	end
	self._cancelRequested = true
	if self.waiting == "timer" and self.timerId then
		local timers = self.app._threadTimers
		if timers then
			timers[self.timerId] = nil
		end
		self.timerId = nil
	end
	self.waiting = nil
	self._ready = true
	self.app:_ensureThreadPump()
	return true
end

function ThreadHandle:getResult()
	if not self.result then
		return nil
	end
	return table_unpack(self.result, 1, self.result.n or #self.result)
end

function ThreadHandle:getResults()
	if not self.result then
		return nil
	end
	local copy = { n = self.result.n }
	local count = self.result.n or #self.result
	for i = 1, count do
		copy[i] = self.result[i]
	end
	return copy
end

function ThreadHandle:getError()
	return self.error
end

function ThreadHandle:setMetadata(key, value)
	expect(1, key, "string")
	local current = self.metadata[key]
	if current == value then
		return
	end
	self.metadata[key] = value
	self:_emitMetadata(key, value)
end

function ThreadHandle:getMetadata(key)
	expect(1, key, "string")
	return self.metadata[key]
end

function ThreadHandle:getAllMetadata()
	local copy = {}
	for k, v in pairs(self.metadata) do
		copy[k] = v
	end
	return copy
end

function ThreadHandle:onStatusChange(callback)
	if callback == nil then
		return
	end
	expect(1, callback, "function")
	local listeners = self._statusListeners
	listeners[#listeners + 1] = callback
	local ok, err = pcall(callback, self, self.status)
	if not ok then
		print("Thread status listener error: " .. tostring(err))
	end
end

function ThreadHandle:onMetadataChange(callback)
	if callback == nil then
		return
	end
	expect(1, callback, "function")
	local listeners = self._metadataListeners
	listeners[#listeners + 1] = callback
	for key, value in pairs(self.metadata) do
		local ok, err = pcall(callback, self, key, value)
		if not ok then
			print("Thread metadata listener error: " .. tostring(err))
		end
	end
end

function ThreadHandle:_emitMetadata(key, value)
	thread_safe_emit(self._metadataListeners, "Thread metadata listener error: ", self, key, value)
end

function ThreadHandle:_setStatus(newStatus)
	if self.status == newStatus then
		return
	end
	self.status = newStatus
	thread_safe_emit(self._statusListeners, "Thread status listener error: ", self, newStatus)
end

local function createThreadContext(handle)
	return setmetatable({ _handle = handle }, ThreadContext)
end

function ThreadContext:checkCancelled()
	if self._handle._cancelRequested then
		error(THREAD_CANCEL_SIGNAL, 0)
	end
end

function ThreadContext:isCancelled()
	return self._handle._cancelRequested == true
end

function ThreadContext:sleep(seconds)
	if seconds ~= nil then
		expect(1, seconds, "number")
	else
		seconds = 0
	end
	if seconds < 0 then
		seconds = 0
	end
	self:checkCancelled()
	local handle = self._handle
	if handle.timerId then
		local timers = handle.app._threadTimers
		if timers then
			timers[handle.timerId] = nil
		end
		handle.timerId = nil
	end
	handle.waiting = "timer"
	local timerId = osLib.startTimer(seconds)
	handle.timerId = timerId
	local timers = handle.app._threadTimers
	if not timers then
		timers = {}
		handle.app._threadTimers = timers
	end
	timers[timerId] = handle
	handle._ready = false
	return coroutine.yield("sleep")
end

function ThreadContext:yield()
	self:checkCancelled()
	self._handle.waiting = "yield"
	return coroutine.yield("yield")
end

function ThreadContext:setMetadata(key, value)
	self._handle:setMetadata(key, value)
end

function ThreadContext:setStatus(text)
	self._handle:setMetadata("status", text)
end

function ThreadContext:setDetail(text)
	self._handle:setMetadata("detail", text)
end

function ThreadContext:setProgress(value)
	if value ~= nil then
		expect(1, value, "number")
	end
	self._handle:setMetadata("progress", value)
end

function ThreadContext:getHandle()
	return self._handle
end

function App:_ensureThreadPump()
	if not self._threads or self._threadTicker then
		return
	end
	for i = 1, #self._threads do
		local handle = self._threads[i]
		if handle and handle.status == THREAD_STATUS_RUNNING and handle._ready then
			self._threadTicker = osLib.startTimer(0)
			return
		end
	end
end

function App:_cleanupThread(handle)
	if handle.timerId and self._threadTimers then
		self._threadTimers[handle.timerId] = nil
		handle.timerId = nil
	end
	handle.waiting = nil
	handle._ready = false
	handle._resumeValue = nil
end

function App:_resumeThread(handle)
	if handle.status ~= THREAD_STATUS_RUNNING then
		return
	end
	if handle._cancelRequested then
		handle:_setStatus(THREAD_STATUS_CANCELLED)
		self:_cleanupThread(handle)
		return
	end
	local resumeValue = handle._resumeValue
	handle._resumeValue = nil
	local results = table_pack(coroutine.resume(handle.co, resumeValue))
	local ok = results[1]
	if not ok then
		local err = results[2]
		if err == THREAD_CANCEL_SIGNAL then
			handle:_setStatus(THREAD_STATUS_CANCELLED)
		else
			if type(err) == "string" and debug and debug.traceback then
				err = debug.traceback(handle.co, err)
			end
			handle.error = err
			print("PixelUI thread error: " .. tostring(err))
			handle:_setStatus(THREAD_STATUS_ERROR)
		end
		self:_cleanupThread(handle)
		return
	end
	if coroutine.status(handle.co) == "dead" then
		local out = { n = results.n - 1 }
		for i = 2, results.n do
			out[i - 1] = results[i]
		end
		handle.result = out
		handle:_setStatus(THREAD_STATUS_COMPLETED)
		self:_cleanupThread(handle)
		return
	end
	local action = results[2]
	handle.waiting = nil
	if action == "sleep" then
		return
	elseif action == "yield" then
		handle._ready = true
	else
		handle._ready = true
	end
	self:_ensureThreadPump()
end

function App:_serviceThreads()
	if not self._threads or #self._threads == 0 then
		return
	end
	local ready = {}
	for i = 1, #self._threads do
		local handle = self._threads[i]
		if handle and handle.status == THREAD_STATUS_RUNNING and handle._ready then
			handle._ready = false
			ready[#ready + 1] = handle
		end
	end
	for i = 1, #ready do
		self:_resumeThread(ready[i])
	end
	self:_ensureThreadPump()
end

function App:_shutdownThreads()
	if not self._threads then
		return
	end
	for i = 1, #self._threads do
		local handle = self._threads[i]
		if handle and handle.status == THREAD_STATUS_RUNNING then
			handle._cancelRequested = true
			handle:_setStatus(THREAD_STATUS_CANCELLED)
			self:_cleanupThread(handle)
		end
	end
	self._threadTimers = {}
	self._threadTicker = nil
end

function App:spawnThread(fn, options)
	expect(1, fn, "function")
	if options ~= nil then
		expect(2, options, "table")
	else
		options = {}
	end
	if not self._threads then
		self._threads = {}
	end
	if not self._threadTimers then
		self._threadTimers = {}
	end
	self._threadIdCounter = (self._threadIdCounter or 0) + 1
	local id = self._threadIdCounter
	local name = options.name or ("Thread " .. tostring(id))
	local handle = setmetatable({
		app = self,
		id = id,
		name = name,
		status = THREAD_STATUS_RUNNING,
		co = nil,
		waiting = nil,
		timerId = nil,
		_ready = true,
		_cancelRequested = false,
		_resumeValue = nil,
		metadata = {},
		result = nil,
		error = nil,
		_statusListeners = {},
		_metadataListeners = {}
	}, ThreadHandle)
	local co = coroutine.create(function()
		local context = createThreadContext(handle)
		handle._context = context
		local outputs = table_pack(fn(context, self))
		return table_unpack(outputs, 1, outputs.n)
	end)
	handle.co = co
	self._threads[#self._threads + 1] = handle
	if options.onStatus then
		handle:onStatusChange(options.onStatus)
	end
	if options.onMetadata then
		handle:onMetadataChange(options.onMetadata)
	end
	self:_ensureThreadPump()
	return handle
end

function App:getThreads()
	local list = {}
	if not self._threads then
		return list
	end
	for i = 1, #self._threads do
		list[i] = self._threads[i]
	end
	return list
end

function App:_registerPopup(widget)
	if not widget then
		return
	end
	local lookup = self._popupLookup
	if not lookup[widget] then
		lookup[widget] = true
		table.insert(self._popupWidgets, widget)
	end
end

function App:_unregisterPopup(widget)
	if not widget then
		return
	end
	local lookup = self._popupLookup
	if not lookup[widget] then
		return
	end
	lookup[widget] = nil
	local list = self._popupWidgets
	for index = #list, 1, -1 do
		if list[index] == widget then
			table.remove(list, index)
			break
		end
	end
end

function App:_drawPopups()
	local list = self._popupWidgets
	if not list or #list == 0 then
		return
	end
	local textLayer = self.layer
	local pixelLayer = self.pixelLayer
	local index = 1
	while index <= #list do
		local widget = list[index]
		if widget and widget._open and widget.visible ~= false then
			widget:_drawDropdown(textLayer, pixelLayer)
			index = index + 1
		else
			if widget then
				self._popupLookup[widget] = nil
			end
			table.remove(list, index)
		end
	end
end

function App:_registerRadioButton(button)
	if not button or not button.group then
		return
	end
	local group = button.group
	local groups = self._radioGroups
	local entry = groups[group]
	if not entry then
		entry = { buttons = {}, lookup = {}, selected = nil }
		groups[group] = entry
	end
	if not entry.lookup[button] then
		entry.lookup[button] = true
		entry.buttons[#entry.buttons + 1] = button
	end
	button._registeredGroup = group
	if entry.selected then
		if entry.selected == button then
			button:_applySelection(true, true)
		else
			button:_applySelection(false, true)
		end
	elseif button.selected then
		self:_selectRadioInGroup(group, button, true)
	end
end

function App:_unregisterRadioButton(button)
	if not button then
		return
	end
	local group = button._registeredGroup
	if not group then
		return
	end
	local entry = self._radioGroups[group]
	if not entry then
		button._registeredGroup = nil
		return
	end
	entry.lookup[button] = nil
	for index = #entry.buttons, 1, -1 do
		if entry.buttons[index] == button then
			table.remove(entry.buttons, index)
			break
		end
	end
	if entry.selected == button then
		entry.selected = nil
		for i = 1, #entry.buttons do
			local other = entry.buttons[i]
			if other then
				other:_applySelection(false, true)
			end
		end
	end
	button._registeredGroup = nil
	if not next(entry.lookup) then
		self._radioGroups[group] = nil
	end
end

function App:_selectRadioInGroup(group, target, suppressEvent)
	if not group then
		return
	end
	suppressEvent = not not suppressEvent
	local groups = self._radioGroups
	local entry = groups[group]
	if not entry then
		entry = { buttons = {}, lookup = {}, selected = nil }
		groups[group] = entry
	end
	if target then
		if not entry.lookup[target] then
			entry.lookup[target] = true
			entry.buttons[#entry.buttons + 1] = target
		end
		target._registeredGroup = group
	end
	entry.selected = target
	for i = 1, #entry.buttons do
		local button = entry.buttons[i]
		if button then
			if button == target then
				button:_applySelection(true, suppressEvent)
			else
				button:_applySelection(false, suppressEvent)
			end
		end
	end
end

---@since 0.1.0
---@param widget PixelUI.Widget?
function App:setFocus(widget)
	if widget ~= nil then
		expect(1, widget, "table")
		if widget.app ~= self then
			error("Cannot focus widget from a different PixelUI app", 2)
		end
		if not widget.focusable then
			widget = nil
		end
	end
	if self._focusWidget == widget then
		return
	end
	if self._focusWidget then
		local current = self._focusWidget
		---@cast current PixelUI.Widget
		current:setFocused(false)
	end
	self._focusWidget = widget
	if widget then
		---@cast widget PixelUI.Widget
		widget:setFocused(true)
	end
end

---@since 0.1.0
---@return PixelUI.Widget?
function App:getFocus()
	return self._focusWidget
end

---@since 0.1.0
function App:render()
	self.box.fill(self.background)
	self.pixelLayer.clear()
	self.layer.clear()
	self.root:draw(self.layer, self.pixelLayer)
	self:_drawPopups()
	self.box.render()
end

---@since 0.1.0
---@param event string
function App:step(event, ...)
	if not event then
		return
	end

	local consumed = false

	if event == "timer" then
		local timerId = ...
		if self._threadTicker and timerId == self._threadTicker then
			self._threadTicker = nil
			self:_serviceThreads()
			consumed = true
		end
		local timers = self._threadTimers
		if timers then
			local handle = timers[timerId]
			if handle then
				timers[timerId] = nil
				if handle.status == THREAD_STATUS_RUNNING and handle.timerId == timerId then
					handle.timerId = nil
					handle.waiting = nil
					handle._ready = true
					handle._resumeValue = true
				end
				consumed = true
			end
		end
		if self._animationTimer and timerId == self._animationTimer then
			self:_updateAnimations()
			if self._animations and #self._animations > 0 then
				self._animationTimer = osLib.startTimer(self._animationInterval)
			else
				self._animationTimer = nil
			end
			consumed = true
		end
	end

	if not consumed and event == "term_resize" then
		if self._autoWindow then
			local parent = self._parentTerminal or term.current()
			local pw, ph = parent.getSize()
			if self.window.reposition then
				self.window.reposition(1, 1, pw, ph)
			end
		end
		local w, h = self.window.getSize()
		self.root:setSize(w, h)
	end

	if not consumed and (event == "char" or event == "paste" or event == "key" or event == "key_up") then
		local focus = self._focusWidget
		if focus and focus.visible ~= false then
			consumed = focus:handleEvent(event, ...)
		end
	end

	if not consumed then
		consumed = self.root:handleEvent(event, ...)
	end

	if not consumed and (event == "mouse_click" or event == "monitor_touch") then
		self:setFocus(nil)
	end

	self:_serviceThreads()
	self:render()
end

---@since 0.1.0
function App:run()
	self.running = true
	self:render()
	while self.running do
		local event = { pullEvent() }
		if event[1] == "terminate" then
			self.running = false
		else
			self:step(table.unpack(event))
		end
	end
	self:_shutdownThreads()
end

---@since 0.1.0
function App:stop()
	self.running = false
	self:_clearAnimations(true)
	self:_shutdownThreads()
end

pixelui.widgets = {
	Frame = function(app, config)
		return Frame:new(app, config)
	end,
	Button = function(app, config)
		return Button:new(app, config)
	end,
	Label = function(app, config)
		return Label:new(app, config)
	end,
	CheckBox = function(app, config)
		return CheckBox:new(app, config)
	end,
	Toggle = function(app, config)
		return Toggle:new(app, config)
	end,
	TextBox = function(app, config)
		return TextBox:new(app, config)
	end,
	ComboBox = function(app, config)
		return ComboBox:new(app, config)
	end,
	List = function(app, config)
		return List:new(app, config)
	end,
	Table = function(app, config)
		return Table:new(app, config)
	end,
	TreeView = function(app, config)
		return TreeView:new(app, config)
	end,
	Chart = function(app, config)
		return Chart:new(app, config)
	end,
	RadioButton = function(app, config)
		return RadioButton:new(app, config)
	end,
	ProgressBar = function(app, config)
		return ProgressBar:new(app, config)
	end,
	Slider = function(app, config)
		return Slider:new(app, config)
	end,
	LoadingRing = function(app, config)
		return LoadingRing:new(app, config)
	end,
	NotificationToast = function(app, config)
		return NotificationToast:new(app, config)
	end
}

pixelui.Widget = Widget
pixelui.Frame = Frame
pixelui.Button = Button
pixelui.Label = Label
pixelui.CheckBox = CheckBox
pixelui.Toggle = Toggle
pixelui.TextBox = TextBox
pixelui.ComboBox = ComboBox
pixelui.List = List
pixelui.Table = Table
pixelui.TreeView = TreeView
pixelui.Chart = Chart
pixelui.RadioButton = RadioButton
pixelui.ProgressBar = ProgressBar
pixelui.Slider = Slider
pixelui.LoadingRing = LoadingRing
pixelui.NotificationToast = NotificationToast
pixelui.easings = easings
pixelui.ThreadHandle = ThreadHandle
pixelui.ThreadContext = ThreadContext
pixelui.threadStatus = {
	running = THREAD_STATUS_RUNNING,
	completed = THREAD_STATUS_COMPLETED,
	error = THREAD_STATUS_ERROR,
	cancelled = THREAD_STATUS_CANCELLED
}

return pixelui
