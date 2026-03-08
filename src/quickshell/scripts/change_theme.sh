#!/bin/bash
# Usage: change_theme.sh <light|dark> <monitor>

THEME=$1
MONITOR=${2:-1}

if [[ "$THEME" == "dark" || "$THEME" == "light" ]]; then
  echo "$THEME"
  imgPath=$(swww query | grep -oP 'image:\K.*' | head -n "$MONITOR" | tr -d ' ')
  matugen image -m "$THEME" "$imgPath"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-$THEME"
  kill -SIGUSR1 $(pgrep kitty)
fi



