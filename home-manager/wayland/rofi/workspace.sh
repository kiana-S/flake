#!/usr/bin/env bash

if [ $# -ne 0 ]; then
    swaymsg workspace "$@"

    # Hack to get around weird bug
    pkill rofi
    exit 0
fi

swaymsg -t get_workspaces |
    jq -r '.[].name'
