---@diagnostic disable "undefined-field"
local colors = assert(rawget(_G, "colors"), "colors API unavailable")
local pixelui = require("pixelui")

---@type PixelUI.App
local app = pixelui.create({
    background = colors.gray,
    rootBorder = {
        color = colors.gray
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
local chartState = {
    widget = nil,
    defaults = {},
    infoLabel = nil,
    infoDefaults = {}
}
local toggleState = {
    widget = nil,
    defaults = {},
    statusLabel = nil,
    statusDefaults = {}
}
local windowDemo = {
    windows = {},
    defaults = {},
    counter = 0,
    frame = nil,
    infoLabel = nil,
    spawnButton = nil,
    statusLabel = nil
}
local tableState = {
    widget = nil,
    defaults = {},
    detailLabel = nil,
    detailDefaults = {},
    refreshButton = nil,
    refreshDefaults = {}
}
local editorState = {
    widget = nil,
    defaults = {},
    statusLabel = nil,
    statusDefaults = {},
    instructions = nil,
    instructionsDefaults = {}
}
local contextMenuState = {
    menu = nil,
    target = nil,
    targetDefaults = {},
    selectionLabel = nil,
    selectionDefaults = {}
}
local progressDeterminate
local progressIndeterminate
local progressDefaults = {}
local progressAnimationHandle
local progressStepIndex
local toastState = {
    buttons = {},
    buttonDefaults = {},
    defaults = {}
}
local threadDemo = {
    entries = {},
    defaults = {}
}

local constraintState = {
    defaults = {},
    presets = {},
    buttons = {},
    buttonDefaults = {},
    activePresetIndex = 1,
    currentSummary = ""
}

local freeDrawState = {
    defaults = {},
    patternIndex = 1
}

local randomSeeded = false
local function seedRandom()
    if randomSeeded then
        return
    end
    math.randomseed(os.clock() * 1000)
    for _ = 1, 3 do
        math.random()
    end
    randomSeeded = true
end

local tableRegions = { "NA", "EU", "APAC", "LATAM" }
local tableStatuses = { "Healthy", "Warning", "Critical", "Offline" }

local function generateTableData()
    seedRandom()
    local rows = {}
    for i = 1, 8 do
        rows[#rows + 1] = {
            name = string.format("Svc %02d", math.random(1, 99)),
            region = tableRegions[math.random(#tableRegions)],
            status = tableStatuses[math.random(#tableStatuses)],
            latency = math.random(24, 240)
        }
    end
    return rows
end

local function updateTableDetails(row)
    if not tableState.detailLabel then
        return
    end
    if not row then
        tableState.detailLabel:setText("Select a service to view metrics.")
        return
    end
    tableState.detailLabel:setText(string.format("%s (%s) is %s - %dms latency", row.name, row.region, row.status, row.latency))
end

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

-- Step 10: Chart showcase
local chartStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(chartStep)

chartState.widget = app:createChart({
    x = 2,
    y = 2,
    width = 26,
    height = 7,
    data = { 12, 18, 9, 21, 15 },
    labels = { "Mon", "Tue", "Wed", "Thu", "Fri" },
    chartType = "bar",
    bg = colors.gray,
    fg = colors.white,
    barColor = colors.lightBlue,
    highlightColor = colors.orange,
    axisColor = colors.white,
    placeholder = "No metrics recorded"
})
chartStep:addChild(chartState.widget)
chartState.defaults = { width = chartState.widget.width, height = chartState.widget.height }

chartState.infoLabel = app:createLabel({
    x = 2,
    y = 10,
    width = 26,
    height = 2,
    align = "center",
    wrap = true,
    text = "",
    bg = colors.gray,
    fg = colors.white
})
chartStep:addChild(chartState.infoLabel)
chartState.infoDefaults = { width = chartState.infoLabel.width, height = chartState.infoLabel.height }

local function updateChartInfo(index, value)
    if not chartState.infoLabel then
        return
    end
    if not index then
        chartState.infoLabel:setText("No selection yet.")
        return
    end
    local label = chartState.widget and chartState.widget:getLabel(index)
    if not label or label == "" then
        label = "Point " .. tostring(index)
    end
    local displayValue = value or 0
    chartState.infoLabel:setText(label .. ": " .. tostring(displayValue) .. " units")
end

chartState.widget:setOnSelect(function(_, index, value)
    updateChartInfo(index, value)
end)
updateChartInfo(chartState.widget:getSelectedIndex(), chartState.widget:getSelectedValue())

addStep(chartStep, function()
    if chartState.widget then
        app:setFocus(chartState.widget)
    end
end, function()
    if chartState.widget and chartState.widget:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 11: Toggle showcase
local toggleStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(toggleStep)

toggleState.widget = app:createToggle({
    x = 2,
    y = 4,
    width = 16,
    height = 3,
    labelOn = "Enabled",
    labelOff = "Disabled",
    showLabel = false,
    trackColorOn = colors.green,
    trackColorOff = colors.red,
    trackColorDisabled = colors.lightGray,
    thumbColor = colors.white,
    knobColorDisabled = colors.lightGray,
    knobMargin = 1,
    knobWidth = 6,
    transitionDuration = 0.25,
    transitionEasing = "easeInOutQuad",
    focusOutline = colors.white,
    border = { color = colors.white },
    bg = colors.gray,
    fg = colors.white
})
toggleStep:addChild(toggleState.widget)
toggleState.defaults = { width = toggleState.widget.width, height = toggleState.widget.height }

local toggleKnobLabel = app:createLabel({
    x = toggleState.widget.x + toggleState.widget.width + 2,
    y = toggleState.widget.y,
    width = 12,
    height = 1,
    text = "Smooth",
    fg = colors.white,
    bg = colors.gray
})
toggleStep:addChild(toggleKnobLabel)
toggleState.knobLabel = toggleKnobLabel
toggleState.defaults.knobLabel = { width = toggleKnobLabel.width, height = toggleKnobLabel.height }

local toggleSecondary = app:createToggle({
    x = toggleState.widget.x,
    y = toggleState.widget.y + 4,
    width = 16,
    height = 3,
    labelOn = "ON",
    labelOff = "OFF",
    showLabel = true,
    trackColorOn = colors.green,
    trackColorOff = colors.red,
    trackColorDisabled = colors.lightGray,
    thumbColor = colors.white,
    knobMargin = 2,
    transitionDuration = 0.1,
    transitionEasing = "easeOutCubic",
    bg = colors.gray,
    fg = colors.white
})
toggleSecondary:setValue(false, true)
toggleSecondary:setDisabled(true)
toggleStep:addChild(toggleSecondary)
toggleState.secondary = toggleSecondary
toggleState.defaults.secondary = { width = toggleSecondary.width, height = toggleSecondary.height }

toggleState.statusLabel = app:createLabel({
    x = 2,
    y = 8,
    width = 26,
    height = 2,
    align = "center",
    wrap = true,
    text = "",
    bg = colors.gray,
    fg = colors.white
})
toggleStep:addChild(toggleState.statusLabel)
toggleState.statusDefaults = { width = toggleState.statusLabel.width, height = toggleState.statusLabel.height }

local function updateToggleStatus(isOn)
    if not toggleState.statusLabel then
        return
    end
    if isOn then
        toggleState.statusLabel:setText("Notifications are enabled.")
    else
        toggleState.statusLabel:setText("Notifications are muted.")
    end
end

toggleState.widget:setOnChange(function(_, value)
    updateToggleStatus(value)
end)
updateToggleStatus(toggleState.widget:isOn())

addStep(toggleStep, function()
    if toggleState.widget then
        app:setFocus(toggleState.widget)
    end
end, function()
    if toggleState.widget and toggleState.widget:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 12: Window showcase
local windowStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(windowStep)
windowDemo.frame = windowStep

windowDemo.infoLabel = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    text = "Spawn draggable windows with title bars. They float above the wizard.",
    bg = colors.gray,
    fg = colors.white
})
windowStep:addChild(windowDemo.infoLabel)
windowDemo.defaults.info = { width = windowDemo.infoLabel.width, height = windowDemo.infoLabel.height }

windowDemo.spawnButton = app:createButton({
    x = 2,
    y = 6,
    width = 16,
    height = 3,
    label = "Spawn Window",
    bg = colors.orange,
    fg = colors.black,
    border = { color = colors.white }
})
windowStep:addChild(windowDemo.spawnButton)
windowDemo.defaults.button = { width = windowDemo.spawnButton.width, height = windowDemo.spawnButton.height }

windowDemo.statusLabel = app:createLabel({
    x = 2,
    y = 9,
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "No windows yet. Press Spawn Window to create one.",
    bg = colors.gray,
    fg = colors.white
})
windowStep:addChild(windowDemo.statusLabel)
windowDemo.defaults.status = { width = windowDemo.statusLabel.width, height = windowDemo.statusLabel.height }

local function updateWindowStatus()
    if not windowDemo.statusLabel then
        return
    end
    local count = #windowDemo.windows
    if count == 0 then
        windowDemo.statusLabel:setText("No windows yet. Press Spawn Window to create one.")
    else
        local suffix = (count == 1) and "" or "s"
        windowDemo.statusLabel:setText(string.format("%d window%s active. Drag the title bar to move.", count, suffix))
    end
end

local function spawnDemoWindow()
    seedRandom()
    local maxWindows = 6
    if #windowDemo.windows >= maxWindows then
        local oldest = table.remove(windowDemo.windows, 1)
        if oldest and oldest.parent then
            oldest.parent:removeChild(oldest)
        end
    end

    windowDemo.counter = windowDemo.counter + 1

    local winWidth = 20
    local winHeight = 8
    local rootWidth = root.width
    local rootHeight = root.height
    local maxX = math.max(1, rootWidth - winWidth + 1)
    local maxY = math.max(1, rootHeight - winHeight + 1)
    local posX = math.max(1, math.min(maxX, math.random(1, maxX)))
    local posY = math.max(1, math.min(maxY, math.random(1, maxY)))

    local titleAlign = (windowDemo.counter % 3 == 0) and "right" or ((windowDemo.counter % 2 == 0) and "center" or "left")
    local win = app:createWindow({
        x = posX,
        y = posY,
        width = winWidth,
        height = winHeight,
        title = string.format("Window %02d", windowDemo.counter),
        bg = colors.black,
        fg = colors.white,
        border = { color = colors.white },
        titleBar = {
            bg = colors.lightGray,
            fg = colors.black,
            align = titleAlign
        }
    })

    root:addChild(win)

    local offsetX, offsetY = win:getContentOffset()
    local contentWidth = math.max(1, win.width - offsetX - 1)
    local contentHeight = math.max(1, win.height - offsetY - 1)
    local contentText = string.format("This is window %02d. Drag me around!", windowDemo.counter)

    local contentLabel = app:createLabel({
        x = offsetX + 1,
        y = offsetY + 1,
        width = contentWidth,
        height = contentHeight,
        wrap = true,
        align = "left",
        text = contentText,
        bg = colors.black,
        fg = colors.white
    })
    win:addChild(contentLabel)

    windowDemo.windows[#windowDemo.windows + 1] = win
    updateWindowStatus()
    app:render()
end

windowDemo.spawnButton:setOnClick(function()
    spawnDemoWindow()
end)

addStep(windowStep, function()
    updateWindowStatus()
    if windowDemo.spawnButton then
        app:setFocus(windowDemo.spawnButton)
    end
end, function()
    if windowDemo.spawnButton and windowDemo.spawnButton:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 13: Table showcase
local tableStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(tableStep)

tableState.widget = app:createTable({
    x = 2,
    y = 2,
    width = 26,
    height = 6,
    columns = {
        { id = "name", title = "Service", key = "name", width = 8 },
        { id = "region", title = "Region", key = "region", width = 5 },
        { id = "status", title = "Status", key = "status", width = 8 },
        {
            id = "latency",
            title = "Latency",
            key = "latency",
            width = 5,
            align = "right",
            format = function(value)
                if value == nil then
                    return "-"
                end
                return tostring(value) .. "ms"
            end
        }
    },
    data = generateTableData(),
    headerBg = colors.lightGray,
    headerFg = colors.black,
    highlightBg = colors.orange,
    highlightFg = colors.black,
    zebra = true,
    zebraBg = colors.lightGray,
    rowBg = colors.gray,
    rowFg = colors.white,
    placeholder = "No services tracked"
})
tableStep:addChild(tableState.widget)
tableState.defaults = { width = tableState.widget.width, height = tableState.widget.height }

tableState.detailLabel = app:createLabel({
    x = 2,
    y = 9,
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "Select a service to view metrics.",
    bg = colors.gray,
    fg = colors.white
})
tableStep:addChild(tableState.detailLabel)
tableState.detailDefaults = { width = tableState.detailLabel.width, height = tableState.detailLabel.height }

tableState.refreshButton = app:createButton({
    x = 2,
    y = 11,
    width = 14,
    height = 3,
    label = "Refresh Data",
    bg = colors.lightGray,
    fg = colors.black,
    border = { color = colors.white }
})
tableStep:addChild(tableState.refreshButton)
tableState.refreshDefaults = { width = tableState.refreshButton.width, height = tableState.refreshButton.height }

tableState.widget:setOnSelect(function(_, row)
    updateTableDetails(row)
end)
tableState.widget:setOnSort(function()
    updateTableDetails(tableState.widget:getSelectedRow())
end)
updateTableDetails(tableState.widget:getSelectedRow())

tableState.refreshButton:setOnClick(function()
    local dataset = generateTableData()
    tableState.widget:setData(dataset)
    if #dataset > 0 then
        tableState.widget:setSelectedIndex(1, true)
        updateTableDetails(tableState.widget:getSelectedRow())
    else
        updateTableDetails(nil)
    end
end)

addStep(tableStep, function()
    if tableState.widget then
        app:setFocus(tableState.widget)
        updateTableDetails(tableState.widget:getSelectedRow())
    end
end, function()
    if tableState.widget and tableState.widget:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 14: Text Editor showcase
local editorStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(editorStep)

local editorSample = [[local services = {
    "Auth",
    "Billing",
    "Notifications"
}

local function logStatus(name)
    print("Watching " .. name)
end

for index = 1, #services do
    logStatus(services[index])
end]]

editorState.widget = app:createTextBox({
    x = 2,
    y = 2,
    width = 26,
    height = 6,
    multiline = true,
    syntax = "lua",
    autocomplete = {
        "pixelui.create",
        "app:createTable",
        "app:createTextBox",
        "generateTableData()",
        "updateTableDetails(row)",
        "logStatus(name)",
        "local",
        "function",
        "for",
        "if",
        "then",
        "end",
        "return",
        "true",
        "false",
        "nil"
    },
    autocompleteMaxItems = 6,
    autocompleteHighlightBg = colors.orange,
    autocompleteHighlightFg = colors.black,
    autocompleteBorder = { color = colors.white },
    autocompleteMaxWidth = 28,
    autocompleteAuto = true,
    placeholder = "Type Lua code here...",
    text = editorSample,
    bg = colors.black,
    fg = colors.white,
    border = { color = colors.white },
    selectionBg = colors.lightBlue,
    selectionFg = colors.black
})
editorStep:addChild(editorState.widget)
editorState.defaults = { width = editorState.widget.width, height = editorState.widget.height }

editorState.statusLabel = app:createLabel({
    x = 2,
    y = 9,
    width = 26,
    height = 1,
    text = "",
    align = "left",
    bg = colors.gray,
    fg = colors.white
})
editorStep:addChild(editorState.statusLabel)
editorState.statusDefaults = { width = editorState.statusLabel.width, height = editorState.statusLabel.height }

editorState.instructions = app:createLabel({
    x = 2,
    y = 10,
    width = 26,
    height = 4,
    wrap = true,
    align = "left",
    text = "Ctrl+F find, Ctrl+H repl.\nCtrl+Space popup; arrows/\nTab/Enter choose.\nShift+Arrows select.",
    bg = colors.gray,
    fg = colors.white
})
editorStep:addChild(editorState.instructions)
editorState.instructionsDefaults = { width = editorState.instructions.width, height = editorState.instructions.height }

local function updateEditorStatus()
    if not editorState.widget or not editorState.statusLabel then
        return
    end
    local line, col = editorState.widget:getCursorPosition()
    local totalLines = editorState.widget:getLineCount()
    local selectionLength = editorState.widget:getSelectionLength()
    local status = string.format("Line %d of %d, Col %d", line, totalLines, col)
    if selectionLength > 0 then
        status = status .. string.format("  Sel %d", selectionLength)
    end
    editorState.statusLabel:setText(status)
end

editorState.widget:setOnCursorMove(function()
    updateEditorStatus()
end)
editorState.widget:setOnChange(function()
    updateEditorStatus()
end)

addStep(editorStep, function()
    if editorState.widget then
        app:setFocus(editorState.widget)
        updateEditorStatus()
    end
end, function()
    if editorState.widget and editorState.widget:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 15: Context menu showcase
local contextStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(contextStep)

contextMenuState.menu = app:createContextMenu({
    menuBg = colors.black,
    menuFg = colors.white,
    highlightBg = colors.orange,
    highlightFg = colors.black,
    shortcutFg = colors.lightGray,
    disabledFg = colors.gray,
    border = { color = colors.white },
    maxWidth = 28
})
contextMenuState.menu:setZ(900)
root:addChild(contextMenuState.menu)

contextMenuState.menu:setItems({
    { label = "Open File", shortcut = "Enter", value = "open" },
    { label = "Reveal in Explorer", shortcut = "Ctrl+Shift+E", value = "reveal" },
    "-",
    {
        label = "Syntax",
        submenu = {
            { label = "Lua", value = "syntax:lua" },
            { label = "JSON", value = "syntax:json" },
            { label = "Plain Text", value = "syntax:text" }
        }
    },
    {
        label = "Run Task",
        submenu = {
            { label = "Build", shortcut = "Ctrl+B", value = "task:build" },
            { label = "Test", shortcut = "Ctrl+T", value = "task:test" }
        }
    },
    "-",
    { label = "Delete", shortcut = "Del", value = "delete", disabled = true }
})

local contextHint = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    text = "Right-click the tile to open the menu.",
    bg = colors.gray,
    fg = colors.white
})
contextStep:addChild(contextHint)

contextMenuState.target = app:createButton({
    width = 18,
    height = 1,
    label = "main.lua",
    bg = colors.black,
    fg = colors.white
})
centerWidget(contextMenuState.target, contextStep, contextMenuState.target.width, contextMenuState.target.height)
contextStep:addChild(contextMenuState.target)
contextMenuState.targetDefaults = { width = contextMenuState.target.width, height = contextMenuState.target.height }

contextMenuState.selectionLabel = app:createLabel({
    x = 2,
    y = 9,
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "Last action: (none)",
    bg = colors.gray,
    fg = colors.white
})
contextStep:addChild(contextMenuState.selectionLabel)
contextMenuState.selectionDefaults = { width = contextMenuState.selectionLabel.width, height = contextMenuState.selectionLabel.height }

contextMenuState.target:setOnClick(function(_, button, x, y)
    if button == 2 then
        contextMenuState.menu:open(x, y)
        return
    end
    contextMenuState.menu:close()
    contextMenuState.selectionLabel:setText("Last action: left click")
end)

contextMenuState.menu:setOnSelect(function(_, item)
    if not item then
        contextMenuState.selectionLabel:setText("Last action: (cancelled)")
        return
    end
    local summary
    if item.value == "open" then
        summary = "Opened file"
    elseif item.value == "reveal" then
        summary = "Reveal in explorer"
    elseif type(item.value) == "string" and item.value:match("^syntax:") then
        summary = "Syntax set to " .. (item.label or "(unnamed)")
    elseif type(item.value) == "string" and item.value:match("^task:") then
        summary = "Run task " .. (item.label or "(unnamed)")
    elseif item.value == "delete" then
        summary = "Delete (disabled)"
    else
        summary = item.label or "(unnamed)"
    end
    contextMenuState.selectionLabel:setText("Last action: " .. summary)
end)

addStep(contextStep, function()
    contextMenuState.selectionLabel:setText("Last action: (none)")
    contextMenuState.menu:close()
end, function()
    contextMenuState.menu:close()
end)

-- Step 16: ProgressBar showcase
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

-- Step 17: Thread showcase
local threadStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(threadStep)

threadDemo.instructions = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "Spawn tasks to watch PixelUI threads work in the background while the UI stays responsive.",
    bg = colors.gray,
    fg = colors.white
})
threadStep:addChild(threadDemo.instructions)
threadDemo.defaults.instructions = { width = threadDemo.instructions.width, height = threadDemo.instructions.height }

threadDemo.list = app:createList({
    x = 2,
    y = 5,
    width = 26,
    height = 4,
    items = {},
    bg = colors.gray,
    fg = colors.white,
    highlightBg = colors.lightGray,
    highlightFg = colors.black,
    border = { color = colors.lightGray }
})
threadDemo.list:setPlaceholder("Tasks appear here once you spawn one.")
threadStep:addChild(threadDemo.list)
threadDemo.defaults.list = { width = threadDemo.list.width, height = threadDemo.list.height }

threadDemo.detailLabel = app:createLabel({
    x = 2,
    y = 7,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    text = "Press Spawn Task to run simulated work on a background thread.",
    bg = colors.gray,
    fg = colors.white
})
threadStep:addChild(threadDemo.detailLabel)
threadDemo.defaults.detail = { width = threadDemo.detailLabel.width, height = threadDemo.detailLabel.height }

threadDemo.startButton = app:createButton({
    x = 2,
    y = 12,
    width = 12,
    height = 2,
    label = "Spawn Task",
    bg = colors.orange,
    fg = colors.black
})
threadStep:addChild(threadDemo.startButton)
threadDemo.defaults.startButton = { width = threadDemo.startButton.width, height = threadDemo.startButton.height }

threadDemo.cancelButton = app:createButton({
    x = 18,
    y = 12,
    width = 12,
    height = 2,
    label = "Cancel Tasks",
    bg = colors.lightGray,
    fg = colors.black
})
threadStep:addChild(threadDemo.cancelButton)
threadDemo.defaults.cancelButton = { width = threadDemo.cancelButton.width, height = threadDemo.cancelButton.height }

local function updateThreadEntry(entry)
    local parts = {}
    local statusText = entry.statusText or entry.status or entry.handle:getStatus()
    if statusText and statusText ~= "" then
        parts[#parts + 1] = statusText
    end
    if entry.progress ~= nil then
        local percent = math.floor(entry.progress * 100 + 0.5)
        parts[#parts + 1] = string.format("%d%%", percent)
    end
    if entry.detailText and entry.detailText ~= "" then
        parts[#parts + 1] = entry.detailText
    end
    if #parts == 0 then
        parts[1] = entry.handle:getStatus()
    end
    entry.display = string.format("%s - %s", entry.name, table.concat(parts, " | "))
end

local function refreshThreadList()
    if not threadDemo.list then
        return
    end
    local items = {}
    for i = 1, #threadDemo.entries do
        local entry = threadDemo.entries[i]
        items[i] = entry.display or entry.name
    end
    threadDemo.list:setItems(items)
end

local function updateThreadDetail()
    if not threadDemo.detailLabel or not threadDemo.list then
        return
    end
    local selectedIndex = threadDemo.list:getSelectedIndex()
    local entry = threadDemo.entries[selectedIndex]
    if entry then
        local statusText = entry.statusText or entry.status or entry.handle:getStatus()
        local lines = {}
        if statusText and statusText ~= "" then
            local text = statusText
            if entry.progress ~= nil then
                text = string.format("%s (%d%%)", statusText, math.floor(entry.progress * 100 + 0.5))
            end
            lines[#lines + 1] = text
        end
        if entry.detailText and entry.detailText ~= "" then
            lines[#lines + 1] = entry.detailText
        end
        if entry.handle:isFinished() then
            local result = entry.handle:getResult()
            if result ~= nil then
                lines[#lines + 1] = tostring(result)
            end
        end
        if #lines == 0 then
            lines[1] = entry.name
        end
        threadDemo.detailLabel:setText(table.concat(lines, "\n"))
    else
        local total = #threadDemo.entries
        if total == 0 then
            threadDemo.detailLabel:setText("Press Spawn Task to run simulated work on a background thread.")
        else
            local running = 0
            local completed = 0
            for i = 1, total do
                local current = threadDemo.entries[i]
                local status = current.status or current.handle:getStatus()
                if status == pixelui.threadStatus.running then
                    running = running + 1
                elseif status == pixelui.threadStatus.completed then
                    completed = completed + 1
                end
            end
            threadDemo.detailLabel:setText(string.format("%d task(s): %d running, %d completed.", total, running, completed))
        end
    end
end

local function attachThreadListeners(entry)
    local handle = entry.handle
    handle:onStatusChange(function(_, status)
        entry.status = status
        if status == pixelui.threadStatus.completed then
            entry.statusText = "Completed"
            entry.detailText = entry.detailText ~= "" and entry.detailText or "Thread finished successfully."
            entry.progress = 1
        elseif status == pixelui.threadStatus.cancelled then
            entry.statusText = "Cancelled"
            entry.detailText = entry.detailText ~= "" and entry.detailText or "Cancelled by user."
        elseif status == pixelui.threadStatus.error then
            entry.statusText = "Error"
            entry.detailText = tostring(handle:getError() or "Unknown error")
        elseif status == pixelui.threadStatus.running then
            if not entry.statusText or entry.statusText == "Queued" then
                entry.statusText = "Running"
            end
        end
        updateThreadEntry(entry)
        refreshThreadList()
        updateThreadDetail()
    end)

    handle:onMetadataChange(function(_, key, value)
        local changed = false
        if key == "status" and value ~= nil then
            entry.statusText = tostring(value)
            changed = true
        elseif key == "detail" then
            entry.detailText = value and tostring(value) or ""
            changed = true
        elseif key == "progress" then
            if type(value) == "number" then
                if value < 0 then
                    value = 0
                elseif value > 1 then
                    value = 1
                end
                entry.progress = value
            else
                entry.progress = nil
            end
            changed = true
        end
        if changed then
            updateThreadEntry(entry)
            refreshThreadList()
            updateThreadDetail()
        end
    end)
end

local function spawnDemoThread()
    local index = #threadDemo.entries + 1
    local name = string.format("Task %02d", index)
    local handle = app:spawnThread(function(ctx)
        ctx:setStatus("Queued")
        ctx:setDetail("Waiting for scheduler")
        ctx:setProgress(0)
        ctx:yield()
        ctx:setStatus("Initializing")
        ctx:setDetail("Setting up workload")
        ctx:sleep(0.3)
        for segment = 1, 5 do
            ctx:checkCancelled()
            ctx:setStatus(string.format("Processing %d/5", segment))
            ctx:setDetail(string.format("Crunching chunk %d", segment))
            ctx:setProgress((segment - 1) / 5)
            ctx:sleep(0.4)
        end
        ctx:setDetail("Finalizing results")
        ctx:setProgress(1)
        ctx:setStatus("Complete")
        ctx:sleep(0.1)
        return name .. " finished"
    end, {
        name = name
    })
    local entry = {
        handle = handle,
        name = name,
        status = handle:getStatus(),
        statusText = "Queued",
        detailText = "Waiting to run",
        progress = 0
    }
    threadDemo.entries[#threadDemo.entries + 1] = entry
    updateThreadEntry(entry)
    refreshThreadList()
    threadDemo.list:setSelectedIndex(#threadDemo.entries, true)
    updateThreadDetail()
    attachThreadListeners(entry)
end

threadDemo.list:setOnSelect(function()
    updateThreadDetail()
end)

threadDemo.startButton:setOnClick(function()
    spawnDemoThread()
end)

threadDemo.cancelButton:setOnClick(function()
    local cancelled = 0
    for i = 1, #threadDemo.entries do
        local entry = threadDemo.entries[i]
        if entry.handle:isRunning() and entry.handle:cancel() then
            cancelled = cancelled + 1
        end
    end
    if cancelled == 0 then
        threadDemo.detailLabel:setText("No running tasks to cancel.")
    else
        threadDemo.detailLabel:setText(string.format("Cancelling %d task(s)...", cancelled))
    end
end)

addStep(threadStep, function()
    if threadDemo.list and #threadDemo.entries > 0 then
        app:setFocus(threadDemo.list)
    elseif threadDemo.startButton then
        app:setFocus(threadDemo.startButton)
    else
        app:setFocus(nil)
    end
    updateThreadDetail()
end, function()
    if threadDemo.list and threadDemo.list:isFocused() then
        app:setFocus(nil)
    elseif threadDemo.startButton and threadDemo.startButton:isFocused() then
        app:setFocus(nil)
    end
end)

-- Step 18: NotificationToast showcase
local toastStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(toastStep)

toastState.frame = toastStep
toastState.defaults.instructions = toastState.defaults.instructions or {}
toastState.defaults.toast = toastState.defaults.toast or {}
toastState.buttons = {}
toastState.buttonDefaults = {}

toastState.instructions = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    text = "Preview toast notifications. Choose a severity below to see built-in styles, or click the toast to dismiss it.",
    bg = colors.gray,
    fg = colors.white
})
toastStep:addChild(toastState.instructions)
toastState.defaults.instructions.width = toastState.instructions.width
toastState.defaults.instructions.height = toastState.instructions.height

toastState.toast = app:createNotificationToast({
    width = 26,
    height = 5,
    visible = false,
    padding = { left = 2, right = 2, top = 1, bottom = 1 },
    border = { color = colors.white },
    duration = 4,
    dismissOnClick = true,
    anchor = "top_right",
    anchorMargin = { top = 1, right = 1 },
    anchorAnimationDuration = 0.25
})
toastState.toast:setTitle("Toast Preview")
toastState.toast:setMessage("Select a button below to try different toast severities.")
toastStep:addChild(toastState.toast)
toastState.defaults.toast.width = toastState.toast.width
toastState.defaults.toast.height = toastState.toast.height

local toastButtonsData = {
    {
        label = "Info",
        severity = "info",
        title = "Heads Up",
        message = "You have new documentation tips to review.",
        autoHide = true,
        duration = 4
    },
    {
        label = "Success",
        severity = "success",
        title = "Deployment Complete",
        message = "The latest pipeline finished without errors.",
        autoHide = true,
        duration = 5
    },
    {
        label = "Warning",
        severity = "warning",
        title = "Low Storage",
        message = "Only 12% capacity remains on /data. Plan cleanup soon.",
        autoHide = true,
        duration = 5
    },
    {
        label = "Error",
        severity = "error",
        title = "Action Needed",
        message = "A service failed to respond. Retry the request when ready.",
        autoHide = false,
        duration = 0
    }
}

for index = 1, #toastButtonsData do
    local config = toastButtonsData[index]
    local button = app:createButton({
        width = 10,
        height = 2,
        label = config.label,
        bg = colors.lightGray,
        fg = colors.black
    })
    toastStep:addChild(button)
    toastState.buttons[index] = button
    toastState.buttonDefaults[index] = { width = button.width, height = button.height }
    button:setOnClick(function()
        local toast = toastState.toast
        if not toast then
            return
        end
        toast:present({
            severity = config.severity,
            title = config.title,
            message = config.message,
            duration = config.duration,
            autoHide = config.autoHide
        })
    end)
end

local function resetToastPreview()
    local toast = toastState.toast
    if not toast then
        return
    end
    toast:present({
        severity = "info",
        title = "Toast Preview",
        message = "Select a button below to try different toast severities.",
        autoHide = false,
        duration = 0
    })
end

addStep(toastStep, function()
    resetToastPreview()
    if toastState.buttons[1] then
        app:setFocus(toastState.buttons[1])
    else
        app:setFocus(nil)
    end
end, function()
    if toastState.toast then
        toastState.toast:hide(false)
        toastState.toast:setAutoHide(true)
    end
    app:setFocus(nil)
end)

-- Step 19: Constraints showcase
local constraintStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(constraintStep)

constraintState.frame = constraintStep

constraintState.instructions = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "Apply presets to see widthPercent, parent matching, and centered offsets in action.",
    bg = colors.gray,
    fg = colors.white
})
constraintStep:addChild(constraintState.instructions)
constraintState.defaults.instructions = {
    width = constraintState.instructions.width,
    height = constraintState.instructions.height
}

constraintState.surface = app:createFrame({
    width = 26,
    height = 5,
    bg = colors.gray,
    fg = colors.white
})
constraintStep:addChild(constraintState.surface)
constraintState.defaults.surface = {
    width = constraintState.surface.width,
    height = constraintState.surface.height
}

constraintState.box = app:createFrame({
    width = 16,
    height = 5,
    bg = colors.lightGray,
    fg = colors.black,
    border = { color = colors.white },
    constraints = {
        widthPercent = 0.6,
        heightPercent = 0.5,
        centerX = true,
        centerY = { offset = 2 },
        minWidth = 8,
        minHeight = 3
    }
})
constraintState.surface:addChild(constraintState.box)
constraintState.defaults.box = {
    width = constraintState.box.width,
    height = constraintState.box.height
}

constraintState.infoLabel = app:createLabel({
    width = 26,
    height = 2,
    wrap = true,
    align = "left",
    text = "",
    bg = colors.gray,
    fg = colors.white
})
constraintStep:addChild(constraintState.infoLabel)
constraintState.defaults.info = {
    width = constraintState.infoLabel.width,
    height = constraintState.infoLabel.height
}

local constraintPresets = {
    {
        label = "60% Width",
        description = "widthPercent = 60%, heightPercent = 40%, centered with offset",
        constraints = {
            widthPercent = 0.6,
            heightPercent = 0.4,
            centerX = true,
            centerY = { offset = 2 },
            minWidth = 8,
            minHeight = 3
        }
    },
    {
        label = "Match Parent",
        description = "width = parent.width, heightPercent = 60%, centered with offset",
        constraints = {
            width = "parent.width",
            heightPercent = 0.6,
            centerX = true,
            centerY = { offset = 2 }
        }
    },
    {
        label = "Offset Center",
        description = "width = 45% -1, centerX offset -2, centerY offset +2",
        constraints = {
            width = { percent = 0.45, of = "parent.width", offset = -1 },
            height = { percent = 0.45, of = "parent.height" },
            centerX = { offset = -2 },
            centerY = { reference = "parent.centerY", offset = 2 }
        }
    }
}

constraintState.presets = constraintPresets

local function formatConstraintSummary(preset)
    local box = constraintState.box
    if not box then
        return preset.description or preset.label
    end
    local summary = preset.description or preset.label
    return string.format("%s\nActual size: %dx%d", summary, box.width, box.height)
end

local function applyConstraintPreset(index)
    local preset = constraintState.presets[index]
    if not preset then
        return
    end
    constraintState.activePresetIndex = index
    local box = constraintState.box
    if box then
        box:setConstraints(preset.constraints)
    end
    if layout then
        layout()
    end
    if constraintState.infoLabel then
        constraintState.infoLabel:setText(formatConstraintSummary(preset))
    end
    constraintState.currentSummary = preset.description or preset.label
end

constraintState.buttons = {}
constraintState.buttonDefaults = {}

for index = 1, #constraintState.presets do
    local preset = constraintState.presets[index]
    local button = app:createButton({
        width = 11,
        height = 2,
        label = preset.label,
        bg = colors.lightGray,
        fg = colors.black
    })
    constraintStep:addChild(button)
    constraintState.buttons[index] = button
    constraintState.buttonDefaults[index] = { width = button.width, height = button.height }
    button:setOnClick(function()
        applyConstraintPreset(index)
    end)
end

applyConstraintPreset(1)

addStep(constraintStep, function()
    applyConstraintPreset(constraintState.activePresetIndex or 1)
    local firstButton = constraintState.buttons and constraintState.buttons[1]
    if firstButton then
        app:setFocus(firstButton)
    else
        app:setFocus(nil)
    end
end, function()
    app:setFocus(nil)
end)

-- Step 20: FreeDraw showcase
local freeDrawStep = app:createFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 11,
    bg = colors.gray,
    fg = colors.white
})
wizard:addChild(freeDrawStep)

freeDrawState.frame = freeDrawStep

freeDrawState.instructions = app:createLabel({
    x = 2,
    y = 2,
    width = 26,
    height = 3,
    wrap = true,
    align = "left",
    text = "FreeDraw lets you render directly into the text and pixel layers. Cycle patterns to see custom drawing with ctx.fill, ctx.write, and ctx.pixel.",
    bg = colors.gray,
    fg = colors.white
})
freeDrawStep:addChild(freeDrawState.instructions)
freeDrawState.defaults.instructions = {
    width = freeDrawState.instructions.width,
    height = freeDrawState.instructions.height
}

freeDrawState.widget = app:createFreeDraw({
    width = 22,
    height = 8,
    bg = colors.black,
    fg = colors.white,
    border = { color = colors.white }
})
freeDrawStep:addChild(freeDrawState.widget)
freeDrawState.defaults.canvas = {
    width = freeDrawState.widget.width,
    height = freeDrawState.widget.height
}

freeDrawState.patternLabel = app:createLabel({
    width = 26,
    height = 1,
    align = "center",
    text = "",
    bg = colors.gray,
    fg = colors.white
})
freeDrawStep:addChild(freeDrawState.patternLabel)
freeDrawState.defaults.pattern = {
    width = freeDrawState.patternLabel.width,
    height = freeDrawState.patternLabel.height
}

freeDrawState.nextButton = app:createButton({
    width = 14,
    height = 3,
    label = "Next Pattern",
    bg = colors.lightGray,
    fg = colors.black
})
freeDrawStep:addChild(freeDrawState.nextButton)
freeDrawState.defaults.button = {
    width = freeDrawState.nextButton.width,
    height = freeDrawState.nextButton.height
}

local freeDrawPatterns = {
    {
        name = "Grid",
        draw = function(ctx)
            ctx.fill(colors.black)
            for y = 1, ctx.height, 2 do
                for x = 1, ctx.width do
                    ctx.pixel(x, y, colors.gray)
                end
            end
            for x = 1, ctx.width, 2 do
                for y = 1, ctx.height do
                    ctx.pixel(x, y, colors.lightGray)
                end
            end
            if ctx.width >= 6 and ctx.height >= 3 then
                ctx.write(2, 2, "GRID", colors.white, colors.black)
            end
        end
    },
    {
        name = "Wave",
        draw = function(ctx)
            ctx.fill(colors.black)
            local centerY = math.floor(ctx.height / 2)
            local amplitude = math.max(1, math.floor(ctx.height / 3))
            for x = 1, ctx.width do
                local angle = (x / ctx.width) * math.pi * 2
                local y = centerY + math.floor(math.sin(angle) * amplitude)
                y = clamp(y, 1, ctx.height)
                ctx.pixel(x, y, colors.cyan)
            end
            if ctx.height >= 2 then
                ctx.write(2, ctx.height - 1, "wave", colors.lightBlue, colors.black)
            end
        end
    },
    {
        name = "Spark",
        draw = function(ctx)
            ctx.fill(colors.black)
            seedRandom()
            local total = math.min(40, ctx.width * ctx.height)
            for i = 1, total do
                local px = math.random(1, ctx.width)
                local py = math.random(1, ctx.height)
                local color = (i % 3 == 0) and colors.orange or ((i % 2 == 0) and colors.yellow or colors.white)
                ctx.pixel(px, py, color)
            end
            ctx.write(2, 2, "spark", colors.orange, colors.black)
        end
    }
}

local function applyFreeDrawPattern(index)
    if #freeDrawPatterns == 0 then
        return
    end
    local normalized = ((index - 1) % #freeDrawPatterns) + 1
    freeDrawState.patternIndex = normalized
    local entry = freeDrawPatterns[normalized]
    if freeDrawState.widget then
        freeDrawState.widget:setOnDraw(function(_, ctx)
            entry.draw(ctx)
        end)
    end
    if freeDrawState.patternLabel then
        freeDrawState.patternLabel:setText("Pattern: " .. entry.name)
    end
    if app.running then
        app:render()
    end
end

freeDrawState.nextButton:setOnClick(function()
    applyFreeDrawPattern(freeDrawState.patternIndex + 1)
end)

applyFreeDrawPattern(freeDrawState.patternIndex)

addStep(freeDrawStep, function()
    applyFreeDrawPattern(freeDrawState.patternIndex)
    app:setFocus(nil)
end, function()
    app:setFocus(nil)
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
    label = "\17 Prev",
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
    label = "Next \16",
    bg = colors.lightGray,
    fg = colors.black,
    border = { color = colors.white }
})
root:addChild(nextButton)

local layoutState = {
    app = app,
    root = root,
    wizard = wizard,
    steps = steps,
    navHeight = navHeight,
    navGap = navGap,
    innerMargin = innerMargin,
    prevButton = prevButton,
    nextButton = nextButton,
    defaultButtonSize = defaultButtonSize,
    buttonStep = buttonStep,
    stepButton = stepButton,
    defaultTextBoxSize = defaultTextBoxSize,
    textStep = textStep,
    stepBox = stepBox,
    defaultComboSize = defaultComboSize,
    comboStep = comboStep,
    stepCombo = stepCombo,
    listWidget = listWidget,
    listDefaults = listDefaults,
    listStep = listStep,
    labelTitle = labelTitle,
    labelBody = labelBody,
    labelDefaults = labelDefaults,
    labelStep = labelStep,
    radioButtons = radioButtons,
    radioDefaultWidths = radioDefaultWidths,
    radioStep = radioStep,
    sliderSingle = sliderSingle,
    sliderRange = sliderRange,
    sliderDefaults = sliderDefaults,
    sliderStep = sliderStep,
    checkboxWidgets = checkboxWidgets,
    checkboxDefaults = checkboxDefaults,
    checkboxStatus = checkboxStatus,
    checkboxStatusDefaults = checkboxStatusDefaults,
    checkboxStep = checkboxStep,
    treeView = treeView,
    treeDefaults = treeDefaults,
    treeStep = treeStep,
    treeInfoLabel = treeInfoLabel,
    treeInfoDefaults = treeInfoDefaults,
    chartState = chartState,
    chartStep = chartStep,
    toggleState = toggleState,
    toggleStep = toggleStep,
    tableState = tableState,
    tableStep = tableStep,
    windowDemo = {
        step = windowDemo.frame,
        infoLabel = windowDemo.infoLabel,
        spawnButton = windowDemo.spawnButton,
        statusLabel = windowDemo.statusLabel,
        defaults = windowDemo.defaults
    },
    editorState = editorState,
    editorStep = editorStep,
    progressDeterminate = progressDeterminate,
    progressIndeterminate = progressIndeterminate,
    progressDefaults = progressDefaults,
    progressStep = progressStep,
    constraintState = constraintState,
    constraintStep = constraintStep,
    freeDrawState = freeDrawState,
    freeDrawStep = freeDrawStep,
    toastState = toastState,
    toastStep = toastStep,
    threadDemo = threadDemo,
    threadStep = threadStep
}

local function layoutToggleSection(state, stepWidth, stepHeight, innerMargin)
    local toggleState = state.toggleState
    if not toggleState or not toggleState.widget then
        return
    end

    local toggleStep = state.toggleStep
    local defaults = toggleState.defaults or {}
    local toggleWidthLimit = math.max(6, stepWidth - innerMargin * 2)
    local toggleHeightLimit = math.max(1, stepHeight - innerMargin * 2)
    local baseWidth = defaults.width or toggleState.widget.width
    local baseHeight = defaults.height or toggleState.widget.height
    local toggleWidth = math.max(6, math.min(baseWidth, toggleWidthLimit))
    local toggleHeight = math.max(1, math.min(baseHeight, toggleHeightLimit))
    toggleState.widget:setSize(toggleWidth, toggleHeight)
    local toggleX = math.floor((toggleStep.width - toggleWidth) / 2) + 1
    local toggleY = innerMargin + math.max(1, math.floor((stepHeight - toggleHeight) / 3))
    if toggleY + toggleHeight - 1 > innerMargin + stepHeight - 1 then
        toggleY = math.max(innerMargin, innerMargin + stepHeight - toggleHeight)
    end
    if toggleY < innerMargin then
        toggleY = innerMargin
    end
    toggleState.widget:setPosition(toggleX, toggleY)
    local sectionTop = toggleY
    local sectionBottom = toggleY + toggleHeight - 1

    if toggleState.secondary then
        local secondary = toggleState.secondary
        local secDefaults = toggleState.defaults and toggleState.defaults.secondary or { width = secondary.width, height = secondary.height }
        local secWidth = math.max(6, math.min(secDefaults.width or secondary.width, toggleWidthLimit))
        local secHeight = math.max(1, math.min(secDefaults.height or secondary.height, toggleHeightLimit))
        secondary:setSize(secWidth, secHeight)
        local secX = toggleX
        local secY = math.min(innerMargin + stepHeight - secHeight, toggleY + toggleHeight + 1)
        secondary:setPosition(secX, secY)
        if secY < sectionTop then
            sectionTop = secY
        end
        local secBottom = secY + secHeight - 1
        if secBottom > sectionBottom then
            sectionBottom = secBottom
        end
    end

    if toggleState.knobLabel then
        local label = toggleState.knobLabel
        local labelDefaults = toggleState.defaults and toggleState.defaults.knobLabel or { width = label.width, height = label.height }
        local labelWidth = math.max(3, math.min(labelDefaults.width or label.width, toggleWidthLimit))
        local labelHeight = math.max(1, math.min(labelDefaults.height or label.height, toggleHeightLimit))
        label:setSize(labelWidth, labelHeight)
        local labelX = toggleX + toggleWidth + 2
        if labelX + labelWidth - 1 > toggleStep.width then
            labelX = math.max(innerMargin, toggleStep.width - labelWidth + 1)
        end
        label:setPosition(labelX, sectionTop)
    end

    if toggleState.statusLabel then
        local statusDefaults = toggleState.statusDefaults or {}
        local statusWidth = math.max(6, math.min(statusDefaults.width or toggleState.statusLabel.width, toggleWidthLimit))
        local remaining = math.max(1, innerMargin + stepHeight - sectionBottom - 1)
        local statusHeight = math.max(1, math.min(statusDefaults.height or toggleState.statusLabel.height, remaining))
        toggleState.statusLabel:setSize(statusWidth, statusHeight)
        local statusX = math.floor((toggleStep.width - statusWidth) / 2) + 1
        local statusY = sectionBottom + 1
        if statusY + statusHeight - 1 > innerMargin + stepHeight - 1 then
            statusY = math.max(innerMargin, innerMargin + stepHeight - statusHeight)
        end
        toggleState.statusLabel:setPosition(statusX, statusY)
    end
end

local function layoutWindowDemo(state, stepWidth, stepHeight, innerMargin)
    local windowDemoState = state.windowDemo
    if not windowDemoState or not windowDemoState.step then
        return
    end

    local step = windowDemoState.step
    local usableWidth = math.max(6, stepWidth - innerMargin * 2)
    local currentY = innerMargin

    local infoLabel = windowDemoState.infoLabel
    if infoLabel then
        local defaults = windowDemoState.defaults and windowDemoState.defaults.info
        local targetWidth = defaults and defaults.width or infoLabel.width
        local targetHeight = defaults and defaults.height or infoLabel.height
        local infoWidth = math.max(6, math.min(targetWidth, usableWidth))
        local infoHeight = math.max(1, targetHeight)
        infoLabel:setSize(infoWidth, infoHeight)
        local infoX = math.floor((step.width - infoWidth) / 2) + 1
        infoLabel:setPosition(infoX, innerMargin)
        currentY = infoLabel.y + infoLabel.height
    end

    local spawnButton = windowDemoState.spawnButton
    if spawnButton then
        local defaults = windowDemoState.defaults and windowDemoState.defaults.button
        local targetWidth = defaults and defaults.width or spawnButton.width
        local targetHeight = defaults and defaults.height or spawnButton.height
        local buttonWidth = math.max(6, math.min(targetWidth, usableWidth))
        local buttonHeight = math.max(2, targetHeight)
        spawnButton:setSize(buttonWidth, buttonHeight)
        local buttonX = math.floor((step.width - buttonWidth) / 2) + 1
        local buttonY = currentY + 1
        if buttonY + buttonHeight - 1 > innerMargin + stepHeight - 1 then
            buttonY = math.max(innerMargin, innerMargin + stepHeight - buttonHeight)
        end
        spawnButton:setPosition(buttonX, buttonY)
        currentY = spawnButton.y + spawnButton.height
    end

    local statusLabel = windowDemoState.statusLabel
    if statusLabel then
        local defaults = windowDemoState.defaults and windowDemoState.defaults.status
        local targetWidth = defaults and defaults.width or statusLabel.width
        local targetHeight = defaults and defaults.height or statusLabel.height
        local statusWidth = math.max(6, math.min(targetWidth, usableWidth))
        local statusHeight = math.max(1, targetHeight)
        statusLabel:setSize(statusWidth, statusHeight)
        local statusX = math.floor((step.width - statusWidth) / 2) + 1
        local desiredY = currentY + 1
        local maxY = innerMargin + stepHeight - statusHeight
        if desiredY > maxY then
            desiredY = maxY
        end
        if desiredY < innerMargin then
            desiredY = innerMargin
        end
        statusLabel:setPosition(statusX, desiredY)
    end
end

local function layoutBasicWidgets(state, stepWidth, stepHeight, innerMargin)
    -- Button layout
    local buttonStep = state.buttonStep
    local stepButton = state.stepButton
    local defaultButtonSize = state.defaultButtonSize
    if buttonStep and stepButton and defaultButtonSize then
        local buttonWidth = math.max(4, math.min(defaultButtonSize.width, stepWidth))
        local buttonHeight = math.min(defaultButtonSize.height, stepHeight)
        stepButton:setSize(buttonWidth, buttonHeight)
        centerWidget(stepButton, buttonStep, buttonWidth, buttonHeight)
    end

    -- TextBox layout
    local textStep = state.textStep
    local stepBox = state.stepBox
    local defaultTextBoxSize = state.defaultTextBoxSize
    if textStep and stepBox and defaultTextBoxSize then
        local textWidthLimit = math.max(4, stepWidth - 2)
        local textWidth = math.max(4, math.min(defaultTextBoxSize.width, textWidthLimit))
        local textHeight = math.min(defaultTextBoxSize.height, stepHeight)
        stepBox:setSize(textWidth, textHeight)
        centerWidget(stepBox, textStep, textWidth, textHeight)
    end

    -- ComboBox layout
    local comboStep = state.comboStep
    local stepCombo = state.stepCombo
    local defaultComboSize = state.defaultComboSize
    if comboStep and stepCombo and defaultComboSize then
        local comboWidthLimit = math.max(6, stepWidth - 2)
        local comboWidth = math.max(6, math.min(defaultComboSize.width, comboWidthLimit))
        local comboHeight = math.min(defaultComboSize.height, stepHeight)
        stepCombo:setSize(comboWidth, comboHeight)
        centerWidget(stepCombo, comboStep, comboWidth, comboHeight)
    end
end

local function layoutListAndLabel(state, stepWidth, stepHeight, innerMargin)
    -- List widget layout
    local listWidget = state.listWidget
    if listWidget then
        local listDefaults = state.listDefaults or {}
        local listStep = state.listStep
        local listWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local listHeightLimit = math.max(3, stepHeight - innerMargin * 2)
        local baseWidth = listDefaults.width or listWidget.width
        local baseHeight = listDefaults.height or listWidget.height
        local listWidth = math.max(6, math.min(baseWidth, listWidthLimit))
        local listHeight = math.max(3, math.min(baseHeight, listHeightLimit))
        listWidget:setSize(listWidth, listHeight)
        centerWidget(listWidget, listStep, listWidth, listHeight)
    end

    -- Label layout
    local labelTitle = state.labelTitle
    local labelBody = state.labelBody
    if labelTitle and labelBody then
        local labelStep = state.labelStep
        local labelDefaults = state.labelDefaults
        local labelWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local labelHeightLimit = math.max(4, stepHeight - innerMargin * 2)
        local titleDefaults = labelDefaults and labelDefaults.title or {}
        local bodyDefaults = labelDefaults and labelDefaults.body or {}
        local titleHeight = math.max(1, math.min(titleDefaults.height or labelTitle.height, math.floor(labelHeightLimit / 2)))
        local bodyHeightLimit = math.max(1, labelHeightLimit - titleHeight - 1)
        local bodyHeight = math.max(1, math.min(bodyDefaults.height or labelBody.height, bodyHeightLimit))
        local totalHeight = titleHeight + 1 + bodyHeight
        local titleWidth = math.max(6, math.min(titleDefaults.width or labelTitle.width, labelWidthLimit))
        local bodyWidth = math.max(6, math.min(bodyDefaults.width or labelBody.width, labelWidthLimit))
        labelTitle:setSize(titleWidth, titleHeight)
        labelBody:setSize(bodyWidth, bodyHeight)
        local startY = innerMargin + math.floor((stepHeight - totalHeight) / 2)
        local titleX = math.floor((labelStep.width - titleWidth) / 2) + 1
        local bodyX = math.floor((labelStep.width - bodyWidth) / 2) + 1
        labelTitle:setPosition(titleX, startY)
        labelBody:setPosition(bodyX, startY + titleHeight + 1)
    end
end

local function layoutRadioButtons(state, stepWidth, stepHeight, innerMargin)
    local radioButtons = state.radioButtons or {}
    if #radioButtons > 0 then
        local radioStep = state.radioStep
        local radioDefaultWidths = state.radioDefaultWidths or {}
        local maxRadioWidth = math.max(4, stepWidth - innerMargin)
        local freeRows = math.max(0, stepHeight - #radioButtons)
        local gap = (#radioButtons > 1) and math.floor(freeRows / (#radioButtons - 1)) or 0
        local radioY = innerMargin
        for index = 1, #radioButtons do
            local radio = radioButtons[index]
            if radio then
                local defaultWidth = radioDefaultWidths[index] or radio.width
                local radioWidth = math.max(4, math.min(defaultWidth, maxRadioWidth))
                radio:setSize(radioWidth, radio.height)
                local radioX = math.floor((radioStep.width - radioWidth) / 2) + 1
                radio:setPosition(radioX, radioY)
                radioY = radioY + 1 + gap
            end
        end
    end
end

local function layout()
    local state = layoutState
    local app = state.app
    local root = state.root
    local wizard = state.wizard
    local stepsList = state.steps
    local navHeight = state.navHeight
    local navGap = state.navGap
    local innerMargin = state.innerMargin
    local prevButton = state.prevButton
    local nextButton = state.nextButton

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
    for i = 1, #stepsList do
        stepsList[i].frame:setSize(stepWidth, stepHeight)
    end

    if not isAnimating then
        applyStepVisibility(currentStep)
        local active = stepsList[currentStep]
        if active then
            if active.onShow then
                active.onShow()
            else
                app:setFocus(nil)
            end
        end
    end

    -- Basic widgets (Button, TextBox, ComboBox)
    layoutBasicWidgets(state, stepWidth, stepHeight, innerMargin)

    -- List widget and Label layout
    layoutListAndLabel(state, stepWidth, stepHeight, innerMargin)

    -- Radio buttons layout
    layoutRadioButtons(state, stepWidth, stepHeight, innerMargin)

    local sliderSingle = state.sliderSingle
    local sliderRange = state.sliderRange
    if sliderSingle and sliderRange then
        local sliderStep = state.sliderStep
        local sliderDefaults = state.sliderDefaults
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

    local checkboxWidgets = state.checkboxWidgets or {}
    if #checkboxWidgets > 0 then
        local checkboxStep = state.checkboxStep
        local checkboxDefaults = state.checkboxDefaults or {}
        local checkboxStatus = state.checkboxStatus
        local checkboxStatusDefaults = state.checkboxStatusDefaults
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

    local treeView = state.treeView
    if treeView then
        local treeStep = state.treeStep
        local treeDefaults = state.treeDefaults or {}
        local treeInfoLabel = state.treeInfoLabel
        local treeInfoDefaults = state.treeInfoDefaults
        local treeWidthLimit = math.max(8, stepWidth - innerMargin * 2)
        local defaultWidth = treeDefaults.width or treeView.width
        local defaultHeight = treeDefaults.height or treeView.height
        local treeWidth = math.max(8, math.min(defaultWidth, treeWidthLimit))

        local infoHeight = 0
        local infoWidth = 0
        if treeInfoLabel then
            local infoDefaults = treeInfoDefaults or {}
            infoWidth = math.max(6, math.min(infoDefaults.width or treeInfoLabel.width, treeWidthLimit))
            local maxInfoHeight = math.max(2, stepHeight - 4)
            infoHeight = math.max(2, math.min(infoDefaults.height or treeInfoLabel.height, maxInfoHeight))
        end

        local availableHeightForTree = math.max(1, stepHeight - infoHeight - 1)
        local treeHeight = math.min(defaultHeight, availableHeightForTree)
        if availableHeightForTree >= 3 then
            treeHeight = math.max(3, treeHeight)
        end
        treeHeight = math.max(1, math.min(treeHeight, availableHeightForTree))

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

    local chartState = state.chartState
    if chartState.widget then
        local chartStep = state.chartStep
        local defaults = chartState.defaults or {}
        local chartWidthLimit = math.max(8, stepWidth - innerMargin * 2)
        local chartHeightLimit = math.max(4, stepHeight - innerMargin * 3)
        local chartWidth = math.max(8, math.min(defaults.width or chartState.widget.width, chartWidthLimit))
        local chartHeight = math.max(4, math.min(defaults.height or chartState.widget.height, chartHeightLimit))
        chartState.widget:setSize(chartWidth, chartHeight)
        local chartX = math.floor((chartStep.width - chartWidth) / 2) + 1
        local chartY = innerMargin + 1
        if chartY + chartHeight - 1 > innerMargin + stepHeight - 1 then
            chartY = math.max(innerMargin, innerMargin + stepHeight - chartHeight)
        end
        chartState.widget:setPosition(chartX, chartY)

        if chartState.infoLabel then
            local infoDefaults = chartState.infoDefaults or {}
            local infoWidth = math.max(6, math.min(infoDefaults.width or chartState.infoLabel.width, chartWidthLimit))
            local remainingHeight = math.max(1, stepHeight - (chartY - innerMargin) - chartHeight - 1)
            local infoHeight = math.max(1, math.min(infoDefaults.height or chartState.infoLabel.height, remainingHeight))
            chartState.infoLabel:setSize(infoWidth, infoHeight)
            local infoX = math.floor((chartStep.width - infoWidth) / 2) + 1
            local infoY = chartY + chartHeight + 1
            if infoY + infoHeight - 1 > innerMargin + stepHeight - 1 then
                infoY = math.max(innerMargin, innerMargin + stepHeight - infoHeight)
            end
            chartState.infoLabel:setPosition(infoX, infoY)
        end
    end

    layoutToggleSection(state, stepWidth, stepHeight, innerMargin)

    layoutWindowDemo(state, stepWidth, stepHeight, innerMargin)

    local tableState = state.tableState
    if tableState.widget then
        local tableStep = state.tableStep
        local defaults = tableState.defaults or {}
        local tableWidthLimit = math.max(8, stepWidth - innerMargin * 2)
        local tableHeightLimit = math.max(4, stepHeight - innerMargin * 3)
        local baseWidth = defaults.width or tableState.widget.width
        local baseHeight = defaults.height or tableState.widget.height
        local tableWidth = math.max(8, math.min(baseWidth, tableWidthLimit))
        local tableHeight = math.max(4, math.min(baseHeight, tableHeightLimit))
        tableState.widget:setSize(tableWidth, tableHeight)
        local tableX = math.floor((tableStep.width - tableWidth) / 2) + 1
        local tableY = innerMargin + 1
        local maxTableY = innerMargin + stepHeight - tableHeight - 3
        if maxTableY < innerMargin then
            maxTableY = innerMargin
        end
        if tableY > maxTableY then
            tableY = maxTableY
        end
        tableState.widget:setPosition(tableX, tableY)

        local detailBottomGuard = innerMargin + stepHeight - 1
        local detailY = tableY + tableHeight + 1
        if tableState.detailLabel then
            local detailDefaults = tableState.detailDefaults or {}
            local detailWidth = math.max(6, math.min(detailDefaults.width or tableState.detailLabel.width, tableWidthLimit))
            local maxDetailHeight = math.max(2, detailBottomGuard - detailY - (tableState.refreshButton and 2 or 0))
            local detailHeight = math.max(2, math.min(detailDefaults.height or tableState.detailLabel.height, maxDetailHeight))
            tableState.detailLabel:setSize(detailWidth, detailHeight)
            local detailX = math.floor((tableStep.width - detailWidth) / 2) + 1
            if detailY + detailHeight - 1 > detailBottomGuard then
                detailY = math.max(innerMargin, detailBottomGuard - detailHeight + 1)
            end
            tableState.detailLabel:setPosition(detailX, detailY)
            detailBottomGuard = detailY + detailHeight
        end

        if tableState.refreshButton then
            local refreshDefaults = tableState.refreshDefaults or {}
            local rWidth = math.max(8, math.min(refreshDefaults.width or tableState.refreshButton.width, tableWidthLimit))
            local rHeight = math.max(1, refreshDefaults.height or tableState.refreshButton.height)
            local rX = math.floor((tableStep.width - rWidth) / 2) + 1
            local rY = detailBottomGuard + 1
            if rY + rHeight - 1 > innerMargin + stepHeight - 1 then
                rY = math.max(innerMargin, innerMargin + stepHeight - rHeight)
            end
            tableState.refreshButton:setSize(rWidth, rHeight)
            tableState.refreshButton:setPosition(rX, rY)
        end
    end

    local editorState = state.editorState
    if editorState.widget then
        local editorStep = state.editorStep
        local defaults = editorState.defaults or {}
        local editorWidthLimit = math.max(10, stepWidth - innerMargin * 2)
        local editorHeightLimit = math.max(4, stepHeight - innerMargin * 3)
        local baseWidth = defaults.width or editorState.widget.width
        local baseHeight = defaults.height or editorState.widget.height
        local editorWidth = math.max(10, math.min(baseWidth, editorWidthLimit))
        local editorHeight = math.max(4, math.min(baseHeight, editorHeightLimit))
        editorState.widget:setSize(editorWidth, editorHeight)
        local editorX = math.floor((editorStep.width - editorWidth) / 2) + 1
        local editorY = innerMargin + 1
        local editorMaxY = innerMargin + stepHeight - editorHeight - 2
        if editorMaxY < innerMargin then
            editorMaxY = innerMargin
        end
        if editorY > editorMaxY then
            editorY = editorMaxY
        end
        editorState.widget:setPosition(editorX, editorY)

        local nextY = editorY + editorHeight + 1
        local bottomLimit = innerMargin + stepHeight - 1

        if editorState.statusLabel then
            local statusDefaults = editorState.statusDefaults or {}
            local statusWidth = math.max(6, math.min(statusDefaults.width or editorState.statusLabel.width, editorWidthLimit))
            local statusHeight = math.max(1, statusDefaults.height or editorState.statusLabel.height)
            editorState.statusLabel:setSize(statusWidth, statusHeight)
            local statusX = math.floor((editorStep.width - statusWidth) / 2) + 1
            local statusY = nextY
            if statusY + statusHeight - 1 > bottomLimit then
                statusY = math.max(innerMargin, bottomLimit - statusHeight + 1)
            end
            editorState.statusLabel:setPosition(statusX, statusY)
            nextY = statusY + statusHeight + 1
        end

        if editorState.instructions then
            local instructionsDefaults = editorState.instructionsDefaults or {}
            local instructionsWidth = math.max(6, math.min(instructionsDefaults.width or editorState.instructions.width, editorWidthLimit))
            local instructionsHeight = math.max(2, math.min(instructionsDefaults.height or editorState.instructions.height, math.max(2, bottomLimit - nextY + 1)))
            editorState.instructions:setSize(instructionsWidth, instructionsHeight)
            local instructionsX = math.floor((editorStep.width - instructionsWidth) / 2) + 1
            local instructionsY = nextY
            if instructionsY + instructionsHeight - 1 > bottomLimit then
                instructionsY = math.max(innerMargin, bottomLimit - instructionsHeight + 1)
            end
            editorState.instructions:setPosition(instructionsX, instructionsY)
        end
    end

    local progressDeterminate = state.progressDeterminate
    local progressIndeterminate = state.progressIndeterminate
    if progressDeterminate and progressIndeterminate then
        local progressStep = state.progressStep
        local progressDefaults = state.progressDefaults or {}
        local detDefaults = progressDefaults.determinate or { width = progressDeterminate.width, height = progressDeterminate.height }
        local indDefaults = progressDefaults.indeterminate or { width = progressIndeterminate.width, height = progressIndeterminate.height }
        local barWidthLimit = math.max(6, stepWidth - innerMargin * 2)
        local detWidth = math.max(6, math.min(detDefaults.width or progressDeterminate.width, barWidthLimit))
        local indWidth = math.max(6, math.min(indDefaults.width or progressIndeterminate.width, barWidthLimit))
        local detHeight = math.max(1, math.min(detDefaults.height or progressDeterminate.height, stepHeight))
        local indHeight = math.max(1, math.min(indDefaults.height or progressIndeterminate.height, stepHeight))
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

    local constraintLayout = state.constraintState
    if constraintLayout and constraintLayout.frame and constraintLayout.box then
        local constraintStep = constraintLayout.frame
        local defaults = constraintLayout.defaults or {}
    local instructions = constraintLayout.instructions
    local infoLabel = constraintLayout.infoLabel
    local surface = constraintLayout.surface
    local surfaceDefaults = defaults.surface or { width = surface and surface.width, height = surface and surface.height }
    local buttons = constraintLayout.buttons or {}
    local buttonDefaults = constraintLayout.buttonDefaults or {}
        local maxWidth = math.max(8, stepWidth - innerMargin * 2)
        local topCursor = innerMargin
        local bottomCursor = innerMargin + stepHeight - 1

        if instructions then
            local instDefaults = defaults.instructions or { width = instructions.width, height = instructions.height }
            local instWidth = math.max(10, math.min(instDefaults.width or instructions.width, maxWidth))
            local instHeight = math.max(1, math.min(instDefaults.height or instructions.height, math.max(1, math.floor(stepHeight / 4))))
            instructions:setSize(instWidth, instHeight)
            local instX = math.floor((constraintStep.width - instWidth) / 2) + 1
            instructions:setPosition(instX, topCursor)
            topCursor = math.min(bottomCursor, topCursor + instHeight + 1)
        end

        if infoLabel then
            local infoDefaults = defaults.info or { width = infoLabel.width, height = infoLabel.height }
            local infoWidth = math.max(10, math.min(infoDefaults.width or infoLabel.width, maxWidth))
            local availableHeight = math.max(1, bottomCursor - topCursor + 1)
            local infoHeight = math.max(1, math.min(infoDefaults.height or infoLabel.height, availableHeight))
            infoLabel:setSize(infoWidth, infoHeight)
            local infoX = math.floor((constraintStep.width - infoWidth) / 2) + 1
            infoLabel:setPosition(infoX, topCursor)
            local presets = constraintLayout.presets
            if presets then
                local activePreset = presets[constraintLayout.activePresetIndex or 1]
                if activePreset then
                    infoLabel:setText(formatConstraintSummary(activePreset))
                end
            end
            topCursor = math.min(bottomCursor, topCursor + infoHeight + 1)
        end

        local buttonCount = #buttons
        local buttonSpacing = 2
        local buttonWidths = {}
        local buttonHeight = 0
        local buttonTotalWidth = -buttonSpacing
        if buttonCount > 0 then
            for index = 1, buttonCount do
                local button = buttons[index]
                if button then
                    local defaultsEntry = buttonDefaults[index] or { width = button.width, height = button.height }
                    local widthLimit = math.max(8, math.floor((maxWidth - buttonSpacing * (buttonCount - 1)) / buttonCount))
                    local widthValue = math.max(8, math.min(defaultsEntry.width or button.width, widthLimit))
                    local heightValue = math.max(1, defaultsEntry.height or button.height)
                    button:setSize(widthValue, heightValue)
                    buttonWidths[index] = widthValue
                    buttonHeight = math.max(buttonHeight, heightValue)
                    buttonTotalWidth = buttonTotalWidth + widthValue + buttonSpacing
                end
            end
            buttonTotalWidth = math.max(0, buttonTotalWidth)
        end

        local reservedBottom = bottomCursor
        if buttonCount > 0 then
            reservedBottom = reservedBottom - buttonHeight - 1
            if reservedBottom < topCursor then
                reservedBottom = topCursor
            end
        end

        if surface then
            local surfaceWidth = math.max(8, math.min(surfaceDefaults.width or surface.width, maxWidth))
            local surfaceHeightLimit = math.max(3, reservedBottom - topCursor + 1)
            local surfaceHeight = math.max(3, math.min(surfaceDefaults.height or surface.height, surfaceHeightLimit))
            surface:setSize(surfaceWidth, surfaceHeight)
            local surfaceX = math.floor((constraintStep.width - surfaceWidth) / 2) + 1
            local surfaceY = topCursor
            surface:setPosition(surfaceX, surfaceY)
            topCursor = math.min(bottomCursor, surfaceY + surfaceHeight + 1)
        end

        if buttonCount > 0 then
            local buttonY = bottomCursor - buttonHeight + 1
            if buttonY < topCursor then
                buttonY = topCursor
            end
            local buttonX = math.floor((constraintStep.width - buttonTotalWidth) / 2) + 1
            for index = 1, buttonCount do
                local button = buttons[index]
                if button then
                    local widthValue = buttonWidths[index] or button.width
                    button:setPosition(buttonX, buttonY)
                    buttonX = buttonX + widthValue + buttonSpacing
                end
            end
            bottomCursor = math.max(topCursor, buttonY - 1)
        end
    end

    local freeDrawLayout = state.freeDrawState
    if freeDrawLayout and freeDrawLayout.frame and freeDrawLayout.widget then
        local freeDrawStep = freeDrawLayout.frame
        local defaults = freeDrawLayout.defaults or {}
        local instructions = freeDrawLayout.instructions
        local patternLabel = freeDrawLayout.patternLabel
        local nextButton = freeDrawLayout.nextButton
        local canvas = freeDrawLayout.widget
        local maxWidth = math.max(10, stepWidth - innerMargin * 2)
        local topCursor = innerMargin
        local bottomCursor = innerMargin + stepHeight - 1

        if instructions then
            local instDefaults = defaults.instructions or { width = instructions.width, height = instructions.height }
            local instWidth = math.max(12, math.min(instDefaults.width or instructions.width, maxWidth))
            local instHeight = math.max(2, math.min(instDefaults.height or instructions.height, math.max(2, math.floor(stepHeight / 3))))
            instructions:setSize(instWidth, instHeight)
            local instX = math.floor((freeDrawStep.width - instWidth) / 2) + 1
            instructions:setPosition(instX, topCursor)
            topCursor = math.min(bottomCursor, topCursor + instHeight + 1)
        end

        if nextButton then
            local buttonDefaults = defaults.button or { width = nextButton.width, height = nextButton.height }
            local buttonWidth = math.max(10, math.min(buttonDefaults.width or nextButton.width, maxWidth))
            local buttonHeight = math.max(1, buttonDefaults.height or nextButton.height)
            nextButton:setSize(buttonWidth, buttonHeight)
            local buttonX = math.floor((freeDrawStep.width - buttonWidth) / 2) + 1
            local buttonY = bottomCursor - buttonHeight + 1
            if buttonY < topCursor then
                buttonY = topCursor
            end
            nextButton:setPosition(buttonX, buttonY)
            bottomCursor = math.max(topCursor, buttonY - 1)
        end

        if patternLabel then
            local patternDefaults = defaults.pattern or { width = patternLabel.width, height = patternLabel.height }
            local patternWidth = math.max(10, math.min(patternDefaults.width or patternLabel.width, maxWidth))
            local patternHeight = math.max(1, math.min(patternDefaults.height or patternLabel.height, math.max(1, bottomCursor - topCursor + 1)))
            patternLabel:setSize(patternWidth, patternHeight)
            local patternX = math.floor((freeDrawStep.width - patternWidth) / 2) + 1
            local patternY = bottomCursor - patternHeight + 1
            if patternY < topCursor then
                patternY = topCursor
            end
            patternLabel:setPosition(patternX, patternY)
            bottomCursor = math.max(topCursor, patternY - 1)
        end

        if canvas then
            local canvasDefaults = defaults.canvas or { width = canvas.width, height = canvas.height }
            local canvasWidth = math.max(10, math.min(canvasDefaults.width or canvas.width, maxWidth))
            local availableHeight = math.max(4, bottomCursor - topCursor + 1)
            local canvasHeight = math.max(4, math.min(canvasDefaults.height or canvas.height, availableHeight))
            canvas:setSize(canvasWidth, canvasHeight)
            local canvasX = math.floor((freeDrawStep.width - canvasWidth) / 2) + 1
            local canvasY = topCursor + math.floor((availableHeight - canvasHeight) / 2)
            if canvasY < topCursor then
                canvasY = topCursor
            end
            if canvasY + canvasHeight - 1 > topCursor + availableHeight - 1 then
                canvasY = math.max(topCursor, topCursor + availableHeight - canvasHeight)
            end
            canvas:setPosition(canvasX, canvasY)
        end
    end

    local toastLayoutState = state.toastState
    if toastLayoutState and toastLayoutState.frame and toastLayoutState.toast then
        local toastStep = state.toastStep
        local instructions = toastLayoutState.instructions
        local toastWidget = toastLayoutState.toast
        local buttonList = toastLayoutState.buttons or {}
        local buttonDefaults = toastLayoutState.buttonDefaults or {}
        local defaults = toastLayoutState.defaults or {}
        local instructionsDefaults = defaults.instructions or {}
        local toastDefaults = defaults.toast or {}
        local maxWidth = math.max(8, stepWidth - innerMargin * 2)
        local maxHeight = math.max(3, stepHeight - innerMargin * 2)

        local toastWidth = math.max(12, math.min(toastDefaults.width or toastWidget.width, maxWidth))
        local toastHeight = math.max(3, math.min(toastDefaults.height or toastWidget.height, maxHeight))
        toastWidget:setSize(toastWidth, toastHeight)
        toastWidget:refreshAnchor(false)

        local targetX, targetY = toastWidget:getAnchorTargetPosition()
        if not targetX then
            targetX = innerMargin
        end
        if not targetY then
            targetY = innerMargin
        end
        local toastRight = targetX + toastWidth - 1
        local toastBottom = targetY + toastHeight - 1

        local leftAvailable = math.max(0, targetX - innerMargin - 1)
        local bottomSpace = math.max(0, innerMargin + stepHeight - toastBottom - 1)
        local columnLayout = leftAvailable >= 14

        local instructionsHeight = 0
        if instructions then
            if columnLayout then
                local instWidth = math.max(10, math.min(instructionsDefaults.width or instructions.width, leftAvailable))
                local instHeightLimit = math.max(2, stepHeight - innerMargin * 2)
                local instHeight = math.max(2, math.min(instructionsDefaults.height or instructions.height, instHeightLimit))
                instructions:setSize(instWidth, instHeight)
                instructions:setPosition(innerMargin, innerMargin)
                instructionsHeight = instHeight
            else
                local instWidth = math.max(12, math.min(instructionsDefaults.width or instructions.width, maxWidth))
                local instHeightLimit = math.max(2, bottomSpace > 0 and bottomSpace or stepHeight - toastHeight - innerMargin)
                local instHeight = math.max(2, math.min(instructionsDefaults.height or instructions.height, instHeightLimit))
                instructions:setSize(instWidth, instHeight)
                local instX = math.floor((toastStep.width - instWidth) / 2) + 1
                local instY = toastBottom + 1
                local bottomLimit = innerMargin + stepHeight - 1
                if instY + instHeight - 1 > bottomLimit then
                    instY = math.max(innerMargin, bottomLimit - instHeight + 1)
                end
                instructions:setPosition(instX, instY)
                instructionsHeight = instHeight
                bottomSpace = math.max(0, bottomLimit - instY - instHeight + 1)
            end
        end

        if #buttonList > 0 then
            if columnLayout then
                local columnWidth = math.max(10, math.min(leftAvailable, maxWidth))
                local cursorY = innerMargin + instructionsHeight + 1
                if cursorY < innerMargin then
                    cursorY = innerMargin
                end
                for index = 1, #buttonList do
                    local button = buttonList[index]
                    if button then
                        local defaultsEntry = buttonDefaults[index] or {}
                        local width = math.max(8, math.min(defaultsEntry.width or button.width, columnWidth))
                        local height = math.max(1, defaultsEntry.height or button.height)
                        if cursorY + height - 1 > innerMargin + stepHeight - 1 then
                            cursorY = innerMargin + stepHeight - height
                        end
                        button:setSize(width, height)
                        button:setPosition(innerMargin, cursorY)
                        cursorY = math.min(innerMargin + stepHeight - 1, cursorY + height + 1)
                    end
                end
            else
                local buttonSpacing = 2
                local widths = {}
                local buttonHeight = 0
                local totalWidth = -buttonSpacing
                local baseWidth = math.max(8, math.floor((maxWidth - (#buttonList - 1) * buttonSpacing) / #buttonList))
                for index = 1, #buttonList do
                    local button = buttonList[index]
                    if button then
                        local defaultsEntry = buttonDefaults[index] or {}
                        local width = math.max(8, math.min(defaultsEntry.width or button.width, baseWidth))
                        local height = math.max(1, defaultsEntry.height or button.height)
                        button:setSize(width, height)
                        widths[index] = width
                        buttonHeight = math.max(buttonHeight, height)
                        totalWidth = totalWidth + width + buttonSpacing
                    end
                end
                totalWidth = math.max(0, totalWidth)
                local rowX = math.floor((toastStep.width - totalWidth) / 2) + 1
                if rowX < innerMargin then
                    rowX = innerMargin
                end
                local rowY = innerMargin + stepHeight - buttonHeight
                if rowY <= toastBottom then
                    rowY = toastBottom + instructionsHeight + 1
                    if rowY + buttonHeight - 1 > innerMargin + stepHeight - 1 then
                        rowY = innerMargin + stepHeight - buttonHeight
                    end
                end
                for index = 1, #buttonList do
                    local button = buttonList[index]
                    if button then
                        local width = widths[index] or button.width
                        button:setPosition(rowX, rowY)
                        rowX = rowX + width + buttonSpacing
                    end
                end
            end
        end
    end

    local threadDemo = state.threadDemo
    if threadDemo.list and threadDemo.instructions and threadDemo.detailLabel and threadDemo.startButton and threadDemo.cancelButton then
        local threadStep = state.threadStep
        local defaults = threadDemo.defaults or {}
        local instructionsDefaults = defaults.instructions or { width = threadDemo.instructions.width, height = threadDemo.instructions.height }
        local listDefaults = defaults.list or { width = threadDemo.list.width, height = threadDemo.list.height }
        local detailDefaults = defaults.detail or { width = threadDemo.detailLabel.width, height = threadDemo.detailLabel.height }
        local startDefaults = defaults.startButton or { width = threadDemo.startButton.width, height = threadDemo.startButton.height }
        local cancelDefaults = defaults.cancelButton or { width = threadDemo.cancelButton.width, height = threadDemo.cancelButton.height }
        local maxWidth = math.max(8, stepWidth - innerMargin * 2)
        local buttonHeight = math.max(1, math.max(startDefaults.height or threadDemo.startButton.height, cancelDefaults.height or threadDemo.cancelButton.height))
        local bottomY = innerMargin + stepHeight - 1
        local startWidth = math.max(8, math.min(startDefaults.width or threadDemo.startButton.width, math.floor(maxWidth / 2)))
        local cancelWidth = math.max(8, math.min(cancelDefaults.width or threadDemo.cancelButton.width, math.floor(maxWidth / 2)))
        threadDemo.startButton:setSize(startWidth, buttonHeight)
        threadDemo.cancelButton:setSize(cancelWidth, buttonHeight)
        local buttonSpacing = 2
        local totalButtonWidth = startWidth + cancelWidth + buttonSpacing
        if totalButtonWidth > stepWidth - innerMargin * 2 then
            local over = totalButtonWidth - (stepWidth - innerMargin * 2)
            local adjust = math.ceil(over / 2)
            startWidth = math.max(6, startWidth - adjust)
            cancelWidth = math.max(6, cancelWidth - adjust)
            threadDemo.startButton:setSize(startWidth, buttonHeight)
            threadDemo.cancelButton:setSize(cancelWidth, buttonHeight)
            totalButtonWidth = startWidth + cancelWidth + buttonSpacing
        end
        local buttonX = math.floor((threadStep.width - totalButtonWidth) / 2) + 1
        if buttonX < innerMargin then
            buttonX = innerMargin
        end
        local buttonY = bottomY - buttonHeight + 1
        threadDemo.startButton:setPosition(buttonX, buttonY)
        threadDemo.cancelButton:setPosition(buttonX + startWidth + buttonSpacing, buttonY)

        local availableHeightForContent = buttonY - innerMargin - 1
        if availableHeightForContent < 5 then
            availableHeightForContent = 5
        end
        local instructionsHeight = math.max(2, math.min(instructionsDefaults.height or threadDemo.instructions.height, math.max(2, math.floor(availableHeightForContent / 3))))
        local instrWidth = math.max(8, math.min(instructionsDefaults.width or threadDemo.instructions.width, maxWidth))
        threadDemo.instructions:setSize(instrWidth, instructionsHeight)
        local instrX = math.floor((threadStep.width - instrWidth) / 2) + 1
        local instrY = innerMargin
        threadDemo.instructions:setPosition(instrX, instrY)

        local listAvailableHeight = availableHeightForContent - instructionsHeight - 1
        if listAvailableHeight < 3 then
            listAvailableHeight = 3
        end
        local detailHeight = math.max(2, math.min(detailDefaults.height or threadDemo.detailLabel.height, math.max(2, math.floor(listAvailableHeight / 3))))
        local listHeight = math.max(3, math.min(listDefaults.height or threadDemo.list.height, listAvailableHeight - detailHeight - 1))
        if listHeight < 3 then
            listHeight = 3
        end
        local listWidth = math.max(8, math.min(listDefaults.width or threadDemo.list.width, maxWidth))
        threadDemo.list:setSize(listWidth, listHeight)
        local listX = math.floor((threadStep.width - listWidth) / 2) + 1
        local listY = instrY + instructionsHeight + 1
        threadDemo.list:setPosition(listX, listY)

        local detailWidth = listWidth
        threadDemo.detailLabel:setSize(detailWidth, detailHeight)
        local detailY = listY + listHeight + 1
        if detailY + detailHeight - 1 > buttonY - 1 then
            detailY = math.max(instrY + instructionsHeight + 1, buttonY - detailHeight)
        end
        threadDemo.detailLabel:setPosition(listX, detailY)
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
