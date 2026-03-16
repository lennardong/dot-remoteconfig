#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# install nvim if missing
if ! command -v nvim &>/dev/null; then
  echo "installing neovim..."
  sudo apt update --quiet && sudo apt install --yes neovim
fi

# build tools needed by telescope-fzf-native
if ! command -v make &>/dev/null; then
  echo "installing build-essential (needed by telescope-fzf-native)..."
  sudo apt update --quiet && sudo apt install --yes build-essential
fi

mkdir -p "$NVIM_CONFIG"

# symlink init.lua
symlink_file() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "nvim: symlink already in place → $dst"
  elif [ -e "$dst" ]; then
    echo "nvim: backing up existing $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
    ln --symbolic "$src" "$dst"
    echo "nvim: symlinked $dst"
  else
    ln --symbolic "$src" "$dst"
    echo "nvim: symlinked $dst"
  fi
}

symlink_file "$SCRIPT_DIR/init.lua" "$NVIM_CONFIG/init.lua"

# symlink lua/ directory
if [ -L "$NVIM_CONFIG/lua" ] && [ "$(readlink "$NVIM_CONFIG/lua")" = "$SCRIPT_DIR/lua" ]; then
  echo "nvim: lua/ symlink already in place"
elif [ -e "$NVIM_CONFIG/lua" ]; then
  echo "nvim: backing up existing $NVIM_CONFIG/lua to $NVIM_CONFIG/lua.bak"
  mv "$NVIM_CONFIG/lua" "$NVIM_CONFIG/lua.bak"
  ln --symbolic "$SCRIPT_DIR/lua" "$NVIM_CONFIG/lua"
  echo "nvim: symlinked lua/"
else
  ln --symbolic "$SCRIPT_DIR/lua" "$NVIM_CONFIG/lua"
  echo "nvim: symlinked lua/"
fi
