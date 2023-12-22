#!/usr/bin/env bash
# https://gist.github.com/LangdalP/3f3d81b22d46635afcf4cb93db31cca1

# If script is ran with arguments, start or stop colima
if [ "$1" = "start" ]; then
    colima start
    exit 0
elif [ "$1" = "stop" ]; then
    colima stop
    exit 0
fi

# Otherwise, just give the regular plugin output
colima status

if [ $? -eq 0 ]; then
    echo ":c.square.fill: | sfsize=16"
    echo "---"
    # Set terminal=true if you want to see command outputs
    echo "Stop colima | bash=\"$0\" param1='stop' terminal=false"
else
    echo ":c.square: | sfsize=16"
    echo "---"
    echo "Start colima | bash=\"$0\" param1='start' terminal=false"
fi
