#!/bin/sh

mkdir -p ~/.config 

# the directory should have been created by devpod
if ! cd "$HOME/dotfiles" > /dev/null; then
	exit 1
fi

# for every folder in here, execute `stow -S <folder>`
ls -d */ | xargs -I {} bash -c "stow -S '{}'"

