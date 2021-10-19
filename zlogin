# make first hdmi the primary output
xrandr --output HDMI-0 --primary

# prefer ctrl over caps
setxkbmap -option ctrl:nocaps

# load keyboard tweaks to fix the ergodox ez layout on linux
xmodmap ~/.Xmodmap
