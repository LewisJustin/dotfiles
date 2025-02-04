#!/bin/bash
status() { \
    bat=$(cat /sys/class/power_supply/CMB1/capacity | tr '\n' '%')
    stat=$(cat /sys/class/power_supply/CMB1/status)
    date=$(date "+%b %d (%a) %H:%M")
    [[ $stat = "Discharging" ]] && color="\R" || color="\G"
    printf "%s%s%s\N| %s " "$bat" "$color" "$stat" "$date"
}

while :; do
xsetroot -name " $(status | tr '\n' ' ')"
   sleep 1m
done
