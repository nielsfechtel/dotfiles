#!/usr/bin/env bash
set -euo pipefail

# Simple config
WS_NAME="communication"
FER_CLASS="Ferdium"
SIG_CLASS="Signal"

# WQHD screen dimensions
SCREEN_W=2560
SCREEN_H=1440

# Configuration - easy to adjust
BORDER=10 # Outer border to keep free on all sides
GAP=10    # Small gap between the two windows

# Calculate usable area after removing borders
USABLE_W=$((SCREEN_W - 2 * BORDER))
USABLE_H=$((SCREEN_H - 2 * BORDER))

# Split: Ferdium 2/3 left, Signal 1/3 right with gap
FER_W=$(((USABLE_W - GAP) * 2 / 3))
SIG_W=$((USABLE_W - FER_W - GAP))

# Position windows within the bordered area
FER_X=$BORDER
FER_Y=$BORDER
SIG_X=$((BORDER + FER_W + GAP))
SIG_Y=$((BORDER - 10)) # Offset Signal up slightly

get_window_by_class() {
  local class="$1"
  hyprctl clients | awk -v want="$class" '
        /^Window /{addr=$2}
        $1=="class:" && $2==want {print addr; exit}
    '
}

# Get existing windows
FER_ID=$(get_window_by_class "$FER_CLASS")
SIG_ID=$(get_window_by_class "$SIG_CLASS")

# Launch Signal if it doesn't exist (Ferdium autostarts)
if [ -z "$SIG_ID" ]; then
  signal-desktop &
  sleep 2
fi

# Just position and size - let the window rules handle workspace/floating
if [ -n "$FER_ID" ]; then
  hyprctl dispatch focuswindow "address:$FER_ID"
  hyprctl dispatch movewindowpixel "exact $FER_X $FER_Y"
  hyprctl dispatch resizewindowpixel "exact $FER_W $USABLE_H"
fi

# Get Signal ID again in case we just launched it
SIG_ID=$(get_window_by_class "$SIG_CLASS")
if [ -n "$SIG_ID" ]; then
  hyprctl dispatch focuswindow "address:$SIG_ID"
  hyprctl dispatch movewindowpixel "exact $SIG_X $SIG_Y"
  hyprctl dispatch resizewindowpixel "exact $SIG_W $((USABLE_H + 20))"
fi

# Toggle the special workspace
hyprctl dispatch togglespecialworkspace "$WS_NAME"
