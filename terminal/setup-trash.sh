#!/usr/bin/env bash
# Install trash-cli (Debian/apt). Idempotent.
# The `rm -> trash-put` alias is wired at shell startup by profile.d/trash.sh.
set -euo pipefail

if command -v trash-put &>/dev/null; then
  echo "trash-cli present"
else
  echo "installing trash-cli..."
  sudo apt update --quiet && sudo apt install --yes trash-cli
fi
