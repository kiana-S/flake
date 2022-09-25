#!/usr/bin/env bash

if [ $# -ne 0 ]; then
    id=$(echo "$@" | cut -d ' ' -f1)
    swaymsg "[con_id=$id]" focus

    # Hack to get around weird bug
    pkill rofi
    exit 0
fi

swaymsg -t get_tree |
    jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes |
                .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name)'
