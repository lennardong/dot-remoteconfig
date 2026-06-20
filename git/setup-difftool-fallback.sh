#!/usr/bin/env bash
# Fallback diff UI: git's nvimdiff difftool (nvim -d). Idempotent.
# Editable working-tree pane, full vim ergonomics, zero plugins. lazygit+delta
# is the primary path; this is the CLI escape hatch.
set -euo pipefail

git config --global diff.tool nvimdiff
git config --global difftool.prompt false

echo "difftool -> nvimdiff. Run from inside a worktree:"
echo "  git difftool main        # working tree vs main, file-by-file"
echo "  git difftool main...     # only this branch's changes (merge-base)"
echo "  git difftool -d main     # all changed files in one nvim session"
