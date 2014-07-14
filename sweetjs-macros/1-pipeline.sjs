// macro for the f-sharp pipeline operator
operator (|>) 1 left { $l, $r } => #{ $r($l) }
export (|>);

// // example
// var add   = m => n => n + m;
// var sub   = m => n => n - m;
// var times = m => n => n * m;
// var div   = m => n => n / m;
//
// var pipe = x => x
//   |> add(2)
//   |> times(2)
//   |> div(2)
//   |> sub(2);
//
// console.log(pipe(2));
