class Vehicle {}

class Car extends Vehicle {
  constructor(color) {
    this.color = color;
  }
}

class WithNodes {
  constructor (nodes) {
    if (nodes.length) {
      this.nodes = nodes;
    }
  }
}

class Tree extends WithNodes {
  constructor (value) {
    super([].slice.call(arguments, 1));
    this.value = value;
  }
}

console.log(
  Tree(1,
    Tree(11),
    Tree(12,
      Tree(123))));
