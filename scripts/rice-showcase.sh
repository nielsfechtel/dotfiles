#!/bin/sh

# A simple script for setting up a nice 'rice-showcase'-set of windows, similar to the one in the example screenshots in the README.md. 

# What workspace should be used? Uses parameter substition for a default value
read -p "Enter workspace id [9]: " WORKSPACE_ID
WORKSPACE_ID=${WORKSPACE_ID:-9}

# Constants
CLASS_PREFIX="rice-setup"
# Open silently on workspace [w] and float
COMMON_RULES="workspace ${WORKSPACE_ID} silent; float;"
TITLE="rice"

echo "Opening setup in workspace ${WORKSPACE_ID}"

hyprctl dispatch --quiet -- exec "[${COMMON_RULES} move 1725 125; size 770 500] kitty --title=${TITLE} tty-clock -SDc"
hyprctl dispatch --quiet -- exec "[${COMMON_RULES} move 100 75; size 1000 450] kitty --title=${TITLE} unimatrix"
# needs --hold to not close kitty after fastfetch has finished executing
hyprctl dispatch --quiet -- exec "[${COMMON_RULES} move 250 720; size 957 675] kitty --title=${TITLE} --hold fastfetch"

# Close the windows after keypress
read -p "Press any key to close windows" -n 1 -s
# Use hyprctl clients in json-format and jq to filter out all clients on workspace X with above title (to be safe)
# Then get their pid and kill them like that. Could never get hyprctl dispatch closewindow to work.
clients_to_kill=$(hyprctl clients -j | jq --arg WORKSPACE_ID "${WORKSPACE_ID}" --arg TITLE "${TITLE}" ".[] | select(.workspace.id==$WORKSPACE_ID) | select(.title==\"$TITLE\")" | jq ".pid")
kill $(echo $clients_to_kill)

echo "Done."
