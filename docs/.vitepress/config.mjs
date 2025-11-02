import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'PixelUI',
  description: 'A modern UI framework for ComputerCraft',
  base: '/',
  
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guides', link: '/guides/getting-started' },
      { text: 'API Reference', link: '/api' },
      { text: 'GitHub', link: 'https://github.com/Shlomo1412/PixelUI-v2' }
    ],

    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'Home', link: '/' },
        ]
      },
      {
        text: 'Guides',
        collapsed: false,
        items: [
          { text: 'Getting Started', link: '/guides/getting-started' },
          { text: 'Animations', link: '/guides/animations' },
          { text: 'Constraints', link: '/guides/constraints' },
          { text: 'FreeDraw Canvas', link: '/guides/freedraw' },
          { text: 'Threading', link: '/guides/threading' },
          { text: 'Monitors', link: '/guides/monitors' },
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'Overview', link: '/api' },
        ]
      },
      {
        text: 'Core Classes',
        collapsed: false,
        items: [
          { text: 'App', link: '/api/app' },
          { text: 'Widget', link: '/api/widget' },
          { text: 'Frame', link: '/api/frame' },
        ]
      },
      {
        text: 'Widgets',
        collapsed: false,
        items: [
          { text: 'Button', link: '/api/button' },
          { text: 'Label', link: '/api/label' },
          { text: 'CheckBox', link: '/api/checkbox' },
          { text: 'Toggle', link: '/api/toggle' },
          { text: 'TextBox', link: '/api/textbox' },
          { text: 'ComboBox', link: '/api/combobox' },
          { text: 'List', link: '/api/list' },
          { text: 'Table', link: '/api/table' },
          { text: 'TreeView', link: '/api/treeview' },
          { text: 'Chart', link: '/api/chart' },
          { text: 'RadioButton', link: '/api/radiobutton' },
          { text: 'ProgressBar', link: '/api/progressbar' },
          { text: 'Slider', link: '/api/slider' },
          { text: 'NotificationToast', link: '/api/notificationtoast' },
          { text: 'LoadingRing', link: '/api/loadingring' },
        ]
      },
      {
        text: 'Reference',
        collapsed: true,
        items: [
          { text: 'Configuration', link: '/api/configuration' },
          { text: 'Types', link: '/api/types' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Shlomo1412/PixelUI-v2' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025-present PixelUI Contributors'
    }
  }
})
