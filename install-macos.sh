#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== config-remote install (macOS) ==="
echo "NOTE: packages (tmux, nvim, etc.) are managed via ~/.config/brew/Brewfile"
echo "NOTE: nvim config is symlinked via dotfiles (nvim → ../.config-remote/nvim)"

symlink_file() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  already in place → $dst"
  elif [ -e "$dst" ]; then
    echo "  backing up $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
    ln -s "$src" "$dst"
    echo "  symlinked $dst"
  else
    ln -s "$src" "$dst"
    echo "  symlinked $dst"
  fi
}

echo ""
echo "--- tmux ---"
"$SCRIPT_DIR/tmux/run-setups.sh"

echo ""
echo "--- vim ---"
symlink_file "$SCRIPT_DIR/vim/vimrc" "$HOME/.vimrc"

echo ""
echo "--- terminal ---"
# tools come from brew (Brewfile); this just wires the shell snippets into .zshrc
"$SCRIPT_DIR/terminal/run-setups.sh"

echo ""
echo "=== done ==="
