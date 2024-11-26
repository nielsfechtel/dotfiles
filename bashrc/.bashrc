#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Niels' aliases
# to make aliases work with sudo, from askubuntu.com/questions/22037
# Niels' section

# Bash vi-mode and re-add Ctrl-L for clear
set -o vi
bind -x '"\C-l":clear'

# History longer
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
# apparently default, but necessary to set e.g. for MacOS
export HISTCONTROL=ignorespace

# Make aliases work with sudo, from askubuntu.com/questions/22037
# "Bash only checks the first word of a command for an alias. [...] We can tell bash to check
# the next word after the alias (i.e. sudo) by adding a space at the end of the alias value"
# Note that this breaks if using a flag for sudo; there are other longer solutions in the same question.
alias sudo='sudo '

# fzf with preview
alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# basics
alias la='ls -la'
alias ls='ls -l'
alias v='nvim'
alias ..='cd ..'
alias ...='cd ../../../'
# do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing terms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


# git
alias gs='git status'
function gsw() { git switch "$@"; }
function gcm() { git commit -m "$@"; }
function ga() { git add "$@"; }
function gd() { git diff "$@"; }
alias gps='git push'
alias gpl='git pull'
alias gb='git branch'
function gme() { git merge "$@"; }
function glol() { git log --graph --decorate --pretty=oneline --abbrev-commit; }
function glola() { git log --graph --decorate --pretty=oneline --abbrev-commit --all; }


# fzf 
# (register shell integration like using fzf for Ctrl+r, etc.)
eval "$(fzf --bash)"
# add alias for opening in nvim
alias vf='fzf --bind "enter:become(nvim {})"'

# zoxide (z)
eval "$(zoxide init --cmd cd bash)"

# last step: Starship
eval "$(starship init bash)"


# pnpm
export PNPM_HOME="/home/niels/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
