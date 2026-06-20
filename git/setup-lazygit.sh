#!/usr/bin/env bash
# Install lazygit (GitHub binary release; not in Ubuntu apt). Idempotent.
set -euo pipefail

if command -v lazygit >/dev/null 2>&1; then
  echo "lazygit present: $(lazygit --version | grep -o 'version=[^,]*' | head -1)"
  exit 0
fi

echo "installing lazygit..."
ver=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
      | grep -Po '"tag_name": *"v\K[^"]*')
curl -fsSL -o /tmp/lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/download/v${ver}/lazygit_${ver}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin/
rm -f /tmp/lazygit /tmp/lazygit.tar.gz
echo "lazygit installed: $(lazygit --version | grep -o 'version=[^,]*' | head -1)"
