#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.vimrc"

# install vim if missing
if ! command -v vim &>/dev/null; then
  echo "installing vim..."
  sudo apt update --quiet && sudo apt install --yes vim
fi

# symlink vimrc
if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SCRIPT_DIR/vimrc" ]; then
  echo "vim: symlink already in place"
elif [ -e "$TARGET" ]; then
  echo "vim: backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
  ln --symbolic "$SCRIPT_DIR/vimrc" "$TARGET"
  echo "vim: symlinked $TARGET"
else
  ln --symbolic "$SCRIPT_DIR/vimrc" "$TARGET"
  echo "vim: symlinked $TARGET"
fi
