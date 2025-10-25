---@diagnostic disable "undefined-field"---@diagnostic disable "undefined-field"---@diagnostic disable "undefined-field"

local colors = assert(rawget(_G, "colors"), "colors API unavailable")

local pixelui = require("pixelui")local colors = assert(rawget(_G, "colors"), "colors API unavailable")local colors = assert(rawget(_G, "colors"), "colors API unavailable")



---@type PixelUI.Applocal pixelui = require("pixelui")local pixelui = require("pixelui")

local app = pixelui.create({

    background = colors.black,

    rootBorder = {

        color = colors.gray,---@type PixelUI.App---@type PixelUI.App

        sides = { "top" }

    }local app = pixelui.create({local app = pixelui.create({

})

    background = colors.black,	background = colors.black,

---@type PixelUI.Frame

local root = app:getRoot()    rootBorder = {	rootBorder = {



---@type PixelUI.Frame        color = colors.gray,		color = colors.gray,

local wizard = app:createFrame({

    x = 4,        sides = { "top" }		sides = { "top", "bottom" }

    y = 3,

    width = 34,    }	}

    height = 15,

    bg = colors.gray,})})

    fg = colors.white,

    border = { color = colors.lightGray }

})

root:addChild(wizard)local root = app:getRoot()---@type PixelUI.Frame



local steps = {}local navHeight = 3local root = app:getRoot()



local function addStep(frame, onShow)

    frame.visible = false

    steps[#steps + 1] = {local function clamp(value, minValue, maxValue)---@type PixelUI.Frame

        frame = frame,

        onShow = onShow    if value < minValue thenlocal showcase = app:createFrame({

    }

end        return minValue	x = 4,



local function centerWidget(widget, parent, w, h)    end	y = 3,

    local px = math.floor((parent.width - w) / 2) + 1

    local py = math.floor((parent.height - h) / 2) + 1    if value > maxValue then	width = 38,

    widget:setPosition(px, py)

end        return maxValue	height = 18,



-- Step 1: Button showcase    end	bg = colors.gray,

local buttonStep = app:createFrame({

    x = 2,    return value	fg = colors.white,

    y = 2,

    width = 30,end	title = "PixelUI Showcase",

    height = 11,

    bg = colors.gray,	border = { color = colors.blue }

    fg = colors.white

})local minWizardWidth = 8})

wizard:addChild(buttonStep)

local maxWizardWidth = math.max(minWizardWidth, root.width - 2)root:addChild(showcase)

local stepButton = app:createButton({

    width = 12,local wizardWidth = clamp(math.floor(root.width * 0.8), minWizardWidth, maxWizardWidth)

    height = 3,

    label = "Press",---@type PixelUI.Frame

    bg = colors.orange,

    fg = colors.black,local minWizardHeight = navHeight + 3local infoFrame = app:createFrame({

    border = { color = colors.white }

})local maxWizardHeight = math.max(minWizardHeight, root.height - 2)	x = 3,

centerWidget(stepButton, buttonStep, stepButton.width, stepButton.height)

buttonStep:addChild(stepButton)local wizardHeight = clamp(math.floor(root.height * 0.75), minWizardHeight, maxWizardHeight)	y = 17,

addStep(buttonStep)

	width = 32,

-- Step 2: TextBox showcase

local textStep = app:createFrame({local wizardX = math.max(1, math.floor((root.width - wizardWidth) / 2) + 1)	height = 2,

    x = 2,

    y = 2,local wizardY = math.max(1, math.floor((root.height - wizardHeight) / 2) + 1)	bg = colors.black,

    width = 30,

    height = 11,	fg = colors.white,

    bg = colors.gray,

    fg = colors.white---@type PixelUI.Frame	title = "",

})

wizard:addChild(textStep)local wizard = app:createFrame({	border = {



local stepBox = app:createTextBox({    x = wizardX,		color = colors.lightGray,

    width = 18,

    height = 3,    y = wizardY,		sides = { "top" }

    placeholder = "Type",

    bg = colors.black,    width = wizardWidth,	}

    fg = colors.white,

    border = { color = colors.white }    height = wizardHeight,})

})

centerWidget(stepBox, textStep, stepBox.width, stepBox.height)    bg = colors.gray,showcase:addChild(infoFrame)

textStep:addChild(stepBox)

addStep(textStep, function()    fg = colors.black,

    app:setFocus(stepBox)

end)    border = { color = colors.lightGray }---@type PixelUI.Button



-- Step 3: ComboBox showcase})local clickButton = app:createButton({

local comboStep = app:createFrame({

    x = 2,root:addChild(wizard)	x = 3,

    y = 2,

    width = 30,	y = 4,

    height = 11,

    bg = colors.gray,local pageWidth = math.max(8, wizard.width - 4)	width = 32,

    fg = colors.white

})local pageHeight = math.max(3, wizard.height - navHeight - 3)	height = 3,

wizard:addChild(comboStep)

	label = "Click Me!",

local stepCombo = app:createComboBox({

    width = 20,local function centerX(width)	bg = colors.orange,

    height = 3,

    items = { "Small", "Medium", "Large", "Extra" },    return math.max(1, math.floor((pageWidth - width) / 2) + 1)	fg = colors.black,

    bg = colors.black,

    fg = colors.white,end	border = {

    dropdownBg = colors.black,

    dropdownFg = colors.white,		color = colors.white

    highlightBg = colors.lightGray,

    highlightFg = colors.black,local function centerY(height)	},

    border = { color = colors.white }

})    return math.max(1, math.floor((pageHeight - height) / 2) + 1)	clickEffect = true

centerWidget(stepCombo, comboStep, stepCombo.width, stepCombo.height)

comboStep:addChild(stepCombo)end})

addStep(comboStep)

showcase:addChild(clickButton)

local currentStep = 1

local pages = {}

local function showStep(index)

    if index < 1 or index > #steps then---@type PixelUI.Button

        return

    endlocal function addPage(frame)local borderButton = app:createButton({

    for i = 1, #steps do

        steps[i].frame.visible = (i == index)    pages[#pages + 1] = { root = frame }	x = 3,

    end

    currentStep = index    return pages[#pages]	y = 8,

    local step = steps[index]

    if step.onShow thenend	width = 32,

        step.onShow()

    else	height = 3,

        app:setFocus(nil)

    end-- Frame showcase	label = "Toggle Border",

end

local framePage = app:createFrame({	bg = colors.cyan,

---@type PixelUI.Button

local prevButton = app:createButton({    x = 2,	fg = colors.black,

    x = wizard.x,

    y = wizard.y + wizard.height + 1,    y = 2,	border = {

    width = 10,

    height = 3,    width = pageWidth,		color = colors.black,

    label = "Prev",

    bg = colors.lightGray,    height = pageHeight,		sides = { "left", "right" }

    fg = colors.black,

    border = { color = colors.white }    bg = colors.black,	},

})

root:addChild(prevButton)    fg = colors.white,	clickEffect = true



---@type PixelUI.Button    border = { color = colors.lightGray },})

local nextButton = app:createButton({

    x = wizard.x + wizard.width - 10,    visible = #pages == 0showcase:addChild(borderButton)

    y = wizard.y + wizard.height + 1,

    width = 10,})

    height = 3,

    label = "Next",framePage:setTitle("Frame")local clickCount = 0

    bg = colors.lightGray,

    fg = colors.black,wizard:addChild(framePage)local currentText = ""

    border = { color = colors.white }

})local selectedTheme = "Classic"

root:addChild(nextButton)

local accentWidth = math.max(6, math.floor(pageWidth / 2))

prevButton:setOnClick(function()

    local target = currentStep - 1local accentHeight = math.max(4, math.floor(pageHeight / 2))local themeOptions = {

    if target < 1 then

        target = #stepslocal accentFrame = app:createFrame({	{ label = "Classic", frameBg = colors.gray, infoBg = colors.black, infoFg = colors.white },

    end

    showStep(target)    x = centerX(accentWidth),	{ label = "Ocean", frameBg = colors.blue, infoBg = colors.black, infoFg = colors.white },

end)

    y = centerY(accentHeight),	{ label = "Sunset", frameBg = colors.orange, infoBg = colors.brown, infoFg = colors.white },

nextButton:setOnClick(function()

    local target = currentStep + 1    width = accentWidth,	{ label = "Mono", frameBg = colors.lightGray, infoBg = colors.gray, infoFg = colors.black }

    if target > #steps then

        target = 1    height = accentHeight,}

    end

    showStep(target)    bg = colors.gray,

end)

    fg = colors.white,local themeItems = {}

showStep(1)

app:run()    border = { color = colors.blue }for i = 1, #themeOptions do


})	themeItems[i] = themeOptions[i].label

framePage:addChild(accentFrame)end

addPage(framePage)

---@type PixelUI.ComboBox

-- Button showcaselocal themeBox = app:createComboBox({

local buttonPage = app:createFrame({	x = 3,

    x = 2,	y = 11,

    y = 2,	width = 32,

    width = pageWidth,	height = 3,

    height = pageHeight,	items = themeItems,

    bg = colors.black,	bg = colors.black,

    fg = colors.white,	fg = colors.white,

    border = { color = colors.lightGray },	dropdownBg = colors.black,

    visible = false	dropdownFg = colors.white,

})	highlightBg = colors.lightGray,

buttonPage:setTitle("Button")	highlightFg = colors.black,

wizard:addChild(buttonPage)	placeholder = "Pick a theme...",

	border = {

local buttonWidth = math.max(7, math.min(pageWidth - 2, 14))		color = colors.white

local button = app:createButton({	}

    x = centerX(buttonWidth),})

    y = centerY(3),showcase:addChild(themeBox)

    width = buttonWidth,

    height = 3,local function updateInfo()

    label = "Press",	local width = math.max(infoFrame.width - 2, 0)

    bg = colors.orange,	local textPreview = currentText

    fg = colors.black,	if textPreview == "" then

    border = { color = colors.white }		textPreview = "(empty)"

})	end

buttonPage:addChild(button)	local message = ("Clicks:%d Text:%s Theme:%s"):format(clickCount, textPreview, selectedTheme)

button:setOnClick(function(btn)	if #message > width then

    if btn.label == "Press" then		message = message:sub(1, width)

        btn:setLabel("Pressed")	end

    else	infoFrame:setTitle(message)

        btn:setLabel("Press")end

    end

end)---@type PixelUI.TextBox

addPage(buttonPage)local inputBox = app:createTextBox({

	x = 3,

-- TextBox showcase	y = 14,

local textPage = app:createFrame({	width = 32,

    x = 2,	height = 3,

    y = 2,	bg = colors.black,

    width = pageWidth,	fg = colors.white,

    height = pageHeight,	placeholder = "Type here...",

    bg = colors.black,	border = {

    fg = colors.white,		color = colors.white

    border = { color = colors.lightGray },	},

    visible = false	maxLength = 96

})})

textPage:setTitle("TextBox")showcase:addChild(inputBox)

wizard:addChild(textPage)

local function applyTheme(index)

local textWidth = math.max(10, pageWidth - 2)	local theme = themeOptions[index]

local textBox = app:createTextBox({	if not theme then

    x = centerX(textWidth),		return

    y = centerY(3),	end

    width = textWidth,	local frameBg = theme.frameBg or colors.gray

    height = 3,	local infoBg = theme.infoBg or colors.black

    placeholder = "type",	local textFg = theme.infoFg or colors.white

    bg = colors.black,

    fg = colors.white,	showcase.bg = frameBg

    border = { color = colors.white }	showcase.fg = textFg

})	infoFrame.bg = infoBg

textPage:addChild(textBox)	infoFrame.fg = textFg

addPage(textPage).focus = textBox	themeBox.bg = infoBg

	themeBox.fg = textFg

-- ComboBox showcase	themeBox.dropdownBg = infoBg

local comboPage = app:createFrame({	themeBox.dropdownFg = textFg

    x = 2,	inputBox.bg = infoBg

    y = 2,	inputBox.fg = textFg

    width = pageWidth,end

    height = pageHeight,

    bg = colors.black,themeBox:setOnChange(function(_, item, index)

    fg = colors.white,	if item then

    border = { color = colors.lightGray },		selectedTheme = item

    visible = false	end

})	if index then

comboPage:setTitle("ComboBox")		applyTheme(index)

wizard:addChild(comboPage)	end

	updateInfo()

local comboWidth = math.max(12, pageWidth - 2)end)

local comboBox = app:createComboBox({

    x = centerX(comboWidth),applyTheme(themeBox.selectedIndex or 1)

    y = centerY(3),

    width = comboWidth,clickButton:setOnClick(function(btn)

    height = 3,	clickCount = clickCount + 1

    items = { "One", "Two", "Three", "Four" },	btn:setLabel("Clicks: " .. clickCount)

    bg = colors.black,	updateInfo()

    fg = colors.white,end)

    border = { color = colors.white }

})local borderStates = {

comboPage:addChild(comboBox)	{ color = colors.blue, sides = { "top", "right", "bottom", "left" }, thickness = 1 },

comboBox:setSelectedIndex(2, true)	{ color = colors.green, sides = { "top", "bottom" }, thickness = 2 },

addPage(comboPage).focus = comboBox	{ color = colors.red, sides = { "left", "right" }, thickness = 1 }

}

local totalPages = #pages

local navButtonWidth = math.max(6, math.floor((wizard.width - 6) / 2))local stateIndex = 1

if navButtonWidth > wizard.width - 4 then

    navButtonWidth = wizard.width - 4local function applyBorderState()

end	local state = borderStates[stateIndex]

local navY = wizard.height - navHeight	showcase:setBorder({

		color = state.color,

---@type PixelUI.Button		sides = state.sides,

local prevButton = app:createButton({		thickness = state.thickness

    x = 2,	})

    y = navY,end

    width = navButtonWidth,

    height = navHeight,borderButton:setOnClick(function(btn)

    label = "< Prev",	stateIndex = stateIndex % #borderStates + 1

    bg = colors.black,	applyBorderState()

    fg = colors.white,	btn:setLabel("Border Mode " .. stateIndex)

    border = { color = colors.lightGray }end)

})

wizard:addChild(prevButton)inputBox:setOnChange(function(_, value)

	currentText = value

---@type PixelUI.Button	updateInfo()

local nextButton = app:createButton({end)

    x = wizard.width - navButtonWidth,

    y = navY,updateInfo()

    width = navButtonWidth,applyBorderState()

    height = navHeight,app:setFocus(inputBox)

    label = "> Next",app:run()

    bg = colors.black,
    fg = colors.white,
    border = { color = colors.lightGray }
})
wizard:addChild(nextButton)

local currentPage = 1

local function showPage(index)
    if totalPages == 0 then
        return
    end
    if index < 1 then
        index = 1
    elseif index > totalPages then
        index = totalPages
    end
    for i = 1, totalPages do
        pages[i].root.visible = (i == index)
    end
    currentPage = index
    wizard:setTitle(("Step %d/%d"):format(index, totalPages))

    if totalPages == 1 then
        prevButton.visible = false
        nextButton.visible = false
    else
        prevButton.visible = index > 1
        nextButton.visible = true
        nextButton:setLabel(index == totalPages and "Restart" or "> Next")
    end

    local focusTarget = pages[index].focus
    if focusTarget then
        app:setFocus(focusTarget)
    else
        app:setFocus(nil)
    end
end

prevButton:setOnClick(function()
    if totalPages == 0 then
        return
    end
    local target = currentPage - 1
    if target < 1 then
        target = totalPages
    end
    showPage(target)
end)

nextButton:setOnClick(function()
    if totalPages == 0 then
        return
    end
    local target = (currentPage % totalPages) + 1
    showPage(target)
end)

showPage(1)
app:run()
