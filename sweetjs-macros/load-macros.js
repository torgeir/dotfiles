#!/usr/bin/env node --harmony-proxies
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

var args = process.argv;

var src;
if (args.indexOf('-s') != -1) {
  src = fs.readFileSync('/dev/stdin', 'utf-8').toString();
}
else {
  src = fs.readFileSync(process.env.HOME + '/tmp/js-macro-from-vim-buffer.js', 'utf-8').toString();
}
var compiled = sweetjs.compile(src, options);
var code = compiled.code;

var showCompiledCode = !!(Number(process.argv[2]));
if (showCompiledCode) {
  console.log(code);
}
else {
  // run compiled code
  var vm = require('vm')
  var script = vm.createScript(code, 'macro-expanded-code-from-vim-buffer.js');
  script.runInNewContext(createContext());
}

function createContext() {
  var ctx = {};
  ctx.console = console;
  ctx.require = require;
  ctx.process = process;
  return ctx;
}
