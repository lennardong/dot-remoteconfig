#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== config-remote install (Debian/Ubuntu) ==="

# check for ghostty terminfo
if ! infocmp xterm-ghostty &>/dev/null; then
  echo ""
  echo "WARNING: xterm-ghostty terminfo not found."
  echo "Run this from your local Ghostty terminal to install it:"
  echo ""
  echo "  infocmp -x xterm-ghostty | ssh $(hostname) 'tic -x -'"
  echo ""
fi

echo ""
echo "--- bash ---"
"$SCRIPT_DIR/bash/install-debian.sh"

echo ""
echo "--- tmux ---"
"$SCRIPT_DIR/tmux/install-debian.sh"

echo ""
echo "--- nvim ---"
"$SCRIPT_DIR/nvim/install-debian.sh"

echo ""
echo "--- vim ---"
"$SCRIPT_DIR/vim/install-debian.sh"

echo ""
echo "=== done ==="
