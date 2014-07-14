// macroclass arg {
//   pattern {
//     rule { $name:ident = $val:expr }
//     with $default = #{$name = $name === undefined ? $val : $name}
//   }
//   pattern {
//     rule { $name:ident }
//     with $default = []
//   }
// }

// let function = macro {
//   rule { $id($args:arg (,) ...) { $body ... } } => {
//     function $id($args$name ...) {
//       $($args$default) (;) ...;
//       $body ...
//     }
//   }
// }

// function foo(x, y ,z=10) {
//   return 5;
// }
