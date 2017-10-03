#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

player_status=$(playerctl-cmus status 2> /dev/null | tr '[:upper:]' '[:lower:]')
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl-cmus metadata artist) - $(playerctl-cmus metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "playing" ]]; then
    echo "%{F#ffffff}$icon $metadata"       # Orange when playing
elif [[ $player_status = "paused" ]]; then
    echo "%{F#555}$icon $metadata"       # Greyed out info when paused
else
    echo "%{F#555}$icon"                 # Greyed out icon when stopped
fi
