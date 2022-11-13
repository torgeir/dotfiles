#!/bin/bash
case $1 in
    s)
    grim -g "$(slurp)" $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    d)
    grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') \
        $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    w)
    grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" \
        $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    p)
    grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
    ;;
    *)
    echo "usage: ./screenshot.sh s|d|f"
    ;;
esac
