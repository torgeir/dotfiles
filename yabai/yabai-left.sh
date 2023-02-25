is_float=$(yabai -m query --windows --window | jq '."is-floating"')

if [ "$is_float" = "true" ]; then
  yabai -m window --focus $(yabai -m query --windows | \
    jq -e --argjson pos -1 '(.[] | select(."has-focus")) as {$id, $app}
      | map(select(."is-floating" == true))
      | sort_by(.space, .frame.x, .frame.y)
      | map(.id)
      | .[(index($id)+($pos))%length]')
else
  yabai -m window --focus west  || yabai -m display --focus west
fi
