let function = macro {
  case {
    _ $name:ident ($arg:ident (,) ... $[...] $rest:ident) { $body ... }
  } => {
    var numArgs = (#{$arg (,) ...}).length;
    var numArgsWithoutRest = numArgs - 1;

    var stx = #{$rest};
    letstx $numArgsWithoutRestStx = numArgsWithoutRest
      ? [makeIdent(numArgsWithoutRest, stx)]
      : null;

    return #{
      function ($arg (,) ..., $rest) {
        $rest = [].slice.call(arguments, $numArgsWithoutRestStx, arguments.length);
        $body ...
      }
    };
  }
}
export function;
