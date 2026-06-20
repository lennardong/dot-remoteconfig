#!/usr/bin/env bash
# Install ripgrep (Debian/apt). Idempotent.
set -euo pipefail

if command -v rg &>/dev/null; then
  echo "ripgrep present: $(rg --version | head -1)"
else
  echo "installing ripgrep..."
  sudo apt update --quiet && sudo apt install --yes ripgrep
fi
