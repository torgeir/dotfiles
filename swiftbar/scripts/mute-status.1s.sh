#!/usr/bin/env bash
if [[ "$(osascript ~/.config/dotfiles/swiftbar/zoom-mute-status.scpt)" == "Muted" ]]
then
    echo "🔴"
else
    echo "🟢"
fi
