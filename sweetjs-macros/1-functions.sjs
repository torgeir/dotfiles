macroclass arg {
  pattern {
    rule { $name:ident = $val:expr }
    with $default = #{$name = $name === undefined ? $val : $name}
  }
  pattern {
    rule { $name:ident }
    with $default = []
  }
}

// handle ...rest args
// NB differs from the fat-arrow-one
macro rest_args {
  case {
    $name $rest ($arg ...)
  } => {
    var args = #{$arg ...};
    var numArgs = args.length;
    var stx = #{$rest}; // use rest's lexical scope for new values
    letstx $numArgsStx = [makeValue(numArgs, stx)]
    return #{
      $rest = [].slice.call(arguments, $numArgsStx, arguments.length);
    };
  }
}

let function = macro {

  // named functions without arguments
  rule {
    $id () { $body ... }
  } => {
    function $id () { $body ... }
  }

  // anonymous functions without arguments
  rule {
    () { $body ... }
  } => {
    function () { $body ... }
  }

  // named function, only rest
  rule {
    $id ($[...] $rest:ident) { $body ...  }
  } => {
    function $id ($rest) {
      rest_args $rest ()
      $body ...
    }
  }

  // named functions, with rest
  rule {
    $id ($arg:arg (,) ... $[...] $rest:ident) { $body ...  }
  } => {
    function $id ($arg$name ..., $rest) {
      $($arg$default) (;) ...;
      rest_args $rest ($arg$name ...)
      $body ...
    }
  }

  // named functions
  rule {
    $id ($arg:arg (,) ...) { $body ...  }
  } => {
    function $id ($arg$name ...) {
      $($arg$default) (;) ...;
      $body ...
    }
  }

  // anonymous functions, only rest
  rule {
    ($[...] $rest:ident) { $body ...  }
  } => {
    function ($rest) {
      rest_args $rest ()
      $body ...
    }
  }

  // anonymous functions, with rest
  rule {
    ($arg:arg (,) ... $[...] $rest:ident) { $body ...  }
  } => {
    function ($arg$name ..., $rest) {
      $($arg$default) (;) ...;
      rest_args $rest ($arg$name ...)
      $body ...
    }
  }

  // anonymous functions
  rule {
    ($arg:arg (,) ...) { $body ...  }
  } => {
    function ($arg$name ...) {
      $($arg$default) (;) ...;
      $body ...
    }
  }
}

export function;