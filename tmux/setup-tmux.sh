#!/usr/bin/env bash
# Symlink ~/.tmux.conf -> tmux/tmux.conf. Backs up any existing real file first.
# Idempotent — leaves an already-correct symlink untouched.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="$HOME/.tmux.conf"
src="$here/tmux.conf"

if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
  echo "tmux.conf: symlink already in place"
elif [ -e "$target" ]; then
  echo "tmux.conf: backing up $target -> ${target}.bak"
  mv "$target" "${target}.bak"
  ln --symbolic "$src" "$target"
  echo "tmux.conf: symlinked"
else
  ln --symbolic "$src" "$target"
  echo "tmux.conf: symlinked"
fi
