#!/usr/bin/env bash
# Ensure global gitignore patterns. Idempotent — appends only missing lines,
# never clobbers existing ones. Git reads $XDG_CONFIG_HOME/git/ignore automatically.
set -euo pipefail

ignore="${XDG_CONFIG_HOME:-$HOME/.config}/git/ignore"
mkdir -p "$(dirname "$ignore")"
touch "$ignore"

patterns=(
  '**/.claude/settings.local.json'   # Claude Code per-project local settings
  '.worktrees/'                      # in-repo git worktrees (our convention)
  '.DS_Store'                        # macOS directory litter
  '*~'                               # editor/shell backup files
)

for p in "${patterns[@]}"; do
  if grep -qxF -- "$p" "$ignore"; then
    echo "present: $p"
  else
    echo "$p" >> "$ignore"
    echo "added:   $p"
  fi
done

echo "global gitignore: $ignore"
