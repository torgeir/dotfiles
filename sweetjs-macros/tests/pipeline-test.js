curry = require('./macro-includes').curry;

var arr = [1, 2, 3];

var map = (arr, fn) => {
  var ret = [];
  arr.forEach(el => ret.push(fn(el)));
  return ret;
};

var flip = fn -> a -> b -> fn(b, a);
var mapWith = flip(map);

var add = m => mapWith(n => n + m);
console.log(add(2)(arr)); // [3, 4, 5]

var times = m => mapWith(n => n * m);
console.log(times(2)(arr)); // [2, 4, 6]

var res = arr
  |> add(2)
  |> times(4);

console.log(res); // [ 12, 16, 20 ]
