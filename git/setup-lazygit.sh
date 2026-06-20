#!/usr/bin/env bash
# Install lazygit. macOS: brew. Debian: GitHub binary (not in apt). Idempotent.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

if command -v lazygit >/dev/null 2>&1; then
  echo "lazygit present: $(lazygit --version | grep -o 'version=[^,]*' | head -1)"
  exit 0
fi

echo "installing lazygit..."
case "$(detect_os)" in
  macos)
    require_brew
    brew install lazygit
    ;;
  debian)
    arch=$(detect_arch)  # x86_64 or arm64 — matches lazygit asset naming
    ver=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
          | grep -Po '"tag_name": *"v\K[^"]*')
    curl -fsSL -o /tmp/lazygit.tar.gz \
      "https://github.com/jesseduffield/lazygit/releases/download/v${ver}/lazygit_${ver}_Linux_${arch}.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin/
    rm -f /tmp/lazygit /tmp/lazygit.tar.gz
    ;;
esac
echo "lazygit installed: $(lazygit --version | grep -o 'version=[^,]*' | head -1)"
