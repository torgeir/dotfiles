#!/usr/bin/env bash
id=$(
  swaymsg -rt get_workspaces \
    | jq ".[] | select(.representation | contains(\"$1\")) | .focus[0]"
)
swaymsg "[con_id=$id]" focus
