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
    $name $args $rest ($arg ...)
  } => {
    var args = #{$arg ...};
    var numArgs = args.length;
    var stx = #{$rest}; // use rest's lexical scope for new values
    letstx $numArgsStx = [makeValue(numArgs, stx)]
    return #{
      $rest = [].slice.call(($args || arguments), $numArgsStx, ($args || arguments).length);
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

  // named functions, with rest
  rule {
    $id ($arg:arg (,) ... $[...] $rest:ident) { $body ...  }
  } => {
    function $id ($arg$name ..., $rest) {
      $($arg$default) (;) ...;
      rest_args arguments $rest ($arg$name ...)
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

  // anonymous functions, with rest
  rule {
    ($arg:arg (,) ... $[...] $rest:ident) { $body ...  }
  } => {
    function ($arg$name ..., $rest) {
      $($arg$default) (;) ...;
      rest_args arguments $rest ($arg$name ...)
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
