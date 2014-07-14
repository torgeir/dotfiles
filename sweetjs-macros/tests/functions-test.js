a = (a, b = 42) => console.log(a, b);
a(1);

aa = (a, b = 42, ...rest) => console.log(a, b, rest);
aa(1, undefined, 5, 6, 7);

b = (a, b = 666) => {
  console.log(a, b);
};
b(2);

bb = (a, b = 666, ...rest) => {
  console.log(rest);
};
bb(2, undefined, 5, 6, 7);

function c (a, b = 1337) {
  console.log(a, b);
}
c(3);

var d = function (a, b = 4096) {
  console.log(a, b);
}
d(4);

var e = function (a, b = 4096, ...rest) {
  console.log(rest);
}
e(4, undefined, 5, 6, 7);
