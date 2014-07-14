let _function = macro {
  case {
    _ $name:ident ($arg:ident ...) $rest:ident { $body ... }
  } => {
    var args = #{$arg ...};
    var numArgs = args.length;

    // use rest's lexical scope for new values
    var stx = #{$rest};

    letstx $numArgsStx = [makeValue(numArgs, stx)]

    var name = #{$name};
    var functionHasName = (name[0].token.value !== 'anonymous');
    letstx $nameStx = functionHasName ? name : null;

    return #{
      function $nameStx ($arg (,) ..., $rest) {
        $rest = [].slice.call(arguments, $numArgsStx, arguments.length);
        $body ...
      }
    };
  }
}

let function = macro {
  case {
    _ $name:ident ($arg:ident (,) ... $[...] $rest:ident) { $body ... }
  } => {
    return #{ _function $name ($arg ...) $rest { $body ... } };
  }

  case {
    _ ($arg:ident (,) ... $[...] $rest:ident) { $body ... }
  } => {
    return #{ _function anonymous ($arg ...) $rest { $body ... } };
  }
}

export function;
