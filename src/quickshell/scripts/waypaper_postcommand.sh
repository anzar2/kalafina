#!/bin/bash
WALLPAPER=$1
THEME=$(jq -r '.theme' ~/.config/quickshell/shell.json)

matugen image -m "$THEME" "$WALLPAPER"
