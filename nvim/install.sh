#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.config/nvim/init.lua"

# install nvim if missing
if ! command -v nvim &>/dev/null; then
  echo "installing neovim..."
  sudo apt update --quiet && sudo apt install --yes neovim
fi

# symlink init.lua
mkdir -p "$(dirname "$TARGET")"
if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SCRIPT_DIR/init.lua" ]; then
  echo "nvim: symlink already in place"
elif [ -e "$TARGET" ]; then
  echo "nvim: backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
  ln --symbolic "$SCRIPT_DIR/init.lua" "$TARGET"
  echo "nvim: symlinked $TARGET"
else
  ln --symbolic "$SCRIPT_DIR/init.lua" "$TARGET"
  echo "nvim: symlinked $TARGET"
fi
