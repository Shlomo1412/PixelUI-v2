import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'PixelUI',
  description: 'A modern UI framework for ComputerCraft',
  base: '/PixelUI-v2/',
  
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'API Reference', link: '/api' },
      { text: 'GitHub', link: 'https://github.com/Shlomo1412/PixelUI-v2' }
    ],

    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'Getting Started', link: '/' },
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'API Documentation', link: '/api' },
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
