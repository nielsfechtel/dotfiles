#!/bin/sh


# mkdir -p ~/.config 
echo `pwd`
# the directory needs to be in $HOME and we need to be in it 
if ! cd "$HOME/dotfiles" > /dev/null; then
	echo "Error - directory ~/dotfiles does not exist"
	exit 1
fi

# need to remove it, as otherwise Stow won't be able to create the symlink
rm ~/.bashrc

# for every folder in here, execute `stow -S <folder>`
ls -d */ | xargs -I {} bash -c "stow -S '{}'"