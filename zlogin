# make first display the primary output
xrandr --output DP-0 --primary

# prefer ctrl over caps
setxkbmap -option ctrl:nocaps

# load keyboard tweaks to fix the ergodox ez layout on linux
xmodmap ~/.Xmodmap
