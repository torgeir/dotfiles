// http://www.gnab.org/#!/writings/2014-03-27-sweet-javascript-macros
macro (?.) {
  rule infix { $lhs|$rhs } => {
    ($lhs !== null && $lhs !== undefined
     ? $lhs.$rhs
     : undefined)
  }
}

export (?.);
