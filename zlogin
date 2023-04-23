case $(uname) in
  Linux)
    # make first display the primary output
    if command -v xrandr &> /dev/null
    then
      xrandr --output HDMI-A-0 --primary #--rotate left
    fi

    if command -v wlr-randr &> /dev/null
    then
      wlr-randr --output DP-2 --transform 90
    fi

    # prefer ctrl over caps
    if command -v setxkbmap &> /dev/null
    then
      setxkbmap -option ctrl:nocaps
    fi
esac
