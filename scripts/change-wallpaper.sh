#!/bin/sh

# all this is inspired by My Linux For Work's swww- and pywal-setup

# get a random image - do it Quietly, Not changing the wallpaper, In folder X
~/.local/bin/wal -q -n -i $HOME/wallpaper/

# get the newly-generated color-schemes in here 
# below we are only using the wallpaper-variable, which contains the full path
source "$HOME/.cache/wal/colors.sh"

# get wallpaper-image file name, stripping the rest
new_wallpaper=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

swww img $wallpaper --transition-step=20 --transition-fps=60
# Set the wallpaper in hyprpanel's settings - it uses Matugen to generate
# colors for itself, like we're using pywal16. Doesn't actually change the
# wallpaper, since "Apply wallpaper" is turned off. 
hyprpanel setWallpaper $wallpaper

# it seems I can't use @import in wofi's css, so I replace the first 20 lines with the css-lines
filein=$HOME/.cache/wal/colors-define-color.css
nline=$(sed -n '$=' $filein)
for (( i = 1 ; i <= $nline ; i++ )); do
    line=$(sed -n "${i}p" $filein)
    sed -i "${i}c\\$line" $HOME/.config/wofi/style.css
done


echo "DONE!"
