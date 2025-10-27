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
    .replace(/\|/g, '\\|')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function formatType(type) {
  if (!type) return '';
  return `\`${escapeMarkdown(type)}\``;
}

function generateClassDocs(classes) {
  let markdown = '# API Reference\n\n';
  markdown += '## Classes\n\n';

  // Organize classes by category
  const categories = {
    'Core': ['PixelUI.App', 'PixelUI.Widget', 'PixelUI.Frame'],
    'Widgets': [],
    'Configuration': [],
    'Types': []
  };

  for (const cls of classes) {
    if (categories.Core.includes(cls.name)) continue;
    
    if (cls.name.includes('Options') || cls.name.includes('Config')) {
      categories.Configuration.push(cls.name);
    } else if (cls.name.includes('Handle') || cls.name.includes('Context') || cls.name.includes('Status')) {
      categories.Types.push(cls.name);
    } else {
      categories.Widgets.push(cls.name);
    }
  }

  // Generate docs for each category
  for (const [category, classNames] of Object.entries(categories)) {
    if (category === 'Core') {
      classNames.push(...categories.Core);
    }
    
    const categoryClasses = classes.filter(cls => classNames.includes(cls.name));
    if (categoryClasses.length === 0) continue;

    markdown += `### ${category}\n\n`;

    for (const cls of categoryClasses) {
      markdown += `#### ${cls.name}\n\n`;
      
      if (cls.extends) {
        markdown += `*Extends: ${cls.extends}*\n\n`;
      }

      if (cls.description) {
        markdown += `${cls.description}\n\n`;
      }

      if (cls.fields.length > 0) {
        markdown += '**Fields:**\n\n';
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
    }
  }

  return markdown;
}

function generateFunctionDocs(functions) {
  let markdown = '## Functions\n\n';

  // Organize functions by object
  const functionsByObject = {};
  
  for (const func of functions) {
    const parts = func.name.split(/[.:]/);
    const objectName = parts.length > 1 ? parts[0] : 'Module';
    
    if (!functionsByObject[objectName]) {
      functionsByObject[objectName] = [];
    }
    functionsByObject[objectName].push(func);
  }

  // Generate docs for each object
  for (const [objectName, funcs] of Object.entries(functionsByObject)) {
    markdown += `### ${objectName}\n\n`;

    for (const func of funcs) {
      const funcName = func.name.split(/[.:]/).pop();
      markdown += `#### ${funcName}\n\n`;

      if (func.description) {
        markdown += `${func.description}\n\n`;
      }

      if (func.since) {
        markdown += `*Since: ${func.since}*\n\n`;
      }

      markdown += '```lua\n';
      const paramStr = func.params.map(p => p.name).join(', ');
      markdown += `${func.name}(${paramStr})\n`;
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

  return markdown;
}

function generateAliasDocs(aliases) {
  if (aliases.length === 0) return '';
  
  let markdown = '## Type Aliases\n\n';
  markdown += '| Name | Type |\n';
  markdown += '|------|------|\n';
  
  for (const alias of aliases) {
    const name = escapeMarkdown(alias.name);
    const type = formatType(alias.type);
    markdown += `| ${name} | ${type} |\n`;
  }
  markdown += '\n';

  return markdown;
}

function main() {
  const pixeluiPath = path.join(__dirname, '..', 'pixelui.lua');
  const content = fs.readFileSync(pixeluiPath, 'utf8');
  
  const parser = new AnnotationParser(content);
  const result = parser.parse();
  
  let markdown = '';
  
  // Generate docs
  markdown += generateClassDocs(result.classes);
  markdown += generateFunctionDocs(result.functions);
  markdown += generateAliasDocs(result.aliases);

  // Write to docs directory
  const docsDir = path.join(__dirname, '..', 'docs');
  if (!fs.existsSync(docsDir)) {
    fs.mkdirSync(docsDir, { recursive: true });
  }

  const apiDocPath = path.join(docsDir, 'api.md');
  fs.writeFileSync(apiDocPath, markdown, 'utf8');
  
  console.log(`Documentation generated at ${apiDocPath}`);
  console.log(`- ${result.classes.length} classes`);
  console.log(`- ${result.functions.length} functions`);
  console.log(`- ${result.aliases.length} type aliases`);
}

if (require.main === module) {
  main();
}

module.exports = {
  generateClassDocs,
  generateFunctionDocs,
  generateAliasDocs
};
