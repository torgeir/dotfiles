function f (first, one = 1, two = 2) {
  console.log(first, one, two);
}
f(1, 'first-value', 'one-value', 'two-value');
f(2, 'first-value', undefined, 'two-value');
