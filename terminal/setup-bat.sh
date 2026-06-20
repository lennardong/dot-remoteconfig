#!/usr/bin/env bash
# Install bat (Debian package is bat, binary is batcat). Symlink to `bat`.
# Idempotent. fzf uses bat for file previews (see profile.d/fzf.sh).
set -euo pipefail

if ! command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  echo "installing bat..."
  sudo apt update --quiet && sudo apt install --yes bat
fi

# expose as `bat` when only batcat exists (Debian naming)
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln --symbolic --force "$(command -v batcat)" "$HOME/.local/bin/bat"
  echo "symlinked batcat -> bat"
else
  echo "bat present"
fi
