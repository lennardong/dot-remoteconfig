#!/usr/bin/env bash
# Install tmux (Debian/apt). Idempotent.
set -euo pipefail

if command -v tmux &>/dev/null; then
  echo "tmux present: $(tmux -V)"
else
  echo "installing tmux..."
  sudo apt update --quiet && sudo apt install --yes tmux
fi
