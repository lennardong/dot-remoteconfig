#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== config-remote install ==="

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
"$SCRIPT_DIR/bash/install.sh"

echo ""
echo "--- tmux ---"
"$SCRIPT_DIR/tmux/install.sh"

echo ""
echo "--- nvim ---"
"$SCRIPT_DIR/nvim/install.sh"

echo ""
echo "--- vim ---"
"$SCRIPT_DIR/vim/install.sh"

echo ""
echo "=== done ==="
