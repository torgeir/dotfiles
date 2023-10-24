#!/usr/bin/env bash
case $1 in
    s)
    grimshot save area \
        $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    d)
    grimshot save output \
        $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    w)
    grimshot save window \
        $HOME/Dropbox/Screenshots/$(date +"%Y-%m-%dT%H:%M:%SZ_grim.png")
    ;;
    p)
    grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
    ;;
    *)
    echo "usage: ./screenshot.sh s|d|w"
    ;;
esac
