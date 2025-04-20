#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Bash vi-mode and re-add Ctrl-L for clear
set -o vi
bind -x '"\C-l":clear'

# Enable Fcitx5 for input method editors
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

# Make sure LANG and LC_C are set - some tools like tmux
# need it in nested sessions for using e.g. powerline-glyphs
export LANG=en_US.utf8
export LC_ALL=en_US.utf8
# History longer
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# Use libvirt-system-variant by default
export LIBVIRT_DEFAULT_URI='qemu:///system'

# Make aliases work with sudo, from askubuntu.com/questions/22037
# "Bash only checks the first word of a command for an alias. [...] We can tell bash to check
# the next word after the alias (i.e. sudo) by adding a space at the end of the alias value"
# Note that this breaks if using a flag for sudo; there are other longer solutions in the same question.
alias sudo='sudo '

# Man pages with syntax highlighting using terminal-colors, unlike bat and batman
eval "$(batman --export-env)"
export MANPAGER='less -R --use-color -Dd+r -Du+b'
export LESS='-R'

# fzf with preview
alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# basic aliases
alias ls='ls -l --color=auto'
alias ll='ls -la'
# also sort by time (-t), human-readable units (-h), reverse order (-r)
alias la='ls -lathr'

export EDITOR=nvim
export VISUAL=nvim
alias v='nvim'
alias mk='minikube'
alias t='tmux'
alias y='yazi'
alias d='devpod'
alias ds='devpod ssh'
alias h='hyprland'

alias ..='cd ..'
alias ...='cd ../../../'
alias rm='rm -I --preserve-root'
# confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# docker
alias lzd='lazydocker'

# git
alias lz='lazygit'
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

# kubernetes
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
alias kgp='k get pods'
alias kgd='k get deployments'
alias kgn='k get namespaces'
alias kgv='k get persistentvolumeclaims'

# fzf 
# (register shell integration like using fzf for Ctrl+r, etc.)
eval "$(fzf --bash)"
# add alias for opening in nvim
alias vf='fzf --bind "enter:become(nvim {})"'

# pnpm
export PNPM_HOME="/home/niels/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2024-12-28 00:11:49
export PATH="$PATH:/home/niels/.local/bin"

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

eval "$(direnv hook bash)"

eval "$(thefuck --alias)"

command -v devpod >/dev/null && . <(devpod completion bash)

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# last step: Starship
eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zoxide (z)
eval "$(zoxide init --cmd cd bash)"
