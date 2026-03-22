#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# install nvim if missing
if ! command -v nvim &>/dev/null; then
  echo "installing neovim..."
  brew install neovim
fi

# install uv if missing
if ! command -v uv &>/dev/null; then
  echo "installing uv..."
  brew install uv
fi

# LSP servers via uv tool
echo "installing LSP servers..."
uv tool install basedpyright
uv tool install ruff
uv tool install marksman

# build tools needed by telescope-fzf-native
if ! command -v make &>/dev/null; then
  echo "installing xcode command line tools (needed by telescope-fzf-native)..."
  xcode-select --install 2>/dev/null || true
fi

mkdir -p "$NVIM_CONFIG"

# symlink helper
symlink_file() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "nvim: symlink already in place → $dst"
  elif [ -e "$dst" ]; then
    echo "nvim: backing up existing $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
    ln -s "$src" "$dst"
    echo "nvim: symlinked $dst"
  else
    ln -s "$src" "$dst"
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
  ln -s "$SCRIPT_DIR/lua" "$NVIM_CONFIG/lua"
  echo "nvim: symlinked lua/"
else
  ln -s "$SCRIPT_DIR/lua" "$NVIM_CONFIG/lua"
  echo "nvim: symlinked lua/"
fi
