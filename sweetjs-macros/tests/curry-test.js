curry = function (fn) {
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
}

var add = x -> y -> x + y;
console.log(add(2)(3));
var add5 = add(5);
console.log(add(2)(4));
console.log(add5(2));
console.log(add5(3));
