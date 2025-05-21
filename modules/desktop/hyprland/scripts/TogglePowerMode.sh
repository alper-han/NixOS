#!/usr/bin/env bash

MODE_FILE="$HOME/.config/hypr/power_mode"

# If the mode file doesn't exist or is empty, set default to "performance"
if [[ ! -s "$MODE_FILE" ]]; then
  echo "performance" > "$MODE_FILE"
fi

CURRENT=$(cat "$MODE_FILE")

if [[ "$CURRENT" == "performance" ]]; then
  NEW_MODE="powersave"
  CMD="sudo tlp bat"
else
  NEW_MODE="performance"
  CMD="sudo tlp ac"
fi

# Run the command and check success
if kitty --class powermode zsh -c "echo 'Switching to $NEW_MODE mode...'; $CMD; EXIT_CODE=\$?; echo; if [ \$EXIT_CODE -eq 0 ]; then echo 'TLP power mode: $NEW_MODE'; echo '$NEW_MODE' > \"$MODE_FILE\"; else echo 'Failed to switch mode, action cancelled'; fi; read -k\?Press_enter_to_close..."; then
  :
else
  # Kitty failed to launch, fallback to run command directly (without terminal)
  if $CMD; then
    echo "$NEW_MODE" > "$MODE_FILE"
  else
    echo "Failed to switch mode, action cancelled"
  fi
fi
