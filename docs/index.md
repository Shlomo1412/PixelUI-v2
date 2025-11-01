---
layout: home

hero:
  name: "PixelUI v2"
  text: "A Modern UI Framework"
  tagline: "Build beautiful, responsive user interfaces for ComputerCraft with ease"
  image:
    src: /assets/logo.png
    alt: PixelUI Logo
  actions:
    - theme: brand
      text: 🚀 Get Started
      link: /guides/getting-started
    - theme: alt
      text: 💻 View on GitHub
      link: https://github.com/Shlomo1412/PixelUI-v2

features:
  - icon: 🎨
    title: Rich Widget Library
    details: Comprehensive collection of 15+ pre-built widgets including buttons, labels, checkboxes, toggles, text boxes, lists, tables, charts, sliders, and more.
  
  - icon: 📐
    title: Flexible Layout System
    details: Powerful frame-based layout system with support for borders, positioning, and z-ordering for complex UI hierarchies.
  
  - icon: ✨
    title: Smooth Animations
    details: Built-in animation system with various easing functions to create fluid, responsive user interfaces.
  
  - icon: 🎯
    title: Event Handling
    details: Comprehensive event system with focus management, mouse and keyboard input handling, and intuitive callbacks.
  
  - icon: ⚡
    title: Thread Management
    details: Advanced threading capabilities for background tasks with status tracking, cancellation support, and progress reporting.
  
  - icon: 🔒
    title: Type-Safe
    details: Fully annotated with LuaDoc type hints for better development experience, IDE support, and autocomplete.
---

<!-- ✨ Add Animate.css for beautiful animations -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css/animate.min.css">

<style>
  :root {
    --vp-home-hero-name-color: #74c0fc;
    --vp-home-hero-text-color: #ffffff;
    --vp-c-brand-1: #74c0fc;
  }

  .vp-doc h2 {
    font-size: 1.6rem;
    position: relative;
    display: inline-block;
  }

  .vp-doc h2::after {
    content: "";
    position: absolute;
    bottom: -6px;
    left: 0;
    width: 100%;
    height: 2px;
    background: linear-gradient(to right, #74c0fc, #91a7ff);
    border-radius: 4px;
    animation: glowLine 2s infinite alternate;
  }

  @keyframes glowLine {
    from { opacity: 0.4; }
    to { opacity: 1; }
  }

  .VPHero .image img {
    animation: floatY 4s ease-in-out infinite;
  }

  @keyframes floatY {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
  }

  .VPFeatures .VPFeature {
    opacity: 0;
    transform: translateY(15px);
    animation: fadeUp 0.8s forwards;
  }

  .VPFeatures .VPFeature:nth-child(1) { animation-delay: 0.1s; }
  .VPFeatures .VPFeature:nth-child(2) { animation-delay: 0.2s; }
  .VPFeatures .VPFeature:nth-child(3) { animation-delay: 0.3s; }
  .VPFeatures .VPFeature:nth-child(4) { animation-delay: 0.4s; }
  .VPFeatures .VPFeature:nth-child(5) { animation-delay: 0.5s; }
  .VPFeatures .VPFeature:nth-child(6) { animation-delay: 0.6s; }

  @keyframes fadeUp {
    to { opacity: 1; transform: translateY(0); }
  }

  pre:hover {
    box-shadow: 0 0 15px rgba(116, 192, 252, 0.4);
    transition: box-shadow 0.3s ease;
  }

  h1, h2, h3 {
    text-shadow: 0 0 10px rgba(116, 192, 252, 0.5);
  }

  .vp-doc > * {
    animation: fadeIn 1.2s ease-in;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>

<div class="animate__animated animate__fadeIn animate__slower">
  <h2 align="center">⚡ Quick Start</h2>
</div>

Install PixelUI in your ComputerCraft environment:

```lua
local pixelui = require("pixelui")

-- Create an app instance
local app = pixelui.create()

-- Add widgets to the root frame
local root = app:getRoot()

-- Create a button
local button = app:createButton({
  parent = root,
  x = 5,
  y = 5,
  width = 20,
  height = 3,
  label = "Click Me!",
  onClick = function()
    print("Button clicked!")
  end
})

-- Run the app
app:run()
```

---

<div align="center" class="animate__animated animate__fadeInUp animate__delay-1s">
  <h2>🎨 Features Overview</h2>
</div>

### Widgets

PixelUI provides a comprehensive set of widgets:

- **Button** - Clickable buttons with press effects  
- **Label** - Text display with alignment and wrapping  
- **CheckBox** - Checkbox with optional indeterminate state  
- **Toggle** - On/off toggle switches  
- **TextBox** - Single and multi-line text input  
- **ComboBox** - Dropdown selection  
- **List** - Scrollable list selection  
- **Table** - Data table with sorting and selection  
- **TreeView** - Hierarchical tree display  
- **Chart** - Bar and line charts for data visualization  
- **RadioButton** - Radio button groups for exclusive selection  
- **ProgressBar** - Progress indicators with optional labels  
- **Slider** - Value sliders with range support  
- **NotificationToast** - Temporary notification messages  

---

### ✨ Animation System

Create smooth animations with built-in easing functions:

```lua
app:animate({
  duration = 1.0,
  easing = "easeOutQuad",
  update = function(progress)
    widget.x = startX + (endX - startX) * progress
  end,
  onComplete = function()
    print("Animation complete!")
  end
})
```

---

### ⚙️ Threading

Run background tasks without blocking the UI:

```lua
local handle = app:spawnThread(function(ctx)
  for i = 1, 100 do
    ctx:setProgress(i / 100)
    ctx:sleep(0.1)
    ctx:checkCancelled()
  end
  return "Task complete!"
end, { name = "Background Task" })
```

---

## 🌟 About This Project

<div class="animate__animated animate__fadeInUp animate__slow">
PixelUI v2 is a complete rewrite of the original PixelUI framework, designed to provide a modern, feature-rich UI framework for ComputerCraft.  
Building on the lessons learned from v1, this version offers improved performance, better type safety, and a more comprehensive widget collection.
</div>

### 🔗 Links

- **[GitHub Repository](https://github.com/Shlomo1412/PixelUI-v2)** – Current version (v2)  
- **[PixelUI v1 (Archived)](https://github.com/Shlomo1412/PixelUI)** – Original version  

### 📚 Documentation

For detailed API documentation, see the [API Reference](/api).

---

## 💎 License

PixelUI is released under the **MIT License**.
