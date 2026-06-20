#!/usr/bin/env bash
# Install fzf (Debian/apt). Idempotent.
# Keybindings are wired at shell startup by profile.d/fzf.sh — this only
# puts the binary on PATH, so it's shell-agnostic (bash + zsh both see it).
set -euo pipefail

if command -v fzf &>/dev/null; then
  echo "fzf present: $(fzf --version)"
else
  echo "installing fzf..."
  sudo apt update --quiet && sudo apt install --yes fzf
fi
