# API Reference

Browse the complete API documentation for PixelUI v2.

## Core Classes

- [PixelUI.Widget](/api/widget) - Base class for all UI widgets. Provides common properties and behavior for positioning, sizing, styling, and event handling.
- [PixelUI.App](/api/app) - Main application class managing the UI and event loop. Handles rendering, events, animations, and threading.
- [PixelUI.Frame](/api/frame) - A container widget that can hold child widgets. Serves as the base for layout organization and hierarchy.

## Widgets

- [PixelUI.Window](/api/window) - A floating window widget with an optional title bar and dragging support. Extends Frame by adding chrome controls and layered ordering.
- [PixelUI.Button](/api/button) - A clickable button widget with press effects and event callbacks. Supports click, press, and release events with visual feedback.
- [PixelUI.Label](/api/label) - A text display widget with support for wrapping and alignment. Can display static or dynamic text with customizable alignment options.
- [PixelUI.CheckBox](/api/checkbox) - A checkbox widget with support for checked, unchecked, and indeterminate states. Provides visual feedback and change callbacks.
- [PixelUI.Toggle](/api/toggle) - A toggle switch widget with on/off states and customizable appearance. Features a sliding thumb animation and optional labels.
- [PixelUI.Chart](/api/chart) - A data visualization widget supporting bar and line charts. Displays numeric data with optional labels and interactive selection.
- [PixelUI.ProgressBar](/api/progressbar) - A progress indicator widget showing completion status. Supports determinate and indeterminate modes with optional labels.
- [PixelUI.NotificationToast](/api/notificationtoast) - A notification toast widget for displaying temporary messages. Supports different severity levels and auto-hide functionality.
- [PixelUI.LoadingRing](/api/loadingring) - An animated loading ring indicator widget. Displays a rotating segmented ring for loading states.
- [PixelUI.FreeDraw](/api/freedraw) - A raw drawing surface that exposes ShrekBox layers for custom rendering. Useful for advanced visualisations or integrating bespoke ASCII art.
- [PixelUI.Slider](/api/slider) - A slider widget for selecting numeric values within a range. Supports single value or range selection mode.
- [PixelUI.TreeView](/api/treeview) - A hierarchical tree view widget for displaying nested data. Supports expand/collapse and selection of nodes.
- [PixelUI.List](/api/list) - A scrollable list widget for displaying and selecting items. Supports keyboard and mouse navigation.
- [PixelUI.RadioButton](/api/radiobutton) - A radio button widget for exclusive selection within a group. Only one radio button in a group can be selected at a time.
- [PixelUI.ComboBox](/api/combobox) - A dropdown selection widget (combo box) for choosing from a list of options. Opens a dropdown menu when clicked.
- [PixelUI.TabControl](/api/tabcontrol) - A tabbed navigation widget with an optional body renderer. Renders a strip of selectable tabs and a content area beneath them.
- [PixelUI.TextBox](/api/textbox) - A text input widget supporting single and multi-line input. Features syntax highlighting, autocomplete, and find/replace.
- [PixelUI.Table](/api/table) - A data table widget with sorting and selection capabilities. Displays tabular data with customizable columns and row selection.

## Configuration

- [Configuration Options](/api/configuration)

## Types

- [Types and Utilities](/api/types)

