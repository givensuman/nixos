#!/usr/bin/env bash
set -euo pipefail

# Update Fish plugins
fish -c 'fisher update'

# Reset Neovim plugins
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

nvim --headless "+Lazy! sync" +qa

# bat
bat cache --build
