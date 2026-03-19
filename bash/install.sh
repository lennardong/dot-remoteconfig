#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASHRC="$HOME/.bashrc"
SOURCE_LINE="# source config-remote bash snippets"
SOURCE_BLOCK='# source config-remote bash snippets
for f in "$HOME/.config-remote/bash/"*.bash; do
  [ -f "$f" ] && source "$f"
done'

# install fzf if missing
if ! command -v fzf &>/dev/null; then
  echo "installing fzf..."
  sudo apt update --quiet && sudo apt install --yes fzf
fi

# install fd if missing
if ! command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  echo "installing fd-find..."
  sudo apt update --quiet && sudo apt install --yes fd-find
fi

# symlink fdfind -> fd if needed
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln --symbolic "$(command -v fdfind)" "$HOME/.local/bin/fd"
  echo "bash: symlinked fdfind -> fd"
fi

# install bat if missing
if ! command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  echo "installing bat..."
  sudo apt update --quiet && sudo apt install --yes bat
fi

# symlink batcat -> bat if needed
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln --symbolic "$(command -v batcat)" "$HOME/.local/bin/bat"
  echo "bash: symlinked batcat -> bat"
fi

# install trash-cli if missing
if ! command -v trash-put &>/dev/null; then
  echo "installing trash-cli..."
  sudo apt update --quiet && sudo apt install --yes trash-cli
fi

# install ripgrep if missing
if ! command -v rg &>/dev/null; then
  echo "installing ripgrep..."
  sudo apt update --quiet && sudo apt install --yes ripgrep
fi

# add source loop to .bashrc if not already present
if grep --quiet "$SOURCE_LINE" "$BASHRC" 2>/dev/null; then
  echo "bash: source loop already in .bashrc"
else
  echo "" >> "$BASHRC"
  echo "$SOURCE_BLOCK" >> "$BASHRC"
  echo "bash: added source loop to .bashrc"
fi
