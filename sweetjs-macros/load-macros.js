#!/usr/bin/env node
var sweetjs = require('sweet.js');
var fs      = require('fs');

var MACROS_FOLDER = '.';
var prefixMacrosFolder = function (macro) { return MACROS_FOLDER + "/" + macro; };
var isMacro = function (filename) { return filename.indexOf('.sjs') !== -1; };

var modules = fs
  .readdirSync(MACROS_FOLDER)
  .filter(isMacro)
  .map(prefixMacrosFolder);

// ripped out of /Users/torgeir/.nvm/v0.10.28/lib/node_modules/sweet.js/lib/sjs.js
var options = {
  readableNames: true,
  escodegen: { format: { indent: { style: Array(2 + 1).join(' ') } } },
  modules: modules.map(function (path) {
    return sweetjs.loadNodeModule(__dirname, path);
  })
};

var code = fs.readFileSync('/dev/stdin', 'utf-8').toString();
// console.log(code);

var compiled = sweetjs.compile(code, options);

// show compiled code
// console.log(compiled.code);

// run compiled code
eval(compiled.code);
