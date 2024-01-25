#!/usr/bin/env bash
if ps -ef | grep zoom.us.app | grep -v grep > /dev/null 2>&1
then
    if [[ "$(osascript ~/.config/dotfiles/swiftbar/zoom-mute-status.scpt)" == "Muted" ]]
    then
        echo "⚫"
    else
        echo "🔴"
    fi
else
    echo "◌"
fi
