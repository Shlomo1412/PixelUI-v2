# PixelUI.TextBox

*Extends: PixelUI.Widget*

A text input widget supporting single and multi-line input. Features syntax highlighting, autocomplete, and find/replace.

## Properties

| Name | Type | Description |
|------|------|-------------|
| text | `string` | Current text content |
| placeholder | `string` | Placeholder text shown when empty |
| onChange | `fun(self:PixelUI.TextBox,` |  |
| maxLength | `integer?` | Maximum allowed text length |
| multiline | `boolean` | Whether to support multiple lines |
| autocomplete | `string[]?` | Array of autocomplete suggestions |
| autocompleteMaxItems | `integer?` | Maximum suggestions shown in popup |
| autocompleteBg | `PixelUI.Color?` | Popup background color |
| autocompleteFg | `PixelUI.Color?` | Popup foreground color |
| autocompleteHighlightBg | `PixelUI.Color?` | Highlight background for the active suggestion |
| autocompleteHighlightFg | `PixelUI.Color?` | Highlight foreground for the active suggestion |
| autocompleteBorder | `PixelUI.BorderConfig?` | Optional border for the popup |
| autocompleteMaxWidth | `integer?` | Maximum popup width in characters |
| autocompleteGhostColor | `PixelUI.Color?` | Ghost text color inside the editor |
| syntax | `table?` | Syntax highlighting configuration |
| scrollbar | `PixelUI.ScrollbarConfig?` | Optional scrollbar configuration |

## Methods

### new

```lua
new()
```

### setOnCursorMove

```lua
setOnCursorMove()
```

### setScrollbar

```lua
setScrollbar()
```

### setPlaceholderColor

```lua
setPlaceholderColor()
```

### setNumericOnly

```lua
setNumericOnly()
```

### onFocusChanged

```lua
onFocusChanged()
```

### _applyMaxLength

```lua
_applyMaxLength()
```

### _positionToIndex

```lua
_positionToIndex()
```

### _getSelectionIndices

```lua
_getSelectionIndices()
```

### _simulateReplacementText

```lua
_simulateReplacementText()
```

### _sanitizeNumericInput

```lua
_sanitizeNumericInput()
```

### _isNumericText

```lua
_isNumericText()
```

### _allowsNumericInsertion

```lua
_allowsNumericInsertion()
```

### _syncTextFromLines

```lua
_syncTextFromLines()
```

### _setTextInternal

```lua
_setTextInternal()
```

### _indexToPosition

```lua
_indexToPosition()
```

### _moveCursorToIndex

```lua
_moveCursorToIndex()
```

### getCursorPosition

```lua
getCursorPosition()
```

### getLineCount

```lua
getLineCount()
```

### _getInnerMetrics

```lua
_getInnerMetrics()
```

### _getOverlayHeight

```lua
_getOverlayHeight()
```

### _computeLayoutMetrics

```lua
_computeLayoutMetrics()
```

### _getContentSize

```lua
_getContentSize()
```

### _ensureCursorVisible

```lua
_ensureCursorVisible()
```

### _notifyChange

```lua
_notifyChange()
```

### _notifyCursorChange

```lua
_notifyCursorChange()
```

### _hasSelection

```lua
_hasSelection()
```

### getSelectionLength

```lua
getSelectionLength()
```

### getSelectionText

```lua
getSelectionText()
```

### _getSelectionRange

```lua
_getSelectionRange()
```

### _collectRange

```lua
_collectRange()
```

### _clearSelection

```lua
_clearSelection()
```

### _removeRange

```lua
_removeRange()
```

### _insertAt

```lua
_insertAt()
```

### _deleteSelection

```lua
_deleteSelection()
```

### _replaceSelection

```lua
_replaceSelection()
```

### _insertTextAtCursor

```lua
_insertTextAtCursor()
```

### _insertCharacter

```lua
_insertCharacter()
```

### _insertNewline

```lua
_insertNewline()
```

### _insertTab

```lua
_insertTab()
```

### _deleteBackward

```lua
_deleteBackward()
```

### _deleteForward

```lua
_deleteForward()
```

### _setCursorPosition

```lua
_setCursorPosition()
```

### _moveCursorLeft

```lua
_moveCursorLeft()
```

### _moveCursorRight

```lua
_moveCursorRight()
```

### _moveCursorVertical

```lua
_moveCursorVertical()
```

### _moveCursorUp

```lua
_moveCursorUp()
```

### _moveCursorDown

```lua
_moveCursorDown()
```

### _moveCursorLineStart

```lua
_moveCursorLineStart()
```

### _moveCursorLineEnd

```lua
_moveCursorLineEnd()
```

### _moveCursorDocumentStart

```lua
_moveCursorDocumentStart()
```

### _moveCursorDocumentEnd

```lua
_moveCursorDocumentEnd()
```

### _selectAll

```lua
_selectAll()
```

### _scrollLines

```lua
_scrollLines()
```

### _scrollColumns

```lua
_scrollColumns()
```

### _cursorFromPoint

```lua
_cursorFromPoint()
```

### _computeSyntaxColors

```lua
_computeSyntaxColors()
```

### _buildLineSegments

```lua
_buildLineSegments()
```

### _drawSegments

```lua
_drawSegments()
```

### _drawFindOverlay

```lua
_drawFindOverlay()
```

### _hideAutocomplete

```lua
_hideAutocomplete()
```

### _isPointInAutocomplete

```lua
_isPointInAutocomplete()
```

### _autocompleteIndexFromPoint

```lua
_autocompleteIndexFromPoint()
```

### _drawDropdown

```lua
_drawDropdown()
```

### _updateAutocomplete

```lua
_updateAutocomplete()
```

### _computeAutocompleteGhost

```lua
_computeAutocompleteGhost()
```

### _acceptAutocomplete

```lua
_acceptAutocomplete()
```

### _moveAutocompleteSelection

```lua
_moveAutocompleteSelection()
```

### _toggleFindOverlay

```lua
_toggleFindOverlay()
```

### _closeFindOverlay

```lua
_closeFindOverlay()
```

### _toggleFindField

```lua
_toggleFindField()
```

### _editFindFieldText

```lua
_editFindFieldText()
```

### _handleOverlayBackspace

```lua
_handleOverlayBackspace()
```

### _updateFindMatches

```lua
_updateFindMatches()
```

### _selectMatch

```lua
_selectMatch()
```

### _gotoMatch

```lua
_gotoMatch()
```

### _gotoNextMatch

```lua
_gotoNextMatch()
```

### _gotoPreviousMatch

```lua
_gotoPreviousMatch()
```

### _replaceCurrentMatch

```lua
_replaceCurrentMatch()
```

### _replaceAll

```lua
_replaceAll()
```

### _handleEscape

```lua
_handleEscape()
```

### _handleKey

```lua
_handleKey()
```

### draw

```lua
draw()
```

### handleEvent

```lua
handleEvent()
```

### setText

```lua
setText()
```

### getText

```lua
getText()
```

### setOnChange

```lua
setOnChange()
```

## Examples

<!-- Example tabs -->
<details open>
<summary><strong>Basic</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Simple text input
local textbox = app:textbox({
    x = 2, y = 2,
    width = 20, height = 1,
    placeholder = "Enter text...",
    onChange = function(self, text)
        -- Handle text changes
    end
})
app.root:addChild(textbox)

app:run()
```

</details>

<details>
<summary><strong>Advanced</strong></summary>

```lua
local pixelui = require("pixelui")
local app = pixelui.app()

-- Password input with validation
local passwordBox = app:textbox({
    x = 2, y = 2,
    width = 25, height = 1,
    placeholder = "Enter password",
    mask = "*",
    maxLength = 20,
    focusBg = colors.gray,
    focusFg = colors.white
})

local strengthLabel = app:label({
    x = 2, y = 4,
    text = "",
    fg = colors.lightGray
})

passwordBox.onChange = function(self, text)
    local len = #text
    if len == 0 then
        strengthLabel:setText("")
    elseif len < 6 then
        strengthLabel:setText("Weak")
        strengthLabel.fg = colors.red
    elseif len < 10 then
        strengthLabel:setText("Medium")
        strengthLabel.fg = colors.yellow
    else
        strengthLabel:setText("Strong")
        strengthLabel.fg = colors.green
    end
end

passwordBox.onSubmit = function(self, text)
    -- Handle form submission
end

app.root:addChild(passwordBox)
app.root:addChild(strengthLabel)

app:run()
```

</details>

