#!/usr/bin/env bash

if [ $# -ne 0 ]; then
    swaymsg workspace "$@"
    exit 0
fi

swaymsg -t get_workspaces |
    jq -r '.[].name'
