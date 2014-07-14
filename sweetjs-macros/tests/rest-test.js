function name (one, ...alt) {
  console.log(alt);
}
name(1, 2, 3, 4, 5);

(function (one, two, ...alt) {
  console.log(alt);
}).call(null, 1, 2, 3, 4, 5);

var f = function (one = 2, two, three, ...alt) {
  console.log(one);
  console.log(alt);
};
f(1, 2, 3, 4, 5);
