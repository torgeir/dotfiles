# make first display the primary output
# xrandr --output HDMI-0 --primary
# xrandr --output DisplayPort-2 --primary --rotate left
# is this nescessary any longer?
xrandr --output HDMI-A-0 --primary #--rotate left

# prefer ctrl over caps
setxkbmap -option ctrl:nocaps

# load keyboard tweaks to fix the ergodox ez layout on linux
xmodmap $HOME/.Xmodmap
