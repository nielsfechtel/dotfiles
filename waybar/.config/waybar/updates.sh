#!/bin/sh

# This script is heavily inspired by Stefan Raabe (My Linux for Work)'s updates-script
# It required pacman-contrib for the 'checkupdates'-script

# Threshold for colors
threshold_green=0
threshold_yellow=25
threshold_red=100 

# Get updateable packages-number
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
  updates_arch=0
fi

if ! updates_aur=$(yay -Qu | wc -l ); then
  updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

###
# Testing
###
# updates=90

# Output in JSON for Waybar module
if [ "$updates" -gt $threshold_yellow ]; then
  css_class="yellow"
fi

if [ "$updates" -gt $threshold_red ]; then
  css_class="red"
fi

if [ "$updates" -gt $threshold_green ]; then
  printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
  printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "green"}'
fi
