#!/usr/bin/env bash

export PATH=/usr/local/bin:$PATH

if [[ "$1" = "start" ]]; then
    yabai --start-service
    skhd --start-service
elif [[ "$1" = "restart" ]]; then
    yabai --restart-service
    skhd --restart-service
elif [[ "$1" = "stop" ]]; then
    yabai --stop-service
    skhd --stop-service
fi

# check if its running
pgrep yabai &>/dev/null
if [[ $? -eq 0 ]]; then
    echo $(yabai -m query --spaces --display | jq -r 'sort_by(.index) | map(select(."has-focus" == true)) | first | .index')
    echo "---"
    echo "Restart yabai & skhd | bash='$0' param1=restart terminal=false"
    echo "Stop yabai & skhd | bash='$0' param1=stop terminal=false"
else
    echo n/a
    echo "---"
    echo "Start yabai & skhd | bash='$0' param1=start terminal=false"
fi
