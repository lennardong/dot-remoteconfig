#!/usr/bin/env bash
# Make the prefix-S worktree-session switcher executable. Idempotent.
# tmux-worktree opens the current repo as one session, one window per worktree.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

chmod +x "$here/tmux-worktree"
echo "tmux-worktree: +x"
