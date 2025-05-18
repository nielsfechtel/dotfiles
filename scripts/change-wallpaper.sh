#!/bin/sh

# all this is inspired by My Linux For Work's swww- and pywal-setup

export HOME=/home/niels

# get a random image - do it Quietly, Not changing the wallpaper, In folder X
/home/niels/.local/bin/wal --saturate 0.6 --contrast 11.0 -q -n -i /home/niels/wallpaper/

# get the newly-generated color-schemes in here 
# below we are only using the wallpaper-variable, which contains the full path
source "/home/niels/.cache/wal/colors.sh"

# get wallpaper-image file name, stripping the rest
new_wallpaper=$(echo $wallpaper | sed "s|/home/niels/wallpaper/||g")

# this breaks hyprshade, so we turn on auto again (depending on time of day)
hyprshade auto && swww img $wallpaper --transition-step=20 --transition-fps=60
hyprpanel useTheme /home/niels/.config/hyprpanel/theme.json

echo "DONE!"
