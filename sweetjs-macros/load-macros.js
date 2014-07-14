#!/usr/bin/env node
var sweetjs = require('sweet.js');
var fs      = require('fs');

var MACROS_FOLDER = process.env.HOME + '/.sweetjs-macros/';
var prefixMacrosFolder = function (macro) { return MACROS_FOLDER + "/" + macro; };
var isMacro = function (filename) { return filename.indexOf('.sjs') !== -1; };
var isNotXed = function (filename) { return filename.indexOf('x-') == -1; };

var modules = fs
  .readdirSync(MACROS_FOLDER)
  .filter(isMacro)
  .filter(isNotXed)
  // .map(function (el) { // log order
  //   console.log(el);
  //   return el;
  // })
  .map(prefixMacrosFolder);

// ripped out of /Users/torgeir/.nvm/v0.10.28/lib/node_modules/sweet.js/lib/sjs.js
var options = {
  readableNames: true,
  escodegen: { format: { indent: { style: Array(2 + 1).join(' ') } } },
  modules: modules.map(function (path) {
    return sweetjs.loadNodeModule(__dirname, path);
  })
};

var src = fs.readFileSync('/dev/stdin', 'utf-8').toString();
var compiled = sweetjs.compile(src, options);
var code = compiled.code;

var showCompiledCode = !!(Number(process.argv[2]));
if (showCompiledCode) {
  console.log(code);
}
else {
  // run compiled code
  var context = { console: console };
  var vm = require('vm');
  vm.runInContext(code, vm.createContext(context));
}
