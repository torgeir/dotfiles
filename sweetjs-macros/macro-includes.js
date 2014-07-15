// sweet.js needs this, to not do hygiene
curry = function curry (fn) {
  var numargs = fn.length;
  if (numargs == 1) {
    return fn;
  }

  return createRecurser([]);

  function createRecurser (acc) {
    return function () {
      var args = [].slice.call(arguments);
      return recurse(acc, args);
    };
  }

  function recurse (acc, args) {
    var newacc = acc.concat(args);
    if (newacc.length < numargs) {
      return createRecurser(newacc);
    }
    else {
      return fn.apply(this, newacc);
    }
  }
};

module.exports.curry = global.curry = curry;
