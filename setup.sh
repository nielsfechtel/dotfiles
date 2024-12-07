#!/bin/sh


# mkdir -p ~/.config 
echo `pwd`
# the directory needs to be in $HOME and we need to be in it 
if ! cd "$HOME/dotfiles" > /dev/null && pwd != "$HOME/dotfiles"; then
	exit 1
fi

# for every folder in here, execute `stow -S <folder>`
ls -d */ | xargs -I {} bash -c "stow -S '{}'"

