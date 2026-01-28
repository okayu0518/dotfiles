#!/bin/sh

INTERNAL="eDP-1"

# count connected external monitors
EXTERNAL_COUNT=$(hyprctl monitors -j | jq '[.[] | select(.name != "'"$INTERNAL"'")] | length')

case "$1" in
  close)
    if [ "$EXTERNAL_COUNT" -gt 0 ]; then
      hyprctl keyword monitor "$INTERNAL,disable"
    fi
    ;;
  open)
    #hyprctl keyword monitor "$INTERNAL,preferred,auto,1"
		hyprctl reload
    ;;
esac

