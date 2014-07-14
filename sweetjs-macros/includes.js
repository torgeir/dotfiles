curry = function curry (fn) {
  var numargs = fn.length;
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
