#!/usr/bin/env bash

if [ $# -ne 0 ]; then
    swaymsg move container to workspace "$@" > /dev/null
else
    swaymsg -t get_workspaces |
        jq -r 'map(.name) + ["10:browser","20:terminal","30:code","40:files","50:discord","60:settings"] | unique | .[]'
fi
