---@diagnostic disable "undefined-field"
local colors = assert(rawget(_G, "colors"), "colors API unavailable")
local pixelui = require("pixelui")

---@type PixelUI.App
local app = pixelui.create({
    background = colors.black,
    rootBorder = {
        color = colors.gray,
        sides = { "top" }
    }
})

---@type PixelUI.Frame
local root = app:getRoot()

---@type PixelUI.Frame
local wizard = app:createFrame({
    x = 4,
    y = 3,
    width = 34,
    height = 15,
    bg = colors.gray,
    fg = colors.white,
    border = { color = colors.lightGray }
})
root:addChild(wizard)

local steps = {}
local currentStep = 1
local navHeight = 3
local navGap = 1
local innerMargin = 1

local function clamp(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end
    if value > maxValue then
        return maxValue
    end
    return value
end

local function round(value)
    if value >= 0 then
        return math.floor(value + 0.5)
    end
    return math.ceil(value - 0.5)
end

local isAnimating = false

local function applyStepVisibility(activeIndex)
    for i = 1, #steps do
        local frame = steps[i].frame
        if i == activeIndex then
            frame.visible = true
        else
            frame.visible = false
        end
        frame:setPosition(innerMargin, innerMargin)
    end
end

local function addStep(frame, onShow, onHide)
    frame.visible = false
    local index = #steps + 1
    steps[index] = {
        frame = frame,
        onShow = onShow,
        onHide = onHide
    }
    return index
end

local function centerWidget(widget, parent, w, h)
    local px = math.floor((parent.width - w) / 2) + 1
    local py = math.floor((parent.height - h) / 2) + 1
    widget:setPosition(px, py)
end

local radioButtons = {}
local radioDefaultWidths = {}
local selectedRadio
local listWidget
local listDefaults = {}
local labelTitle
local labelBody
local labelDefaults = {}
local sliderSingle
local sliderRange
local sliderDefaults = {}
local checkboxWidgets = {}
local checkboxDefaults = {}
local checkboxStatus
local checkboxStatusDefaults = {}
local treeView
local treeDefaults = {}
local treeInfoLabel
local treeInfoDefaults = {}
local progressDeterminate
local progressIndeterminate
local progressDefaults = {}
local progressAnimationHandle
local progressStepIndex

-- Step 1: Button showcase
local buttonStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(buttonStep)

local stepButton = app:createButton({
    width = 12,
    height = 3,
    label = "Press",
    bg = colors.orange,
    fg = colors.black,
    border = { color = colors.white }
})
local defaultButtonSize = { width = stepButton.width, height = stepButton.height }
centerWidget(stepButton, buttonStep, stepButton.width, stepButton.height)
buttonStep:addChild(stepButton)
addStep(buttonStep)

-- Step 2: TextBox showcase
local textStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(textStep)

local stepBox = app:createTextBox({
    width = 18,
    height = 3,
    placeholder = "Type",
    bg = colors.black,
    fg = colors.white,
    border = { color = colors.white }
})
local defaultTextBoxSize = { width = stepBox.width, height = stepBox.height }
centerWidget(stepBox, textStep, stepBox.width, stepBox.height)
textStep:addChild(stepBox)
addStep(textStep, function()
    app:setFocus(stepBox)
end)

-- Step 3: ComboBox showcase
local comboStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(comboStep)

local stepCombo = app:createComboBox({
    width = 20,
    height = 3,
    items = { "Small", "Medium", "Large", "Extra Large" },
    bg = colors.black,
    fg = colors.white,
    dropdownBg = colors.black,
    dropdownFg = colors.white,
    highlightBg = colors.lightGray,
    highlightFg = colors.black,
    border = { color = colors.white }
})
local defaultComboSize = { width = stepCombo.width, height = stepCombo.height }
centerWidget(stepCombo, comboStep, stepCombo.width, stepCombo.height)
comboStep:addChild(stepCombo)
addStep(comboStep)

-- Step 4: List showcase
local listStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(listStep)

listWidget = app:createList({
    x = 2,
    y = 2,
    width = 24,
    height = 7,
    items = {
        "Buttons",
        "Form Inputs",
        "Selectors",
        "Lists",
        "Animations",
        "Data Views"
    },
    bg = colors.gray,
    fg = colors.white,
    highlightBg = colors.lightGray,
    highlightFg = colors.black,
    border = { color = colors.lightGray }
})
listStep:addChild(listWidget)
listDefaults.width = listWidget.width
listDefaults.height = listWidget.height
addStep(listStep, function()
    if listWidget then
        app:setFocus(listWidget)
    end
end, function()
    if listWidget and listWidget:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 5: Label showcase
local labelStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(labelStep)

labelTitle = app:createLabel({
    width = 26,
    height = 1,
    text = "Responsive labels",
    align = "center",
    bg = colors.gray,
    fg = colors.white
})
labelStep:addChild(labelTitle)

labelBody = app:createLabel({
    x = 2,
    y = 3,
    width = 26,
    height = 6,
    wrap = true,
    align = "left",
    verticalAlign = "top",
    text = "Labels now support optional wrapping so longer descriptions can adapt to the layout. Resize the terminal to watch this paragraph reflow automatically.",
    bg = colors.gray,
    fg = colors.white
})
labelStep:addChild(labelBody)

labelDefaults = {
    title = { width = labelTitle.width, height = labelTitle.height },
    body = { width = labelBody.width, height = labelBody.height }
}
addStep(labelStep)

-- Step 6: RadioButton showcase
local radioStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(radioStep)

local radioOptions = {
    { label = "Classic", value = "classic" },
    { label = "Modern", value = "modern" },
    { label = "Minimal", value = "minimal" }
}

for index = 1, #radioOptions do
    local option = radioOptions[index]
    local radio = app:createRadioButton({
        x = 2,
        y = 1 + (index - 1) * 2,
        width = 22,
        height = 1,
        label = option.label,
        value = option.value,
        group = "demoStyle",
        selected = index == 2,
        bg = colors.gray,
        fg = colors.white,
        focusBg = colors.lightGray,
        focusFg = colors.black
    })
    radioStep:addChild(radio)
    radioButtons[index] = radio
    radioDefaultWidths[index] = radio.width
    if radio:isSelected() then
        selectedRadio = radio
    end
    radio:setOnChange(function(selfRadio, isSelected)
        if isSelected then
            selectedRadio = selfRadio
        end
    end)
end
addStep(radioStep, function()
    if selectedRadio and selectedRadio:isSelected() then
        app:setFocus(selectedRadio)
    else
        app:setFocus(nil)
    end
end)

-- Step 7: Slider showcase
local sliderStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(sliderStep)

sliderSingle = app:createSlider({
    x = 2,
    y = 2,
    width = 24,
    height = 3,
    min = 0,
    max = 100,
    value = 40,
    step = 5,
    showValue = true,
    trackColor = colors.gray,
    fillColor = colors.cyan,
    handleColor = colors.white,
    bg = colors.gray,
    fg = colors.white,
    formatValue = function(_, value)
        return string.format("%d%%", math.floor(value + 0.5))
    end
})
sliderStep:addChild(sliderSingle)

sliderRange = app:createSlider({
    x = 2,
    y = 6,
    width = 24,
    height = 3,
    min = 0,
    max = 24,
    range = true,
    startValue = 8,
    endValue = 18,
    step = 1,
    showValue = true,
    trackColor = colors.gray,
    fillColor = colors.orange,
    handleColor = colors.white,
    bg = colors.gray,
    fg = colors.white,
    formatValue = function(_, lower, upper)
        return string.format("%02d:00-%02d:00", lower, upper)
    end
})
sliderStep:addChild(sliderRange)

sliderDefaults = {
    single = { width = sliderSingle.width, height = sliderSingle.height },
    range = { width = sliderRange.width, height = sliderRange.height }
}

addStep(sliderStep, function()
    if sliderSingle then
        app:setFocus(sliderSingle)
    end
end, function()
    local focus = app:getFocus()
    if focus == sliderSingle or focus == sliderRange then
        app:setFocus(nil)
    end
end)

-- Step 8: CheckBox showcase
local checkboxStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(checkboxStep)

local checkboxOptions = {
    { label = "Enable animations", checked = true },
    { label = "Show tooltips", checked = false, allowIndeterminate = true, indeterminate = true },
    { label = "Sync to cloud", checked = true }
}

for index = 1, #checkboxOptions do
    local option = checkboxOptions[index]
    local checkbox = app:createCheckBox({
        x = 2,
        y = 1 + (index - 1) * 2,
        width = 26,
        label = option.label,
        checked = option.checked,
        allowIndeterminate = option.allowIndeterminate,
        indeterminate = option.indeterminate,
        bg = colors.gray,
        fg = colors.white,
        focusBg = colors.lightGray,
        focusFg = colors.black
    })
    checkboxStep:addChild(checkbox)
    checkboxWidgets[index] = checkbox
    checkboxDefaults[index] = checkbox.width
end

checkboxStatus = app:createLabel({
    x = 2,
    y = 7,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    verticalAlign = "top",
    text = "",
    bg = colors.gray,
    fg = colors.white
})
checkboxStep:addChild(checkboxStatus)
checkboxStatusDefaults = { width = checkboxStatus.width, height = checkboxStatus.height }

local function updateCheckboxSummary()
    if not checkboxStatus then
        return
    end
    local enabled = {}
    local pending = {}
    for i = 1, #checkboxWidgets do
        local widget = checkboxWidgets[i]
        if widget then
            if widget:isIndeterminate() then
                pending[#pending + 1] = widget.label or ("Option " .. i)
            elseif widget:isChecked() then
                enabled[#enabled + 1] = widget.label or ("Option " .. i)
            end
        end
    end
    local parts = {}
    if #enabled > 0 then
        parts[#parts + 1] = "On: " .. table.concat(enabled, ", ")
    end
    if #pending > 0 then
        parts[#parts + 1] = "Pending: " .. table.concat(pending, ", ")
    end
    if #parts == 0 then
        checkboxStatus:setText("All features disabled.")
    else
        checkboxStatus:setText(table.concat(parts, "  "))
    end
end

for index = 1, #checkboxWidgets do
    local widget = checkboxWidgets[index]
    if widget then
        widget:setOnChange(function()
            updateCheckboxSummary()
        end)
    end
end
updateCheckboxSummary()

addStep(checkboxStep, function()
    if checkboxWidgets[1] then
        app:setFocus(checkboxWidgets[1])
    end
end, function()
    local focus = app:getFocus()
    if focus then
        for i = 1, #checkboxWidgets do
            if checkboxWidgets[i] == focus then
                app:setFocus(nil)
                break
            end
        end
    end
end)

-- Step 9: TreeView showcase
local treeStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(treeStep)

local treeNodes = {
    {
        label = "UI Components",
        expanded = true,
        children = {
            { label = "Buttons" },
            { label = "Inputs", children = {
                { label = "TextBox" },
                { label = "ComboBox" },
                { label = "CheckBox" }
            } },
            { label = "Selectors", children = {
                { label = "List" },
                { label = "TreeView" },
                { label = "Progress" }
            } }
        }
    },
    {
        label = "Layout",
        expanded = false,
        children = {
            { label = "Frames" },
            { label = "Spacing" },
            { label = "Animation" }
        }
    },
    {
        label = "Data",
        expanded = false,
        children = {
            { label = "Bindings" },
            { label = "Validation" }
        }
    }
}

treeView = app:createTreeView({
    x = 2,
    y = 2,
    width = 24,
    height = 6,
    nodes = treeNodes,
    bg = colors.gray,
    fg = colors.white,
    highlightBg = colors.lightGray,
    highlightFg = colors.black,
    placeholder = "No items"
})
treeStep:addChild(treeView)
treeDefaults = { width = treeView.width, height = treeView.height }

treeInfoLabel = app:createLabel({
    x = 2,
    y = 8,
    width = 26,
    height = 2,
    wrap = true,
    text = "Select an item to see details.",
    bg = colors.gray,
    fg = colors.white
})
treeStep:addChild(treeInfoLabel)
treeInfoDefaults = { width = treeInfoLabel.width, height = treeInfoLabel.height }

local function treePath(node)
    if not node then
        return nil
    end
    local parts = {}
    local current = node
    while current do
        parts[#parts + 1] = current.label or "?"
        current = current.parent
    end
    for i = 1, math.floor(#parts / 2) do
        parts[i], parts[#parts - i + 1] = parts[#parts - i + 1], parts[i]
    end
    return table.concat(parts, " / ")
end

local function updateTreeInfo(node)
    if not treeInfoLabel then
        return
    end
    if not node then
        treeInfoLabel:setText("Select an item to see details.")
        return
    end
    local path = treePath(node)
    treeInfoLabel:setText("Selected: " .. (path or "(unknown)"))
end

treeView:setOnSelect(function(_, node)
    updateTreeInfo(node)
end)
updateTreeInfo(treeView:getSelectedNode())

addStep(treeStep, function()
    if treeView then
        app:setFocus(treeView)
    end
end, function()
    if treeView and treeView:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 10: ProgressBar showcase
local progressStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(progressStep)

progressDeterminate = app:createProgressBar({
    x = 2,
    y = 3,
    width = 24,
    height = 3,
    min = 0,
    max = 100,
    value = 0,
    label = "Downloading",
    showPercent = true,
    bg = colors.gray,
    fg = colors.white,
    trackColor = colors.gray,
    fillColor = colors.green,
    border = { color = colors.lightGray }
})
progressStep:addChild(progressDeterminate)

progressIndeterminate = app:createProgressBar({
    x = 2,
    y = 7,
    width = 24,
    height = 3,
    label = "Searching...",
    indeterminate = false,
    bg = colors.gray,
    fg = colors.white,
    trackColor = colors.gray,
    fillColor = colors.orange,
    border = { color = colors.lightGray }
})
progressStep:addChild(progressIndeterminate)

progressDefaults = {
    determinate = { width = progressDeterminate.width, height = progressDeterminate.height },
    indeterminate = { width = progressIndeterminate.width, height = progressIndeterminate.height }
}

local function stopProgressAnimation()
    if progressAnimationHandle then
        progressAnimationHandle:cancel()
        progressAnimationHandle = nil
    end
end

local function startProgressAnimation()
    stopProgressAnimation()
    local minValue, maxValue = progressDeterminate:getRange()
    progressDeterminate:setValue(minValue)
    progressAnimationHandle = app:animate({
        duration = 2.5,
        easing = pixelui.easings.easeInOutQuad,
        update = function(_, raw)
            local value = minValue + (maxValue - minValue) * raw
            progressDeterminate:setValue(value)
        end,
        onComplete = function()
            progressAnimationHandle = nil
            if currentStep == progressStepIndex then
                startProgressAnimation()
            end
        end,
        onCancel = function()
            progressAnimationHandle = nil
        end
    })
end

progressStepIndex = addStep(progressStep, function()
    startProgressAnimation()
    if progressIndeterminate then
        progressIndeterminate:setIndeterminate(false)
        progressIndeterminate:setIndeterminate(true)
    end
    app:setFocus(nil)
end, function()
    stopProgressAnimation()
    if progressDeterminate then
        local minValue = select(1, progressDeterminate:getRange())
        progressDeterminate:setValue(minValue)
    end
    if progressIndeterminate then
        progressIndeterminate:setIndeterminate(false)
    end
end)

local function showStep(index, direction)
    if index < 1 or index > #steps then
        return
    end

    if direction == nil then
        direction = (index > currentStep) and 1 or -1
    end

    if direction == 0 or #steps <= 1 then
        local previousIndex = currentStep
        if previousIndex ~= index then
            local previous = steps[previousIndex]
            if previous and previous.onHide then
                previous.onHide()
            end
        end
        currentStep = index
        applyStepVisibility(index)
        local step = steps[index]
        if step and step.onShow then
            step.onShow()
        else
            app:setFocus(nil)
        end
        return
    end

    if index == currentStep or isAnimating then
        return
    end

    local prevIndex = currentStep
    local prevStep = steps[prevIndex]
    local nextStep = steps[index]
    if not prevStep or not nextStep then
        return
    end

    if prevStep.onHide then
        prevStep.onHide()
    end

    direction = direction >= 0 and 1 or -1
    local stepWidth = nextStep.frame.width
    local distance = math.max(1, stepWidth + innerMargin)

    prevStep.frame.visible = true
    prevStep.frame:setPosition(innerMargin, innerMargin)
    nextStep.frame.visible = true
    nextStep.frame:setPosition(innerMargin + direction * distance, innerMargin)

    app:setFocus(nil)
    isAnimating = true
    local targetOnShow = nextStep.onShow

    app:animate({
        duration = 0.3,
        easing = pixelui.easings.easeOutCubic,
        update = function(value)
            local prevX = innerMargin + round(-distance * direction * value)
            local nextX = innerMargin + round(direction * distance * (1 - value))
            prevStep.frame:setPosition(prevX, innerMargin)
            nextStep.frame:setPosition(nextX, innerMargin)
        end,
        onComplete = function()
            currentStep = index
            applyStepVisibility(index)
            isAnimating = false
            if targetOnShow then
                targetOnShow()
            else
                app:setFocus(nil)
            end
        end,
        onCancel = function()
            applyStepVisibility(currentStep)
            isAnimating = false
        end
    })
end

---@type PixelUI.Button
local prevButton = app:createButton({
    x = wizard.x,
    y = wizard.y + wizard.height + 1,
    width = 10,
    height = 3,
    label = "Prev",
    bg = colors.lightGray,
    fg = colors.black,
    border = { color = colors.white }
})
root:addChild(prevButton)

---@type PixelUI.Button
local nextButton = app:createButton({
    x = wizard.x + wizard.width - 10,
    y = wizard.y + wizard.height + 1,
    width = 10,
    height = 3,
    label = "Next",
    bg = colors.lightGray,
    fg = colors.black,
    border = { color = colors.white }
})
root:addChild(nextButton)

local function layout()
    local rootWidth = root.width
    local rootHeight = root.height
    local actualNavHeight = math.max(navHeight, prevButton.height, nextButton.height)

    local maxWizardWidth = math.max(6, rootWidth - 2)
    local desiredWizardWidth = math.floor(rootWidth * 0.75)
    local wizardWidth = clamp(desiredWizardWidth, 12, maxWizardWidth)

    local availableHeight = math.max(5, rootHeight - actualNavHeight - navGap - 1)
    local desiredWizardHeight = math.floor(rootHeight * 0.6)
    local wizardHeight = clamp(desiredWizardHeight, 7, availableHeight)

    wizard:setSize(wizardWidth, wizardHeight)
    local maxWizardX = math.max(1, rootWidth - wizardWidth + 1)
    local wizardX = clamp(math.floor((rootWidth - wizardWidth) / 2) + 1, 1, maxWizardX)
    local maxWizardY = math.max(1, rootHeight - actualNavHeight - navGap - wizardHeight + 1)
    local wizardY = clamp(math.floor((rootHeight - (wizardHeight + actualNavHeight + navGap)) / 2) + 1, 1, maxWizardY)
    wizard:setPosition(wizardX, wizardY)

    local stepWidth = math.max(6, wizardWidth - innerMargin * 2)
    local stepHeight = math.max(5, wizardHeight - innerMargin * 2)
    for i = 1, #steps do
        local frame = steps[i].frame
        frame:setSize(stepWidth, stepHeight)
    end

    if not isAnimating then
        applyStepVisibility(currentStep)
        local active = steps[currentStep]
        if active then
            if active.onShow then
                active.onShow()
            else
                app:setFocus(nil)
            end
        end
    end

    local buttonWidth = math.max(4, math.min(defaultButtonSize.width, stepWidth))
    local buttonHeight = math.min(defaultButtonSize.height, stepHeight)
    stepButton:setSize(buttonWidth, buttonHeight)
    centerWidget(stepButton, buttonStep, buttonWidth, buttonHeight)

    local textWidthLimit = math.max(4, stepWidth - 2)
    local textWidth = math.max(4, math.min(defaultTextBoxSize.width, textWidthLimit))
    local textHeight = math.min(defaultTextBoxSize.height, stepHeight)
    stepBox:setSize(textWidth, textHeight)
    centerWidget(stepBox, textStep, textWidth, textHeight)

    local comboWidthLimit = math.max(6, stepWidth - 2)
    local comboWidth = math.max(6, math.min(defaultComboSize.width, comboWidthLimit))
    local comboHeight = math.min(defaultComboSize.height, stepHeight)
    stepCombo:setSize(comboWidth, comboHeight)
    centerWidget(stepCombo, comboStep, comboWidth, comboHeight)

    if listWidget then
        local listWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local listHeightLimit = math.max(3, stepHeight - innerMargin * 2)
        local baseWidth = listDefaults.width or listWidget.width
        local baseHeight = listDefaults.height or listWidget.height
        local listWidth = math.max(6, math.min(baseWidth, listWidthLimit))
        local listHeight = math.max(3, math.min(baseHeight, listHeightLimit))
        listWidget:setSize(listWidth, listHeight)
        centerWidget(listWidget, listStep, listWidth, listHeight)
    end

    if labelTitle and labelBody then
        local labelWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local titleDefaults = (labelDefaults and labelDefaults.title) or { width = labelTitle.width, height = labelTitle.height }
        local bodyDefaults = (labelDefaults and labelDefaults.body) or { width = labelBody.width, height = labelBody.height }
        local bodyWidth = math.max(6, math.min(bodyDefaults.width or labelBody.width, labelWidthLimit))
        local bodyHeightLimit = math.max(3, stepHeight - innerMargin * 2)
        local bodyHeight = math.max(2, math.min(bodyDefaults.height or labelBody.height, bodyHeightLimit))
        labelBody:setSize(bodyWidth, bodyHeight)
        local bodyX = math.floor((labelStep.width - bodyWidth) / 2) + 1
        local bodyY = innerMargin + 1
        if bodyY + bodyHeight - 1 > innerMargin + stepHeight - 1 then
            bodyY = math.max(innerMargin, innerMargin + stepHeight - bodyHeight)
        end
        labelBody:setPosition(bodyX, bodyY)

        local titleWidth = math.max(4, math.min(titleDefaults.width or labelTitle.width, labelWidthLimit))
        local titleHeight = math.max(1, titleDefaults.height or labelTitle.height)
        labelTitle:setSize(titleWidth, titleHeight)
        local titleX = math.floor((labelStep.width - titleWidth) / 2) + 1
        local titleY = math.max(innerMargin, bodyY - 1)
        labelTitle:setPosition(titleX, titleY)
    end

    if #radioButtons > 0 then
        local maxRadioWidth = math.max(4, stepWidth - innerMargin)
        local freeRows = math.max(0, stepHeight - #radioButtons)
        local gap = (#radioButtons > 1) and math.floor(freeRows / (#radioButtons - 1)) or 0
        local radioY = innerMargin
        for index = 1, #radioButtons do
            local radio = radioButtons[index]
            if radio then
                local presetWidth = radioDefaultWidths[index] or radio.width
                local radioWidth = math.max(4, math.min(presetWidth, maxRadioWidth))
                radio:setSize(radioWidth, 1)
                -- center horizontally within the radioStep frame
                local centerX = math.floor((radioStep.width - radioWidth) / 2) + 1
                radio:setPosition(centerX, radioY)
                if radio:isSelected() then
                    selectedRadio = radio
                end
                radioY = math.min(innerMargin + stepHeight - 1, radioY + 1 + gap)
            end
        end
    end

    if sliderSingle and sliderRange then
        local sliderWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local singleDefaults = (sliderDefaults and sliderDefaults.single) or { width = sliderSingle.width, height = sliderSingle.height }
        local rangeDefaults = (sliderDefaults and sliderDefaults.range) or { width = sliderRange.width, height = sliderRange.height }
        local singleWidth = math.max(6, math.min(singleDefaults.width or sliderSingle.width, sliderWidthLimit))
        local rangeWidth = math.max(6, math.min(rangeDefaults.width or sliderRange.width, sliderWidthLimit))
        local singleHeight = math.max(2, singleDefaults.height or sliderSingle.height)
        local rangeHeight = math.max(2, rangeDefaults.height or sliderRange.height)
        sliderSingle:setSize(singleWidth, singleHeight)
        sliderRange:setSize(rangeWidth, rangeHeight)
        local singleX = math.floor((sliderStep.width - singleWidth) / 2) + 1
        local rangeX = math.floor((sliderStep.width - rangeWidth) / 2) + 1
        local verticalSpace = math.max(0, stepHeight - singleHeight - rangeHeight)
        local gap = math.max(1, math.floor(verticalSpace / 3))
        local topY = innerMargin + gap
        if topY + singleHeight - 1 > innerMargin + stepHeight - 1 then
            topY = math.max(innerMargin, innerMargin + stepHeight - singleHeight - rangeHeight - gap)
        end
        if topY < innerMargin then
            topY = innerMargin
        end
        sliderSingle:setPosition(singleX, topY)
        local rangeY = topY + singleHeight + gap
        if rangeY + rangeHeight - 1 > innerMargin + stepHeight - 1 then
            rangeY = math.max(innerMargin, innerMargin + stepHeight - rangeHeight)
        end
        sliderRange:setPosition(rangeX, rangeY)
    end

    if #checkboxWidgets > 0 then
        local checkboxWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local baseY = innerMargin
        for index = 1, #checkboxWidgets do
            local checkbox = checkboxWidgets[index]
            if checkbox then
                local presetWidth = checkboxDefaults[index] or checkbox.width
                local width = math.max(6, math.min(presetWidth, checkboxWidthLimit))
                checkbox:setSize(width, 1)
                local x = math.floor((checkboxStep.width - width) / 2) + 1
                local y = math.min(innerMargin + stepHeight - 1, baseY + (index - 1) * 2)
                checkbox:setPosition(x, y)
            end
        end
        if checkboxStatus then
            local defaults = checkboxStatusDefaults or {}
            local statusWidth = math.max(6, math.min(defaults.width or checkboxStatus.width, checkboxWidthLimit))
            local maxStatusHeight = math.max(2, stepHeight - (baseY + (#checkboxWidgets - 1) * 2) - 1)
            local statusHeight = math.max(2, math.min(defaults.height or checkboxStatus.height, maxStatusHeight))
            checkboxStatus:setSize(statusWidth, statusHeight)
            local x = math.floor((checkboxStep.width - statusWidth) / 2) + 1
            local y = math.min(innerMargin + stepHeight - statusHeight, baseY + (#checkboxWidgets - 1) * 2 + 2)
            checkboxStatus:setPosition(x, y)
        end
    end

    if treeView then
        local treeWidthLimit = math.max(8, stepWidth - innerMargin * 2)
        local defaults = treeDefaults or {}
        local defaultWidth = defaults.width or treeView.width
        local defaultHeight = defaults.height or treeView.height
        local treeWidth = math.max(8, math.min(defaultWidth, treeWidthLimit))

        local infoHeight = 0
        local infoWidth = 0
        if treeInfoLabel then
            local infoDefaults = treeInfoDefaults or {}
            infoWidth = math.max(6, math.min(infoDefaults.width or treeInfoLabel.width, treeWidthLimit))
            local maxInfoHeight = math.max(2, stepHeight - 4)
            infoHeight = math.max(2, math.min(infoDefaults.height or treeInfoLabel.height, maxInfoHeight))
        end

        local availableHeight = math.max(1, stepHeight - infoHeight - 1)
        local treeHeight = math.min(defaultHeight, availableHeight)
        if availableHeight >= 3 then
            treeHeight = math.max(3, treeHeight)
        end
        treeHeight = math.max(1, math.min(treeHeight, availableHeight))

        treeView:setSize(treeWidth, treeHeight)
        local treeX = math.floor((treeStep.width - treeWidth) / 2) + 1
        local treeY = innerMargin
        treeView:setPosition(treeX, treeY)

        if treeInfoLabel then
            treeInfoLabel:setSize(infoWidth, infoHeight)
            local infoX = math.floor((treeStep.width - infoWidth) / 2) + 1
            local infoY = treeY + treeHeight + 1
            local maxInfoY = innerMargin + stepHeight - infoHeight
            if infoY > maxInfoY then
                infoY = maxInfoY
            end
            if infoY < innerMargin then
                infoY = innerMargin
            end
            treeInfoLabel:setPosition(infoX, infoY)
        end
    end

    if progressDeterminate and progressIndeterminate then
        local defaults = progressDefaults or {}
        local detDefaults = defaults.determinate or { width = progressDeterminate.width, height = progressDeterminate.height }
        local indDefaults = defaults.indeterminate or { width = progressIndeterminate.width, height = progressIndeterminate.height }
        local barWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local detWidth = math.max(6, math.min(detDefaults.width or barWidthLimit, barWidthLimit))
        local indWidth = math.max(6, math.min(indDefaults.width or barWidthLimit, barWidthLimit))
        local detHeight = math.max(1, math.min(detDefaults.height or stepHeight, stepHeight))
        local indHeight = math.max(1, math.min(indDefaults.height or stepHeight, stepHeight))
        local verticalSpace = math.max(0, stepHeight - detHeight - indHeight)
        local gap = math.max(1, math.floor(verticalSpace / 3))
        local topY = innerMargin + gap
        if topY + detHeight - 1 > innerMargin + stepHeight - 1 then
            topY = innerMargin
        end
        progressDeterminate:setSize(detWidth, detHeight)
        local detX = math.floor((progressStep.width - detWidth) / 2) + 1
        progressDeterminate:setPosition(detX, topY)

        local secondGap = math.max(1, math.floor(verticalSpace / 2))
        local secondY = topY + detHeight + secondGap
        local maxYOffset = innerMargin + stepHeight - indHeight
        if secondY > maxYOffset then
            secondY = maxYOffset
        end
        progressIndeterminate:setSize(indWidth, indHeight)
        local indX = math.floor((progressStep.width - indWidth) / 2) + 1
        progressIndeterminate:setPosition(indX, secondY)
    end

    local navY = wizardY + wizardHeight + navGap
    local maxNavY = math.max(1, rootHeight - actualNavHeight + 1)
    navY = clamp(navY, 1, maxNavY)

    local prevXMax = math.max(1, rootWidth - prevButton.width + 1)
    prevButton:setPosition(clamp(wizardX, 1, prevXMax), navY)

    local nextX = wizardX + wizardWidth - nextButton.width
    local nextXMax = math.max(1, rootWidth - nextButton.width + 1)
    nextButton:setPosition(clamp(nextX, 1, nextXMax), navY)
end

local originalRootHandleEvent = root.handleEvent
function root:handleEvent(event, ...)
    if event == "term_resize" then
        layout()
    end
    return originalRootHandleEvent(self, event, ...)
end

prevButton:setOnClick(function()
    if isAnimating then
        return
    end
    local target = currentStep - 1
    if target < 1 then
        target = #steps
    end
    showStep(target, -1)
end)

nextButton:setOnClick(function()
    if isAnimating then
        return
    end
    local target = currentStep + 1
    if target > #steps then
        target = 1
    end
    showStep(target, 1)
end)

layout()
showStep(1, 0)
app:run()
