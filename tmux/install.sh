#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.tmux.conf"

# install tmux if missing
if ! command -v tmux &>/dev/null; then
  echo "installing tmux..."
  sudo apt update --quiet && sudo apt install --yes tmux
fi

# symlink tmux.conf
if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SCRIPT_DIR/tmux.conf" ]; then
  echo "tmux: symlink already in place"
elif [ -e "$TARGET" ]; then
  echo "tmux: backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
  ln --symbolic "$SCRIPT_DIR/tmux.conf" "$TARGET"
  echo "tmux: symlinked $TARGET"
else
  ln --symbolic "$SCRIPT_DIR/tmux.conf" "$TARGET"
  echo "tmux: symlinked $TARGET"
fi
