#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done


if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar > /dev/null 2>&1 &
  done
else
  polybar --reload mybar > /dev/null 2>&1 &
fi

# Launch bar for Laptop screen
#MONITOR=eDP-1 polybar mybar &

echo "Bars launched..."
