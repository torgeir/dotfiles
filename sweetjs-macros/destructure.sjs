let var = macro {

  rule { $name:ident in $value:expr } => {
    $name in $value
  }

  rule { $name:ident = $value:expr } => {
    var $name = $value
  }

  rule { {$name:ident (,) ...} = $value:expr } => {
    var object = $value
      $(, $name = object.$name) ...
  }

  rule { [$name:ident (,) ...] = $value:expr } => {
    var array = $value, index = 0
      $(, $name = array[index++]) ...
  }
}

export (var);
