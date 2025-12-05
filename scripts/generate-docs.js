#!/usr/bin/env node

/**
 * Generate markdown documentation from parsed annotations
 */

const fs = require('fs');
const path = require('path');
const AnnotationParser = require('./parse-annotations');

function escapeMarkdown(text) {
  if (!text) return '';
  return text
    .replace(/\\/g, '\\\\')
    .replace(/\|/g, '\\|')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function formatType(type) {
  if (!type) return '';
  return `\`${escapeMarkdown(type)}\``;
}

function ensureDir(dirPath) {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

function generateClassDoc(cls, functions) {
  let markdown = `# ${cls.name}\n\n`;
  
  if (cls.extends) {
    markdown += `*Extends: ${cls.extends}*\n\n`;
  }

  if (cls.description) {
    markdown += `${cls.description}\n\n`;
  }

  // Fields section
  if (cls.fields.length > 0) {
    markdown += '## Properties\n\n';
    markdown += '| Name | Type | Description |\n';
    markdown += '|------|------|-------------|\n';
    
    for (const field of cls.fields) {
      const name = escapeMarkdown(field.name);
      const type = formatType(field.type);
      const desc = escapeMarkdown(field.description);
      markdown += `| ${name} | ${type} | ${desc} |\n`;
    }
    markdown += '\n';
  }

  // Methods section
  const classMethods = functions.filter(f => {
    const simpleName = cls.name.replace('PixelUI.', '');
    return f.name.startsWith(`${simpleName}:`) || f.name.startsWith(`${cls.name}:`);
  });

  if (classMethods.length > 0) {
    markdown += '## Methods\n\n';

    for (const func of classMethods) {
      const funcName = func.name.split(/[.:]/).pop();
      markdown += `### ${funcName}\n\n`;

      if (func.description) {
        markdown += `${func.description}\n\n`;
      }

      if (func.since) {
        markdown += `*Since: ${func.since}*\n\n`;
      }

      markdown += '```lua\n';
      const paramStr = func.params.map(p => p.name).join(', ');
      markdown += `${func.name.split(/[.:]/).pop()}(${paramStr})\n`;
      markdown += '```\n\n';

      if (func.params.length > 0) {
        markdown += '**Parameters:**\n\n';
        markdown += '| Name | Type | Description |\n';
        markdown += '|------|------|-------------|\n';
        
        for (const param of func.params) {
          const name = escapeMarkdown(param.name);
          const type = formatType(param.type);
          const desc = escapeMarkdown(param.description);
          markdown += `| ${name} | ${type} | ${desc} |\n`;
        }
        markdown += '\n';
      }

      if (func.returns.length > 0) {
        markdown += '**Returns:**\n\n';
        for (const ret of func.returns) {
          const type = formatType(ret.type);
          const desc = escapeMarkdown(ret.description);
          markdown += `- ${type}`;
          if (desc) {
            markdown += ` - ${desc}`;
          }
          markdown += '\n';
        }
        markdown += '\n';
      }
    }
  }

  // Examples section with Basic/Advanced tabs
  if (cls.examples && (cls.examples.basic.length > 0 || cls.examples.advanced.length > 0)) {
    markdown += '## Examples\n\n';
    
    const hasBasic = cls.examples.basic.length > 0;
    const hasAdvanced = cls.examples.advanced.length > 0;
    
    if (hasBasic && hasAdvanced) {
      // Both tabs available - use tabbed layout with HTML details/summary for compatibility
      markdown += '<!-- Example tabs -->\n';
      markdown += '<details open>\n';
      markdown += '<summary><strong>Basic</strong></summary>\n\n';
      for (const example of cls.examples.basic) {
        markdown += '```lua\n';
        markdown += example + '\n';
        markdown += '```\n\n';
      }
      markdown += '</details>\n\n';
      
      markdown += '<details>\n';
      markdown += '<summary><strong>Advanced</strong></summary>\n\n';
      for (const example of cls.examples.advanced) {
        markdown += '```lua\n';
        markdown += example + '\n';
        markdown += '```\n\n';
      }
      markdown += '</details>\n\n';
    } else if (hasBasic) {
      // Only basic examples
      markdown += '### Basic Usage\n\n';
      for (const example of cls.examples.basic) {
        markdown += '```lua\n';
        markdown += example + '\n';
        markdown += '```\n\n';
      }
    } else if (hasAdvanced) {
      // Only advanced examples
      markdown += '### Advanced Usage\n\n';
      for (const example of cls.examples.advanced) {
        markdown += '```lua\n';
        markdown += example + '\n';
        markdown += '```\n\n';
      }
    }
  }

  return markdown;
}

function generateIndexPage(categories) {
  let markdown = '# API Reference\n\n';
  markdown += 'Browse the complete API documentation for PixelUI v2.\n\n';

  for (const [category, items] of Object.entries(categories)) {
    if (items.length === 0) continue;
    
    markdown += `## ${category}\n\n`;
    
    for (const item of items) {
      const link = item.link || `/api/${item.name.toLowerCase().replace('pixelui.', '')}`;
      markdown += `- [${item.name}](${link})`;
      if (item.description) {
        markdown += ` - ${item.description}`;
      }
      markdown += '\n';
    }
    markdown += '\n';
  }

  return markdown;
}


function main() {
  const pixeluiPath = path.join(__dirname, '..', 'pixelui.lua');
  const content = fs.readFileSync(pixeluiPath, 'utf8');
  
  const parser = new AnnotationParser(content);
  const result = parser.parse();
  
  const docsDir = path.join(__dirname, '..', 'docs');
  const apiDir = path.join(docsDir, 'api');
  
  ensureDir(docsDir);
  ensureDir(apiDir);

  // Organize classes by category
  const categories = {
    'Core': [],
    'Widgets': [],
    'Configuration': [],
    'Types': []
  };

  const coreClasses = ['PixelUI.App', 'PixelUI.Widget', 'PixelUI.Frame'];
  
  for (const cls of result.classes) {
    if (coreClasses.includes(cls.name)) {
      categories.Core.push(cls);
    } else if (cls.name.includes('Options') || cls.name.includes('Config')) {
      categories.Configuration.push(cls);
    } else if (cls.name.includes('Handle') || cls.name.includes('Context') || cls.name.includes('Status') || cls.name.includes('Node') || cls.name.includes('Column') || cls.name.includes('Constraint') || cls.name === 'PixelUI.TabControlTab') {
      categories.Types.push(cls);
    } else {
      categories.Widgets.push(cls);
    }
  }

  // Generate individual pages for each widget and core class
  const widgetsToGenerate = [...categories.Core, ...categories.Widgets];
  
  for (const cls of widgetsToGenerate) {
    const simpleName = cls.name.replace('PixelUI.', '').toLowerCase();
    const markdown = generateClassDoc(cls, result.functions);
    const filePath = path.join(apiDir, `${simpleName}.md`);
    fs.writeFileSync(filePath, markdown, 'utf8');
    console.log(`Generated ${filePath}`);
  }

  // Generate configuration and types pages
  let configMarkdown = '# Configuration\n\n';
  configMarkdown += 'Configuration options for PixelUI components.\n\n';
  for (const cls of categories.Configuration) {
    configMarkdown += `## ${cls.name}\n\n`;
    if (cls.description) {
      configMarkdown += `${cls.description}\n\n`;
    }
    if (cls.fields.length > 0) {
      configMarkdown += '| Name | Type | Description |\n';
      configMarkdown += '|------|------|-------------|\n';
      for (const field of cls.fields) {
        const name = escapeMarkdown(field.name);
        const type = formatType(field.type);
        const desc = escapeMarkdown(field.description);
        configMarkdown += `| ${name} | ${type} | ${desc} |\n`;
      }
      configMarkdown += '\n';
    }
  }
  fs.writeFileSync(path.join(apiDir, 'configuration.md'), configMarkdown, 'utf8');

  let typesMarkdown = '# Types and Utilities\n\n';
  typesMarkdown += 'Type definitions and utility types used in PixelUI.\n\n';
  for (const cls of categories.Types) {
    typesMarkdown += `## ${cls.name}\n\n`;
    if (cls.description) {
      typesMarkdown += `${cls.description}\n\n`;
    }
    if (cls.fields.length > 0) {
      typesMarkdown += '| Name | Type | Description |\n';
      typesMarkdown += '|------|------|-------------|\n';
      for (const field of cls.fields) {
        const name = escapeMarkdown(field.name);
        const type = formatType(field.type);
        const desc = escapeMarkdown(field.description);
        typesMarkdown += `| ${name} | ${type} | ${desc} |\n`;
      }
      typesMarkdown += '\n';
    }
  }
  
  // Add type aliases
  if (result.aliases.length > 0) {
    typesMarkdown += '## Type Aliases\n\n';
    typesMarkdown += '| Name | Type |\n';
    typesMarkdown += '|------|------|\n';
    for (const alias of result.aliases) {
      const name = escapeMarkdown(alias.name);
      const type = formatType(alias.type);
      typesMarkdown += `| ${name} | ${type} |\n`;
    }
    typesMarkdown += '\n';
  }
  
  fs.writeFileSync(path.join(apiDir, 'types.md'), typesMarkdown, 'utf8');

  // Generate index page with links to all pages
  const indexCategories = {
    'Core Classes': categories.Core.map(cls => ({
      name: cls.name,
      link: `/api/${cls.name.replace('PixelUI.', '').toLowerCase()}`,
      description: cls.description || ''
    })),
    'Widgets': categories.Widgets.map(cls => ({
      name: cls.name,
      link: `/api/${cls.name.replace('PixelUI.', '').toLowerCase()}`,
      description: cls.description || ''
    })),
    'Configuration': [{ name: 'Configuration Options', link: '/api/configuration' }],
    'Types': [{ name: 'Types and Utilities', link: '/api/types' }]
  };
  
  const indexMarkdown = generateIndexPage(indexCategories);
  fs.writeFileSync(path.join(docsDir, 'api.md'), indexMarkdown, 'utf8');
  
  console.log(`\nDocumentation generated successfully!`);
  console.log(`- ${result.classes.length} classes`);
  console.log(`- ${result.functions.length} functions`);
  console.log(`- ${result.aliases.length} type aliases`);
  console.log(`- ${widgetsToGenerate.length} individual widget/class pages`);
}

if (require.main === module) {
  main();
}

module.exports = {
  generateClassDoc,
  generateIndexPage
};
