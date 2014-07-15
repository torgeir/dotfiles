curry = require('./macro-includes').curry;

var add = x -> y -> x + y;
console.log(add(2)(3));

var add5 = add(5);
console.log(add(2)(4));
console.log(add5(2));
console.log(add5(3));
