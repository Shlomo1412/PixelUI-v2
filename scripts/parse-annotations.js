#!/usr/bin/env node

/**
 * Parser for Lua annotations in pixelui.lua
 * Extracts @class, @field, @param, @return, @since annotations
 * and generates VitePress markdown documentation
 */

const fs = require('fs');
const path = require('path');

// Parse command line arguments
const args = process.argv.slice(2);
const inputFile = args[0] || path.join(__dirname, '..', 'pixelui.lua');
const outputDir = args[1] || path.join(__dirname, '..', 'docs', 'api');

console.log(`Parsing: ${inputFile}`);
console.log(`Output: ${outputDir}`);

// Read the Lua file
const content = fs.readFileSync(inputFile, 'utf-8');
const lines = content.split('\n');

// Data structures to hold parsed information
const classes = new Map();
const functions = [];
const aliases = new Map();

let currentClass = null;
let currentAnnotations = [];
let currentComments = [];

// Parse the file line by line
for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();

  // Collect annotation lines
  if (trimmed.startsWith('---@')) {
    currentAnnotations.push({
      line: trimmed,
      lineNumber: i + 1
    });
    continue;
  }

  // If we have annotations, process them
  if (currentAnnotations.length > 0) {
    // Check if next line is a function or class definition
    const nextLine = trimmed;

    // Parse @alias
    const aliasMatch = currentAnnotations.find(a => a.line.match(/^---@alias\s+(\S+)\s+(.+)/));
    if (aliasMatch) {
      const match = aliasMatch.line.match(/^---@alias\s+(\S+)\s+(.+)/);
      if (match) {
        aliases.set(match[1], {
          name: match[1],
          type: match[2]
        });
      }
      currentAnnotations = [];
      continue;
    }

    // Parse @class
    const classMatch = currentAnnotations.find(a => a.line.match(/^---@class\s+(\S+)/));
    if (classMatch) {
      const match = classMatch.line.match(/^---@class\s+(\S+)(?:\s*:\s*(\S+))?/);
      if (match) {
        const className = match[1];
        const baseClass = match[2];
        
        currentClass = {
          name: className,
          baseClass: baseClass,
          fields: [],
          methods: [],
          description: []
        };
        
        // Parse fields
        currentAnnotations.forEach(ann => {
          const fieldMatch = ann.line.match(/^---@field\s+(private\s+)?(\S+)\s+(.+?)(?:\s*#\s*(.+))?$/);
          if (fieldMatch) {
            currentClass.fields.push({
              private: !!fieldMatch[1],
              name: fieldMatch[2],
              type: fieldMatch[3],
              description: fieldMatch[4] || ''
            });
          }
        });

        classes.set(className, currentClass);
      }
      currentAnnotations = [];
      continue;
    }

    // Parse function documentation
    const funcMatch = nextLine.match(/^(?:local\s+)?function\s+([A-Za-z_][A-Za-z0-9_.:]*)/);
    if (funcMatch || nextLine.match(/^pixelui\./)) {
      const funcName = funcMatch ? funcMatch[1] : nextLine.match(/^pixelui\.(\w+)/)?.[1];
      
      if (funcName) {
        const funcDoc = {
          name: funcName,
          params: [],
          returns: [],
          since: null,
          description: []
        };

        // Parse all annotation types
        currentAnnotations.forEach(ann => {
          const paramMatch = ann.line.match(/^---@param\s+(\S+)\s+(.+?)(?:\s+#\s+(.+))?$/);
          if (paramMatch) {
            funcDoc.params.push({
              name: paramMatch[1],
              type: paramMatch[2],
              description: paramMatch[3] || ''
            });
          }

          const returnMatch = ann.line.match(/^---@return\s+(.+?)(?:\s+(\S+))?(?:\s+#\s+(.+))?$/);
          if (returnMatch) {
            funcDoc.returns.push({
              type: returnMatch[1],
              name: returnMatch[2] || '',
              description: returnMatch[3] || ''
            });
          }

          const sinceMatch = ann.line.match(/^---@since\s+(.+)/);
          if (sinceMatch) {
            funcDoc.since = sinceMatch[1];
          }
        });

        // Associate function with class if it's a method
        const methodMatch = funcName.match(/^([A-Z][A-Za-z0-9_]+):(.+)/);
        if (methodMatch) {
          const className = methodMatch[1];
          const methodName = methodMatch[2];
          const classObj = classes.get(`PixelUI.${className}`);
          if (classObj) {
            classObj.methods.push({
              ...funcDoc,
              name: methodName
            });
          }
        } else if (funcName.startsWith('pixelui.')) {
          functions.push(funcDoc);
        } else {
          functions.push(funcDoc);
        }
      }
    }

    currentAnnotations = [];
  }
}

// Generate markdown documentation
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

// Generate index page
let indexContent = `# API Reference

PixelUI v${getVersion()} API Documentation

## Main API

`;

// Add main functions
if (functions.length > 0) {
  indexContent += `### Module Functions

`;
  functions.forEach(func => {
    indexContent += `- [\`${func.name}\`](#${func.name.toLowerCase().replace(/\./g, '')})\n`;
  });
  indexContent += '\n';
}

// Add classes
if (classes.size > 0) {
  indexContent += `## Classes

`;
  const classArray = Array.from(classes.values()).sort((a, b) => a.name.localeCompare(b.name));
  classArray.forEach(cls => {
    const safeName = cls.name.replace(/\./g, '-').toLowerCase();
    indexContent += `- [${cls.name}](./${safeName}.md)`;
    if (cls.baseClass) {
      indexContent += ` (extends ${cls.baseClass})`;
    }
    indexContent += '\n';
  });
}

fs.writeFileSync(path.join(outputDir, 'index.md'), indexContent);

// Generate individual class pages
classes.forEach(cls => {
  const safeName = cls.name.replace(/\./g, '-').toLowerCase();
  let classContent = `# ${cls.name}

`;

  if (cls.baseClass) {
    classContent += `Extends: [\`${cls.baseClass}\`](./${cls.baseClass.replace(/\./g, '-').toLowerCase()}.md)\n\n`;
  }

  // Fields
  if (cls.fields.length > 0) {
    classContent += `## Fields

`;
    cls.fields.forEach(field => {
      if (!field.private) {
        classContent += `### ${field.name}

- **Type:** \`${field.type}\`
`;
        if (field.description) {
          classContent += `- **Description:** ${field.description}\n`;
        }
        classContent += '\n';
      }
    });
  }

  // Methods
  if (cls.methods.length > 0) {
    classContent += `## Methods

`;
    cls.methods.forEach(method => {
      classContent += `### ${method.name}

`;
      if (method.since) {
        classContent += `*Since: ${method.since}*\n\n`;
      }

      // Parameters
      if (method.params.length > 0) {
        classContent += `**Parameters:**\n\n`;
        method.params.forEach(param => {
          classContent += `- \`${param.name}\` (\`${param.type}\`)`;
          if (param.description) {
            classContent += ` - ${param.description}`;
          }
          classContent += '\n';
        });
        classContent += '\n';
      }

      // Return values
      if (method.returns.length > 0) {
        classContent += `**Returns:**\n\n`;
        method.returns.forEach(ret => {
          classContent += `- \`${ret.type}\``;
          if (ret.name) {
            classContent += ` ${ret.name}`;
          }
          if (ret.description) {
            classContent += ` - ${ret.description}`;
          }
          classContent += '\n';
        });
        classContent += '\n';
      }
    });
  }

  fs.writeFileSync(path.join(outputDir, `${safeName}.md`), classContent);
});

// Generate aliases page
if (aliases.size > 0) {
  let aliasContent = `# Type Aliases

`;
  aliases.forEach(alias => {
    aliasContent += `## ${alias.name}

\`\`\`lua
${alias.type}
\`\`\`

`;
  });
  fs.writeFileSync(path.join(outputDir, 'aliases.md'), aliasContent);
}

console.log(`Generated documentation for ${classes.size} classes and ${functions.length} functions`);
console.log(`Output written to ${outputDir}`);

function getVersion() {
  const versionMatch = content.match(/version\s*=\s*["']([^"']+)["']/);
  return versionMatch ? versionMatch[1] : '0.1.0';
}
