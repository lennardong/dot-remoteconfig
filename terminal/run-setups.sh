#!/usr/bin/env bash
# Orchestrate the terminal setups. Each setup-*.sh is idempotent and
# self-contained, so order is free.
#
# Tool installs are Debian/apt — skipped where apt is absent (macOS gets these
# from the Brewfile). Shell wiring (setup-shell) is cross-platform, always runs.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run() { echo "=== $1 ==="; "${here}/$1.sh"; }

if command -v apt &>/dev/null; then
  for s in setup-fzf setup-fd setup-bat setup-trash setup-ripgrep; do
    run "$s"
  done
else
  echo "no apt: skipping tool installs (macOS uses the Brewfile)"
fi

run setup-shell

echo "all terminal setups done."
