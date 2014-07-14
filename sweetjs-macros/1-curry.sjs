macroclass rest_arrows {
  pattern {
    rule { $arg:ident -> $rest:rest_arrows }
    with $args ... = #{ $arg $rest$args ... },
    $body = #{ $rest$body }
  }
  pattern {
    rule { $body:expr }
    with $args ... = []
  }
}

macro (->) {
  rule infix { $first:ident | $rest:rest_arrows } => {
    curry(function ($first, $rest$args (,) ...) { return $rest$body })
  }
}

export (->);
