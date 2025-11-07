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

### onFocusChanged

```lua
onFocusChanged()
```

### _applyMaxLength

```lua
_applyMaxLength()
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

