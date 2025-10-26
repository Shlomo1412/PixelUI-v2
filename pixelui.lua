local term = assert(rawget(_G, "term"), "term API unavailable")
local colors = assert(rawget(_G, "colors"), "colors API unavailable")
local osLib = assert(rawget(_G, "os"), "os API unavailable")
local pullEvent = assert(osLib.pullEvent, "os.pullEvent unavailable")
local windowAPI = assert(rawget(_G, "window"), "window API unavailable")
local keys = assert(rawget(_G, "keys"), "keys API unavailable")

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

---@class PixelUI.Widget
---@field app PixelUI.App
---@field parent PixelUI.Frame?
---@field x integer
---@field y integer
---@field width integer
---@field height integer
---@field bg PixelUI.Color
---@field fg PixelUI.Color
---@field _orderIndex integer?
---@field visible boolean
---@field z number
---@field border PixelUI.NormalizedBorderConfig?
---@field id string?
---@field focusable boolean
---@field draw fun(self:PixelUI.Widget, textLayer:Layer, pixelLayer:Layer)
---@field handleEvent fun(self:PixelUI.Widget, event:string, ...:any):boolean
---@field setFocused fun(self:PixelUI.Widget, focused:boolean)
---@field isFocused fun(self:PixelUI.Widget):boolean

---@class PixelUI.NormalizedBorderConfig
---@field color PixelUI.Color
---@field top boolean
---@field right boolean
---@field bottom boolean
---@field left boolean
---@field thickness integer

---@class PixelUI.App
---@field window table
---@field box ShrekBox
---@field layer Layer
---@field pixelLayer Layer
---@field background PixelUI.Color
---@field root PixelUI.Frame
---@field running boolean
---@field _autoWindow boolean
---@field _parentTerminal table?
---@field _focusWidget PixelUI.Widget?
---@field _popupWidgets PixelUI.Widget[]
---@field _popupLookup table<PixelUI.Widget, boolean>
---@field _animations table
---@field _animationTimer integer?
---@field _animationInterval number
---@field _radioGroups table<string, { buttons: PixelUI.RadioButton[], lookup: table<PixelUI.RadioButton, boolean>, selected: PixelUI.RadioButton? }>

---@class PixelUI.Frame : PixelUI.Widget
---@field private _children PixelUI.Widget[]
---@field private _orderCounter integer
---@field title string?

---@class PixelUI.Button : PixelUI.Widget
---@field label string
---@field onPress fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?
---@field onRelease fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?
---@field onClick fun(self:PixelUI.Button, button:integer, x:integer, y:integer)?
---@field clickEffect boolean
---@field private _pressed boolean

---@class PixelUI.Label : PixelUI.Widget
---@field text string
---@field wrap boolean
---@field align "left"|"center"|"right"
---@field verticalAlign "top"|"middle"|"bottom"

---@class PixelUI.CheckBox : PixelUI.Widget
---@field label string
---@field checked boolean
---@field indeterminate boolean
---@field allowIndeterminate boolean
---@field focusBg PixelUI.Color?
---@field focusFg PixelUI.Color?
---@field onChange fun(self:PixelUI.CheckBox, checked:boolean, indeterminate:boolean)?

---@class PixelUI.ProgressBar : PixelUI.Widget
---@field value number
---@field min number
---@field max number
---@field indeterminate boolean
---@field label string?
---@field showPercent boolean
---@field trackColor PixelUI.Color
---@field fillColor PixelUI.Color
---@field textColor PixelUI.Color

---@class PixelUI.Slider : PixelUI.Widget
---@field min number
---@field max number
---@field value number
---@field range boolean
---@field lowerValue number?
---@field upperValue number?
---@field step number
---@field showValue boolean
---@field onChange fun(self:PixelUI.Slider, ...:number)?
---@field formatValue fun(self:PixelUI.Slider, ...:number):string?

---@class PixelUI.TreeNode
---@field label string
---@field data any
---@field children PixelUI.TreeNode[]
---@field expanded boolean

---@class PixelUI.TreeView : PixelUI.Widget
---@field indentWidth integer
---@field highlightBg PixelUI.Color
---@field highlightFg PixelUI.Color
---@field placeholder string?
---@field onSelect fun(self:PixelUI.TreeView, node:PixelUI.TreeNode?, index:integer)?
---@field onToggle fun(self:PixelUI.TreeView, node:PixelUI.TreeNode, expanded:boolean)?

---@class PixelUI.List : PixelUI.Widget
---@field items string[]
---@field selectedIndex integer
---@field highlightBg PixelUI.Color
---@field highlightFg PixelUI.Color
---@field placeholder string?
---@field onSelect fun(self:PixelUI.List, item:string?, index:integer)?

---@class PixelUI.RadioButton : PixelUI.Widget
---@field label string
---@field value any
---@field group string?
---@field selected boolean
---@field focusBg PixelUI.Color?
---@field focusFg PixelUI.Color?
---@field onChange fun(self:PixelUI.RadioButton, selected:boolean, value:any)?

---@class PixelUI.ComboBox : PixelUI.Widget
---@field items string[]
---@field selectedIndex integer
---@field dropdownBg PixelUI.Color
---@field dropdownFg PixelUI.Color
---@field highlightBg PixelUI.Color
---@field highlightFg PixelUI.Color
---@field placeholder string?
---@field onChange fun(self:PixelUI.ComboBox, item:string?, index:integer)?

---@class PixelUI.TextBox : PixelUI.Widget
---@field text string
---@field placeholder string
---@field onChange fun(self:PixelUI.TextBox, value:string)?
---@field maxLength integer?

---@class PixelUI.AnimationOptions
---@field duration number?
---@field easing (fun(t:number):number)|string?
---@field update fun(progress:number, rawProgress:number, handle:PixelUI.AnimationHandle?)?
---@field onComplete fun(handle:PixelUI.AnimationHandle?)?
---@field onCancel fun(handle:PixelUI.AnimationHandle?)?

---@class PixelUI.AnimationHandle
---@field cancel fun(self:PixelUI.AnimationHandle)

---@alias PixelUI.WidgetConfig table

---@class PixelUI
---@field create fun(options:PixelUI.AppOptions?):PixelUI.App
---@field version string
---@field widgets { Frame: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Frame, Button: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Button, Label: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Label, CheckBox: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.CheckBox, TextBox: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.TextBox, ComboBox: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.ComboBox, RadioButton: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.RadioButton, ProgressBar: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.ProgressBar, Slider: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Slider, List: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.List, TreeView: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.TreeView }
---@field easings table<string, fun(t:number):number>

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

local ProgressBar = {}
ProgressBar.__index = ProgressBar
setmetatable(ProgressBar, { __index = Widget })

local Slider = {}
Slider.__index = Slider
setmetatable(Slider, { __index = Widget })

local List = {}
List.__index = List
setmetatable(List, { __index = Widget })

local TreeView = {}
TreeView.__index = TreeView
setmetatable(TreeView, { __index = Widget })

local RadioButton = {}
RadioButton.__index = RadioButton
setmetatable(RadioButton, { __index = Widget })

local ComboBox = {}
ComboBox.__index = ComboBox
setmetatable(ComboBox, { __index = Widget })

local App = {}
App.__index = App

local borderSides = { "top", "right", "bottom", "left" }
local RADIO_DOT_CHAR = string.char(7)

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
	baseConfig.height = math.max(1, math.floor(baseConfig.height or 3))
	baseConfig.width = math.max(1, math.floor(baseConfig.width or 12))
	local instance = setmetatable({}, Slider)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.min = type(config.min) == "number" and config.min or 0
	instance.max = type(config.max) == "number" and config.max or 100
	if instance.max <= instance.min then
		instance.max = instance.min + 1
	end
	if config and type(config.step) == "number" and config.step > 0 then
		instance.step = config.step
	else
		instance.step = 0
	end
	instance.range = not not (config and config.range)
	instance.trackColor = (config and config.trackColor) or colors.gray
	instance.fillColor = (config and config.fillColor) or colors.lightBlue
	instance.handleColor = (config and config.handleColor) or colors.white
	instance.showValue = not not (config and config.showValue)
	if config and config.formatValue ~= nil then
		if type(config.formatValue) ~= "function" then
			error("Slider formatValue must be a function", 2)
		end
		instance.formatValue = config.formatValue
	else
		instance.formatValue = nil
	end
	instance.onChange = config and config.onChange or nil
	instance._activeHandle = nil
	instance._focusedHandle = instance.range and "lower" or "single"
	instance._dragging = false

	if instance.range then
		local startValue
		local endValue
		if config and type(config.value) == "table" then
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
		local value = config and config.value
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
	local ax, ay = self:getAbsoluteRect()
	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		return nil
	end
	local innerX = ax + leftPad
	local innerY = ay + topPad
	if x < innerX or x >= innerX + innerWidth then
		return nil
	end
	if y < innerY or y >= innerY + innerHeight then
		return nil
	end
	local row = y - innerY
	local index = self.scrollOffset + row
	if index < 1 or index > #self._flatNodes then
		return nil
	end
	return index, innerX, innerWidth
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

	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end

	local innerX = ax + leftPad
	local innerY = ay + topPad
	local flat = self._flatNodes
	local count = #flat

	if count == 0 then
		for row = 0, innerHeight - 1 do
			textLayer.text(innerX, innerY + row, string.rep(" ", innerWidth), fg, bg)
		end
		local placeholder = self.placeholder
		if type(placeholder) == "string" and #placeholder > 0 then
			local display = placeholder
			if #display > innerWidth then
				display = display:sub(1, innerWidth)
			end
			local startX = innerX + math.floor((innerWidth - #display) / 2)
			if startX < innerX then
				startX = innerX
			end
			textLayer.text(startX, innerY, display, colors.lightGray, bg)
		end
		return
	end

	for row = 0, innerHeight - 1 do
		local lineY = innerY + row
		local index = self.scrollOffset + row
		if index > count then
			textLayer.text(innerX, lineY, string.rep(" ", innerWidth), fg, bg)
		else
			local entry = flat[index]
			local node = entry.node
			local depth = entry.depth or 0
			local indent = depth * self.indentWidth
			if indent > innerWidth - 1 then
				indent = innerWidth - 1
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
			local remaining = innerWidth - indent
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
			elseif #line > innerWidth then
				line = line:sub(1, innerWidth)
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
end

function TreeView:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		local index, innerX, innerWidth = self:_rowFromPoint(x, y)
		if index then
			self.app:setFocus(self)
			local entry = self._flatNodes[index]
			if entry then
				local indent = entry.depth * self.indentWidth
				if indent < 0 then
					indent = 0
				end
				if indent > innerWidth - 1 then
					indent = innerWidth - 1
				end
				local toggleX = innerX + indent
				if entry.node and entry.node.children and #entry.node.children > 0 and indent < innerWidth then
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
		local index, innerX, innerWidth = self:_rowFromPoint(x, y)
		if index then
			self.app:setFocus(self)
			local entry = self._flatNodes[index]
			if entry then
				local indent = entry.depth * self.indentWidth
				if indent < 0 then
					indent = 0
				end
				if indent > innerWidth - 1 then
					indent = innerWidth - 1
				end
				local toggleX = innerX + indent
				if entry.node and entry.node.children and #entry.node.children > 0 and indent < innerWidth then
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
	local ax, ay = self:getAbsoluteRect()
	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		return nil
	end
	local innerX = ax + leftPad
	local innerY = ay + topPad
	if x < innerX or x >= innerX + innerWidth then
		return nil
	end
	if y < innerY or y >= innerY + innerHeight then
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

	local leftPad, rightPad, topPad, bottomPad, innerWidth, innerHeight = self:_getInnerMetrics()
	if innerWidth <= 0 or innerHeight <= 0 then
		return
	end
	local innerX = ax + leftPad
	local innerY = ay + topPad

	local count = #self.items
	local baseBg = bg
	local highlightBg = self.highlightBg or colors.lightGray
	local highlightFg = self.highlightFg or colors.black

	if count == 0 then
		for row = 0, innerHeight - 1 do
			textLayer.text(innerX, innerY + row, string.rep(" ", innerWidth), fg, baseBg)
		end
		local placeholder = self.placeholder
		if type(placeholder) == "string" and #placeholder > 0 then
			local display = placeholder
			if #display > innerWidth then
				display = display:sub(1, innerWidth)
			end
			local startX = innerX + math.floor((innerWidth - #display) / 2)
			if startX < innerX then
				startX = innerX
			end
			textLayer.text(startX, innerY, display, colors.lightGray, baseBg)
		end
		return
	end

	for row = 0, innerHeight - 1 do
		local lineY = innerY + row
		local index = self.scrollOffset + row
		if index > count then
			textLayer.text(innerX, lineY, string.rep(" ", innerWidth), fg, baseBg)
		else
			local item = self.items[index] or ""
			if #item > innerWidth then
				item = item:sub(1, innerWidth)
			end
			local padded = item
			if #padded < innerWidth then
				padded = padded .. string.rep(" ", innerWidth - #padded)
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
end

function List:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
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

function TextBox:new(app, config)
	local baseConfig = {}
	if config then
		for k, v in pairs(config) do
			baseConfig[k] = v
		end
	end
	baseConfig.focusable = true
	baseConfig.height = baseConfig.height or 1
	local instance = setmetatable({}, TextBox)
	instance:_init_base(app, baseConfig)
	instance.focusable = true
	instance.text = (config and config.text) or ""
	instance.placeholder = (config and config.placeholder) or ""
	instance.onChange = config and config.onChange or nil
	instance.maxLength = config and config.maxLength or nil
	if instance.maxLength and #instance.text > instance.maxLength then
		instance.text = instance.text:sub(1, instance.maxLength)
	end
	local cursorPos = (config and config.cursorPos) or (#instance.text + 1)
	instance._cursorPos = math.min(math.max(1, cursorPos), #instance.text + 1)
	instance._viewOffset = 1
	if not instance.border then
		instance.border = normalize_border(true)
	end
	instance:_ensureCursorVisible()
	return instance
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

function TextBox:_setCursor(position)
	local len = #self.text
	position = math.max(1, math.min(position, len + 1))
	self._cursorPos = position
	self:_ensureCursorVisible()
end

function TextBox:_moveCursor(delta)
	self:_setCursor(self._cursorPos + delta)
end

function TextBox:_ensureCursorVisible()
	local width = self.width
	local visibleWidth = width > 2 and (width - 2) or width
	if visibleWidth < 1 then visibleWidth = 1 end
	local len = #self.text
	local view = self._viewOffset
	local cursor = self._cursorPos
	if cursor < view then
		view = cursor
	elseif cursor > view + visibleWidth - 1 then
		view = cursor - visibleWidth + 1
	end
	if len < visibleWidth then
		view = 1
	end
	if view < 1 then view = 1 end
	local maxStart = math.max(1, len - visibleWidth + 1)
	if view > maxStart then
		view = maxStart
	end
	self._viewOffset = view
end

function TextBox:_notifyChange()
	if self.onChange then
		self.onChange(self, self.text)
	end
end

function TextBox:_insertText(insert)
	if not insert or insert == "" then
		return false
	end
	if self.maxLength then
		local available = self.maxLength - #self.text
		if available <= 0 then
			return false
		end
		if #insert > available then
			insert = insert:sub(1, available)
		end
	end
	local before = self.text:sub(1, self._cursorPos - 1)
	local after = self.text:sub(self._cursorPos)
	self.text = before .. insert .. after
	self._cursorPos = self._cursorPos + #insert
	self:_ensureCursorVisible()
	self:_notifyChange()
	return true
end

function TextBox:_backspace()
	if self._cursorPos <= 1 then
		return false
	end
	local before = self.text:sub(1, self._cursorPos - 2)
	local after = self.text:sub(self._cursorPos)
	self.text = before .. after
	self._cursorPos = self._cursorPos - 1
	self:_ensureCursorVisible()
	self:_notifyChange()
	return true
end

function TextBox:_delete()
	if self._cursorPos > #self.text then
		return false
	end
	local before = self.text:sub(1, self._cursorPos - 1)
	local after = self.text:sub(self._cursorPos + 1)
	self.text = before .. after
	self:_ensureCursorVisible()
	self:_notifyChange()
	return true
end

function TextBox:_cursorFromPoint(x)
	local ax, _, width = self:getAbsoluteRect()
	local contentX = ax + (width > 2 and 1 or 0)
	local contentWidth = width > 2 and (width - 2) or width
	local offset = math.floor(x - contentX)
	if offset < 0 then offset = 0 end
	if offset > contentWidth then offset = contentWidth end
	return self._viewOffset + offset
end

---@since 0.1.0
---@param textLayer Layer
---@param pixelLayer Layer
function TextBox:draw(textLayer, pixelLayer)
	if not self.visible then
		return
	end
	local ax, ay, width, height = self:getAbsoluteRect()
	local bg = self.bg or colors.black
	local fg = self.fg or colors.white

	local innerX, innerY = ax + 1, ay + 1
	local innerWidth = math.max(0, width - 2)
	local innerHeight = math.max(0, height - 2)

	if innerWidth > 0 and innerHeight > 0 then
		fill_rect(textLayer, innerX, innerY, innerWidth, innerHeight, bg, bg)
	else
		fill_rect(textLayer, ax, ay, width, height, bg, bg)
	end

	clear_border_characters(textLayer, ax, ay, width, height)

	local contentWidth = innerWidth > 0 and innerWidth or width
	local contentX = innerWidth > 0 and innerX or ax
	local contentY
	if innerHeight > 0 then
		contentY = innerY + math.floor((innerHeight - 1) / 2)
	else
		contentY = ay
	end

	local startIdx = self._viewOffset
	local endIdx = startIdx + contentWidth - 1
	local slice = self.text:sub(startIdx, endIdx)
	if #slice < contentWidth then
		slice = slice .. string.rep(" ", contentWidth - #slice)
	end

	local renderText = slice
	local renderFg = fg
	local placeholderActive = (not self:isFocused()) and self.text == "" and type(self.placeholder) == "string" and #self.placeholder > 0
	if placeholderActive then
		renderText = self.placeholder
		if #renderText > contentWidth then
			renderText = renderText:sub(1, contentWidth)
		end
		if #renderText < contentWidth then
			renderText = renderText .. string.rep(" ", contentWidth - #renderText)
		end
		renderFg = colors.lightGray
	end

	if contentWidth > 0 then
		textLayer.text(contentX, contentY, renderText, renderFg, bg)
	end

	if self:isFocused() then
		local cursorCol = self._cursorPos - self._viewOffset + 1
		if cursorCol >= 1 and cursorCol <= contentWidth then
			local cursorChar = slice:sub(cursorCol, cursorCol)
			if cursorChar == "" then
				cursorChar = " "
			end
			textLayer.text(contentX + cursorCol - 1, contentY, cursorChar, bg, fg)
		end
	end

	if self.border then
		draw_border(pixelLayer, ax, ay, width, height, self.border, bg)
	end
end

---@since 0.1.0
---@param event string
function TextBox:handleEvent(event, ...)
	if not self.visible then
		return false
	end

	if event == "mouse_click" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_setCursor(self:_cursorFromPoint(x))
			return true
		end
	elseif event == "monitor_touch" then
		local _, x, y = ...
		if self:containsPoint(x, y) then
			self.app:setFocus(self)
			self:_setCursor(self:_cursorFromPoint(x))
			return true
		end
	elseif event == "mouse_drag" then
		local _, x, y = ...
		if self:isFocused() and self:containsPoint(x, y) then
			self:_setCursor(self:_cursorFromPoint(x))
			return true
		end
	elseif event == "char" then
		local ch = ...
		if self:isFocused() then
			return self:_insertText(ch)
		end
	elseif event == "paste" then
		local text = ...
		if self:isFocused() then
			return self:_insertText(text)
		end
	elseif event == "key" then
		local keyCode = ...
		if self:isFocused() then
			if keyCode == keys.left then
				self:_moveCursor(-1)
				return true
			elseif keyCode == keys.right then
				self:_moveCursor(1)
				return true
			elseif keyCode == keys.home then
				self:_setCursor(1)
				return true
			elseif keyCode == keys["end"] then
				self:_setCursor(#self.text + 1)
				return true
			elseif keyCode == keys.backspace then
				return self:_backspace()
			elseif keyCode == keys.delete then
				return self:_delete()
			end
		end
	end

	return false
end

---@since 0.1.0
---@param text string
function TextBox:setText(text)
	expect(1, text, "string")
	self.text = self:_applyMaxLength(text)
	self._cursorPos = math.min(self._cursorPos, #self.text + 1)
	self:_ensureCursorVisible()
	self:_notifyChange()
end

---@since 0.1.0
---@return string
function TextBox:getText()
	return self.text
end

---@since 0.1.0
---@param handler fun(self:PixelUI.TextBox, value:string)?
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
		_radioGroups = {}
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
---@return PixelUI.TreeView
function App:createTreeView(config)
	return TreeView:new(self, config)
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
end

---@since 0.1.0
function App:stop()
	self.running = false
	self:_clearAnimations(true)
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
	TextBox = function(app, config)
		return TextBox:new(app, config)
	end,
	ComboBox = function(app, config)
		return ComboBox:new(app, config)
	end,
	List = function(app, config)
		return List:new(app, config)
	end,
	TreeView = function(app, config)
		return TreeView:new(app, config)
	end,
	RadioButton = function(app, config)
		return RadioButton:new(app, config)
	end,
	ProgressBar = function(app, config)
		return ProgressBar:new(app, config)
	end,
	Slider = function(app, config)
		return Slider:new(app, config)
	end
}

pixelui.Widget = Widget
pixelui.Frame = Frame
pixelui.Button = Button
pixelui.Label = Label
pixelui.CheckBox = CheckBox
pixelui.TextBox = TextBox
pixelui.ComboBox = ComboBox
pixelui.List = List
pixelui.TreeView = TreeView
pixelui.RadioButton = RadioButton
pixelui.ProgressBar = ProgressBar
pixelui.Slider = Slider
pixelui.easings = easings

return pixelui
