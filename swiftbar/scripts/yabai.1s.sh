#!/usr/bin/env bash

export PATH=/usr/local/bin:$PATH

# check if its running
pgrep yabai 2>&1 1> /dev/null
if [[ $? -eq 0 ]]; then
    if [[ "$1" = "restart" ]]; then
        yabai --restart-service
        skhd --restart-service
    fi

    if [[ "$1" = "stop" ]]; then
        yabai --stop-service
        skhd --stop-service
    fi

    echo $(yabai -m query --spaces --display | jq -r 'sort_by(.index) | map(select(."has-focus" == true)) | first | .index')
    echo "---"
    echo "Restart yabai & skhd | bash='$0' param1=restart terminal=false"
    echo "Stop yabai & skhd | bash='$0' param1=stop terminal=false"
else

    if [[ "$1" = "restart" ]]; then
        yabai --start-service
        skhd --start-service
    fi

    echo n/a
    echo "---"
    echo "Start yabai & skhd | bash='$0' param1=restart terminal=false"
fi
