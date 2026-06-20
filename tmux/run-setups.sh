#!/usr/bin/env bash
# Orchestrate the tmux setups. Each setup-*.sh is idempotent and self-contained,
# so order is free.
#
# Package install is Debian/apt — skipped where apt is absent (macOS gets tmux
# from the Brewfile). Config symlink + worktree-session permission are
# cross-platform, always run.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run() { echo "=== $1 ==="; "${here}/$1.sh"; }

if command -v apt &>/dev/null; then
  run setup-debian
else
  echo "no apt: skipping tmux install (macOS uses the Brewfile)"
fi

run setup-tmux              # symlink ~/.tmux.conf
run setup-worktreesession  # chmod +x tmux-worktree

echo "all tmux setups done."
