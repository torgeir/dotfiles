let function = macro {
  case {
    _ $name:ident ($arg:expr (,) ... ) { $body ... }
  }
  => {
    var here = #{$arg ...}[0];
    var args = #{$arg ...};

    var innerTokens = args
      .map(function (arg) {
        return arg.token.inner;
      })

    var argNames = innerTokens.map(function (inner) {
      var name = inner[0].token.value;
      return makeIdent(name, here);
    });

    var argsWithDefaultValues = innerTokens
      .filter(function (inners) {
        var withEqualsSign = inners.filter(function (inner) {
          return (inner.token.value == "=");
        });
        var hasEqualsSign = (withEqualsSign.length > 0);
        return hasEqualsSign;
      })
      .reduce(function (acc, arg) {
        var name = arg[0].token.value;
        return acc
          .concat(#{typeof })
          .concat(makeIdent(name, here))
          .concat(#{ === 'undefined' ? })
          .concat(makeDelim('()', arg, here))
          .concat(#{ : undefined;})
      }, []);


    letstx $argNames = argNames,
           $argsWithDefaultValues = argsWithDefaultValues;

    return #{
      function $name ($argNames) {
        $argsWithDefaultValues
        $body ...
      }
    };
  }
};

export function;
