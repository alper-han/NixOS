#!/usr/bin/env bash

MODE_FILE="$HOME/.config/hypr/power_mode"
MODE=$(cat "$MODE_FILE" 2>/dev/null || echo "performance")

case "$MODE" in
  performance)
    ICON="󰓅"
    CLASS="performance"
    ;;
  powersave)
    ICON=""
    CLASS="powersave"
    ;;
  *)
    ICON="?"
    CLASS="unknown"
    ;;
esac

printf '{"text":"%s","class":"%s","tooltip":"Current power mode: %s"}\n' "$ICON" "$CLASS" "$MODE"
