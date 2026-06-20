#!/usr/bin/env bash
# Install fd (Debian package is fd-find, binary is fdfind). Symlink to `fd`.
# Idempotent. fzf uses fd as its file source (see profile.d/fzf.sh).
set -euo pipefail

if ! command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  echo "installing fd-find..."
  sudo apt update --quiet && sudo apt install --yes fd-find
fi

# expose as `fd` when only fdfind exists (Debian naming)
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln --symbolic --force "$(command -v fdfind)" "$HOME/.local/bin/fd"
  echo "symlinked fdfind -> fd"
else
  echo "fd present"
fi
