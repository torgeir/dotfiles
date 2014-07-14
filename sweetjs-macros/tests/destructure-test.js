var [a, b] = [1, 2];

var { name } = { name: "torgeir", age: 30 };
console.log(name);

var [{ handles: { twitter } }] = [{ name: "torgeir", age: 30, handles: { "twitter": "@torgeir" } }];
console.log(twitter);
