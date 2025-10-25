---@diagnostic disable "undefined-field"
local colors = assert(rawget(_G, "colors"), "colors API unavailable")
local pixelui = require("pixelui")

---@type PixelUI.App
local app = pixelui.create({
	background = colors.black,
	rootBorder = {
		color = colors.gray,
		sides = { "top", "bottom" }
	}
})

---@type PixelUI.Frame
local root = app:getRoot()

---@type PixelUI.Frame
local showcase = app:createFrame({
	x = 4,
	y = 3,
	width = 38,
	height = 18,
	bg = colors.gray,
	fg = colors.white,
	title = "PixelUI Showcase",
	border = { color = colors.blue }
})
root:addChild(showcase)

---@type PixelUI.Frame
local infoFrame = app:createFrame({
	x = 3,
	y = 15,
	width = 32,
	height = 3,
	bg = colors.black,
	fg = colors.white,
	title = "",
	border = {
		color = colors.lightGray,
		sides = { "top" }
	}
})
showcase:addChild(infoFrame)

---@type PixelUI.Button
local clickButton = app:createButton({
	x = 3,
	y = 4,
	width = 32,
	height = 3,
	label = "Click Me!",
	bg = colors.orange,
	fg = colors.black,
	border = {
		color = colors.white
	},
	clickEffect = true
})
showcase:addChild(clickButton)

---@type PixelUI.Button
local borderButton = app:createButton({
	x = 3,
	y = 8,
	width = 32,
	height = 3,
	label = "Toggle Border",
	bg = colors.cyan,
	fg = colors.black,
	border = {
		color = colors.black,
		sides = { "left", "right" }
	},
	clickEffect = true
})
showcase:addChild(borderButton)

local clickCount = 0
local currentText = ""

local function updateInfo()
	local width = math.max(infoFrame.width - 2, 0)
	local textPreview = currentText
	if textPreview == "" then
		textPreview = "(empty)"
	end
	local message = ("Clicks:%d Text:%s"):format(clickCount, textPreview)
	if #message > width then
		message = message:sub(1, width)
	end
	infoFrame:setTitle(message)
end

---@type PixelUI.TextBox
local inputBox = app:createTextBox({
	x = 3,
	y = 12,
	width = 32,
	height = 3,
	bg = colors.black,
	fg = colors.white,
	placeholder = "Type here...",
	border = {
		color = colors.white
	},
	maxLength = 96
})
showcase:addChild(inputBox)

clickButton:setOnClick(function(btn)
	clickCount = clickCount + 1
	btn:setLabel("Clicks: " .. clickCount)
	updateInfo()
end)

local borderStates = {
	{ color = colors.blue, sides = { "top", "right", "bottom", "left" }, thickness = 1 },
	{ color = colors.green, sides = { "top", "bottom" }, thickness = 2 },
	{ color = colors.red, sides = { "left", "right" }, thickness = 1 }
}

local stateIndex = 1

local function applyBorderState()
	local state = borderStates[stateIndex]
	showcase:setBorder({
		color = state.color,
		sides = state.sides,
		thickness = state.thickness
	})
end

borderButton:setOnClick(function(btn)
	stateIndex = stateIndex % #borderStates + 1
	applyBorderState()
	btn:setLabel("Border Mode " .. stateIndex)
end)

inputBox:setOnChange(function(_, value)
	currentText = value
	updateInfo()
end)

updateInfo()
applyBorderState()
app:setFocus(inputBox)
app:run()
