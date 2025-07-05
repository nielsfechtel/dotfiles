#!/bin/bash
set -e

# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Initialize dotfiles

chezmoi init --source="$PWD" --apply

# Remove chezmoi in devcontainers?
