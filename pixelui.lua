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
---@field widgets { Frame: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Frame, Button: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.Button, TextBox: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.TextBox, ComboBox: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.ComboBox, RadioButton: fun(app:PixelUI.App, config:PixelUI.WidgetConfig?):PixelUI.RadioButton }
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
---@return PixelUI.RadioButton
function App:createRadioButton(config)
	return RadioButton:new(self, config)
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
	TextBox = function(app, config)
		return TextBox:new(app, config)
	end,
	ComboBox = function(app, config)
		return ComboBox:new(app, config)
	end,
	RadioButton = function(app, config)
		return RadioButton:new(app, config)
	end
}

pixelui.Widget = Widget
pixelui.Frame = Frame
pixelui.Button = Button
pixelui.RadioButton = RadioButton
pixelui.TextBox = TextBox
pixelui.ComboBox = ComboBox
pixelui.easings = easings

return pixelui
