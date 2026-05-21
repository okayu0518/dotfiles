#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

# Build display text and keep the raw command after a tab.
BINDINGS=$(
  awk -F',' '
    function trim(s) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", s)
      return s
    }
    /^[[:space:]]*bind[[:space:]]*=/ {
      mods = trim($1)
      sub(/^[[:space:]]*bind[[:space:]]*=[[:space:]]*/, "", mods)
      key = trim($2)
      action = trim($3)
      cmd = ""
      for (i = 4; i <= NF; i++) {
        cmd = cmd (i == 4 ? "" : ",") $i
      }
      cmd = trim(cmd)
      printf "<b>%s + %s</b>  <i>%s</i>\t%s\n", mods, key, action, cmd
    }
  ' "$HYPR_CONF"
)

CHOICE=$(printf '%s\n' "$BINDINGS" | rofi -dmenu -i -markup-rows -p "Hyprland Keybinds:")

CMD=${CHOICE#*$'\t'}

[ -n "$CMD" ] || exit 0

if [[ $CMD == exec* ]]; then
  eval "${CMD#exec, }"
elif [[ $CMD == exec ]]; then
  exit 0
else
  hyprctl dispatch "$CMD"
fi
