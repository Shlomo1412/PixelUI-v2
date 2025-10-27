import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "PixelUI",
  description: "A modern UI library for ComputerCraft",
  base: '/PixelUI-v2/',
  
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'API Reference', link: '/api/' }
    ],

    sidebar: [
      {
        text: 'Guide',
        items: [
          { text: 'Getting Started', link: '/guide/getting-started' },
          { text: 'Installation', link: '/guide/installation' },
          { text: 'Examples', link: '/guide/examples' }
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'Overview', link: '/api/' },
          { text: 'Type Aliases', link: '/api/aliases' },
          {
            text: 'Core',
            collapsed: false,
            items: [
              { text: 'PixelUI', link: '/api/pixelui' },
              { text: 'App', link: '/api/pixelui-app' },
              { text: 'Widget', link: '/api/pixelui-widget' }
            ]
          },
          {
            text: 'Widgets',
            collapsed: false,
            items: [
              { text: 'Frame', link: '/api/pixelui-frame' },
              { text: 'Button', link: '/api/pixelui-button' },
              { text: 'Label', link: '/api/pixelui-label' },
              { text: 'CheckBox', link: '/api/pixelui-checkbox' },
              { text: 'Toggle', link: '/api/pixelui-toggle' },
              { text: 'TextBox', link: '/api/pixelui-textbox' },
              { text: 'ComboBox', link: '/api/pixelui-combobox' },
              { text: 'RadioButton', link: '/api/pixelui-radiobutton' },
              { text: 'ProgressBar', link: '/api/pixelui-progressbar' },
              { text: 'Slider', link: '/api/pixelui-slider' },
              { text: 'List', link: '/api/pixelui-list' },
              { text: 'Table', link: '/api/pixelui-table' },
              { text: 'TreeView', link: '/api/pixelui-treeview' },
              { text: 'Chart', link: '/api/pixelui-chart' }
            ]
          },
          {
            text: 'Configuration',
            collapsed: true,
            items: [
              { text: 'AppOptions', link: '/api/pixelui-appoptions' },
              { text: 'BorderConfig', link: '/api/pixelui-borderconfig' },
              { text: 'AnimationOptions', link: '/api/pixelui-animationoptions' },
              { text: 'ThreadOptions', link: '/api/pixelui-threadoptions' }
            ]
          },
          {
            text: 'Threading',
            collapsed: true,
            items: [
              { text: 'ThreadHandle', link: '/api/pixelui-threadhandle' },
              { text: 'ThreadContext', link: '/api/pixelui-threadcontext' }
            ]
          }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Shlomo1412/PixelUI-v2' }
    ],

    search: {
      provider: 'local'
    }
  }
})
