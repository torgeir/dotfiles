// handle ...rest args
macro rest_args {
  case {
    $name $args $rest ($arg ...)
  } => {
    var args = #{$arg ...};
    var numArgs = args.length + 1; // 1 is __fa_args
    var stx = #{$rest}; // use rest's lexical scope for new values
    letstx $numArgsStx = [makeValue(numArgs, stx)]
    return #{
      $rest = [].slice.call(($args || arguments), $numArgsStx, ($args|| arguments).length);
    };
  }
}

// handle already existing arguments in context?
macro bind_args {
  case {
    $ctx $args ($body ...)
  } => {
    var stx = #{$body ...};
    var args = #{$args};

    function walk(stx) {
      for(var i=0; i<stx.length; i++) {
        var s = stx[i];
        if(s.token.type === parser.Token.Delimiter) {
          walk(s.token.inner);
        }
        else if(s.token.value === 'function') {
          var expr = getExpr(stx.slice(i));
          walk(expr.rest);
          break;
        }
        else if(s.token.type === parser.Token.Identifier &&
                s.token.value === 'arguments' &&
                (i === 0 || stx[i-1].token.value !== '.')) {
          s.token.value = '__fa_args';
        }
      }
    }

    walk(stx);
    return stx;
  }
}

// arg class for handling parameter default values
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

macro => {

  // (a, b, ...rest) => { return rest }
  case infix { ($arg:arg (,) ... $[...] $rest:ident) | $ctx { $body ... } } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg$name (,) ..., $rest) {
        $($arg$default) (;) ...
        rest_args $args $rest ($arg$name ...)
        bind_args $args ($body ...)
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }

  // (a, b) => { return a + b }
  case infix { ($arg:arg (,) ...) | $ctx { $body ... } } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg$name (,) ...) {
        $($arg$default) (;) ...
        bind_args $args ($body ...)
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }

  // (a, b, ...rest) => rest
  case infix { ($arg:arg (,) ... $[...] $rest:ident) | $ctx $guard:expr } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg$name (,) ..., $rest) {
        $($arg$default) (;) ...
        rest_args $args $rest ($arg$name ...)
        return bind_args $args $guard;
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }

  // (a, b) => a + b
  case infix { ($arg:arg (,) ...) | $ctx $guard:expr } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg$name (,) ...) {
        $($arg$default) (;) ...
        return bind_args $args $guard;
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }

  // x => { x }
  case infix { $arg:ident | $ctx { $body ... } } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg) {
        bind_args $args ($body ...)
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }

  // x => x
  case infix { $arg:ident | $ctx $guard:expr } => {
    letstx $args = [makeIdent('__fa_args', #{$ctx})];
    return #{
      function ($args, $arg) {
        return bind_args $args $guard;
      }.bind(this, typeof arguments !== "undefined" ? arguments : undefined)
    }
  }
}

export (=>);
