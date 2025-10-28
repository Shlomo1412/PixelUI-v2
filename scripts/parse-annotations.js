#!/usr/bin/env node

/**
 * Parser for Lua LuaDoc-style annotations
 * Extracts classes, fields, functions, and their documentation from pixelui.lua
 */

const fs = require('fs');
const path = require('path');

class AnnotationParser {
  constructor(content) {
    this.content = content;
    this.lines = content.split('\n');
    this.classes = new Map();
    this.functions = [];
    this.aliases = [];
    this.currentLineIndex = 0;
  }

  parse() {
    for (let i = 0; i < this.lines.length; i++) {
      const line = this.lines[i];
      
      // Check for class definition
      if (line.match(/^---@class\s+/)) {
        this.parseClass(i);
      }
      // Check for alias definition
      else if (line.match(/^---@alias\s+/)) {
        this.parseAlias(i);
      }
      // Check for function with annotations
      else if (line.match(/^function\s+(pixelui\.|App:|Frame:|Widget:|Button:|Label:|CheckBox:|Toggle:|TextBox:|ComboBox:|List:|Table:|TreeView:|Chart:|RadioButton:|ProgressBar:|Slider:|NotificationToast:)/)) {
        this.parseFunction(i);
      }
    }

    return {
      classes: Array.from(this.classes.values()),
      functions: this.functions,
      aliases: this.aliases
    };
  }

  parseClass(startIndex) {
    const classLine = this.lines[startIndex];
    const match = classLine.match(/^---@class\s+([\w.]+)(?:\s*:\s*([\w.]+))?/);
    if (!match) return;

    const className = match[1];
    const extends_class = match[2];
    
    const classData = {
      name: className,
      extends: extends_class,
      description: '',
      fields: []
    };

    // Look backwards for description comments
    let descLines = [];
    let j = startIndex - 1;
    while (j >= 0 && this.lines[j].startsWith('---')) {
      const line = this.lines[j];
      if (!line.match(/^---@/)) {
        const desc = line.substring(3).trim();
        if (desc) {
          descLines.unshift(desc);
        }
      } else {
        break;
      }
      j--;
    }
    classData.description = descLines.join(' ');

    // Parse fields that follow
    let i = startIndex + 1;
    while (i < this.lines.length) {
      const line = this.lines[i];
      
      if (line.match(/^---@field\s+/)) {
        const field = this.parseField(line);
        if (field) {
          classData.fields.push(field);
        }
      } else if (!line.startsWith('---')) {
        break;
      }
      i++;
    }

    this.classes.set(className, classData);
  }

  parseField(line) {
    const match = line.match(/^---@field\s+(\w+)\s+([^\s#]+)(?:\s*#\s*(.+))?/);
    if (!match) return null;

    return {
      name: match[1],
      type: match[2],
      description: match[3] ? match[3].trim() : ''
    };
  }

  parseAlias(startIndex) {
    const line = this.lines[startIndex];
    const match = line.match(/^---@alias\s+([\w.]+)\s+(.+)/);
    if (!match) return;

    this.aliases.push({
      name: match[1],
      type: match[2].trim()
    });
  }

  parseFunction(startIndex) {
    // Look backwards for annotations
    let annotationStart = startIndex - 1;
    while (annotationStart >= 0 && this.lines[annotationStart].startsWith('---')) {
      annotationStart--;
    }
    annotationStart++;

    const functionLine = this.lines[startIndex];
    const funcMatch = functionLine.match(/^function\s+([\w.:]+)\(([^)]*)\)/);
    if (!funcMatch) return;

    const functionName = funcMatch[1];
    const params = funcMatch[2].split(',').map(p => p.trim()).filter(p => p);

    const funcData = {
      name: functionName,
      params: [],
      returns: [],
      description: '',
      since: ''
    };

    // Parse annotations
    for (let i = annotationStart; i < startIndex; i++) {
      const line = this.lines[i];
      
      if (line.match(/^---@param\s+/)) {
        const paramMatch = line.match(/^---@param\s+(\w+)\s+([^\s]+)(?:\s+(.+))?/);
        if (paramMatch) {
          funcData.params.push({
            name: paramMatch[1],
            type: paramMatch[2],
            description: paramMatch[3] ? paramMatch[3].trim() : ''
          });
        }
      } else if (line.match(/^---@return\s+/)) {
        const returnMatch = line.match(/^---@return\s+([^\s]+)(?:\s+(.+))?/);
        if (returnMatch) {
          funcData.returns.push({
            type: returnMatch[1],
            description: returnMatch[2] ? returnMatch[2].trim() : ''
          });
        }
      } else if (line.match(/^---@since\s+/)) {
        const sinceMatch = line.match(/^---@since\s+(.+)/);
        if (sinceMatch) {
          funcData.since = sinceMatch[1].trim();
        }
      } else if (line.startsWith('---') && !line.startsWith('---@')) {
        const desc = line.substring(3).trim();
        if (desc) {
          funcData.description += (funcData.description ? ' ' : '') + desc;
        }
      }
    }

    this.functions.push(funcData);
  }
}

function main() {
  const pixeluiPath = path.join(__dirname, '..', 'pixelui.lua');
  const content = fs.readFileSync(pixeluiPath, 'utf8');
  
  const parser = new AnnotationParser(content);
  const result = parser.parse();
  
  // Output as JSON
  console.log(JSON.stringify(result, null, 2));
}

if (require.main === module) {
  main();
}

module.exports = AnnotationParser;
