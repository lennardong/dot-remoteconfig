#!/usr/bin/env bash
# Wire the shell rc files to source ~/.config-remote/terminal/profile.d/*.sh.
# Handles bash (.bashrc) and zsh (.zshrc). Idempotent — safe to re-run.
# The snippets are portable shell, so the same loop works in both shells.
set -euo pipefail

BEGIN="# >>> config-remote terminal snippets >>>"
END="# <<< config-remote terminal snippets <<<"
BLOCK="${BEGIN}
for f in \"\$HOME/.config-remote/terminal/profile.d/\"*.sh; do
  [ -r \"\$f\" ] && . \"\$f\"
done
${END}"

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
  [ -e "$rc" ] || continue   # only wire shells the user actually has
  if grep -qF "$BEGIN" "$rc"; then
    echo "already wired: $rc"
  else
    printf '\n%s\n' "$BLOCK" >> "$rc"
    echo "wired: $rc"
  fi
done

echo "shell wiring done. open a new shell (or source the rc) to pick it up."
