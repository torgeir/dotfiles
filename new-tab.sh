#!/usr/bin/env bash
# open -a Firefox
open -a Firefox\ Developer\ Edition
sleep 0.2 # some room to let go of shift key, which opens previous tab
osascript -e 'tell application "System Events" to keystroke "t" using command down'
