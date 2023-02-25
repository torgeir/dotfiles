if [ "$(yabai -m query --windows --window | jq -e '.frame | (.y <= 25)')" = "true" ]; then
    echo $(yabai -m query --windows --window) > ~/window.debug.log
    yabai -m window --toggle float
fi
