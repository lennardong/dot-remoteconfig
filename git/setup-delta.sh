#!/usr/bin/env bash
# Install git-delta + wire it for side-by-side diffs (git CLI + lazygit). Idempotent.
# lazygit binary itself: see setup-lazygit.sh.
set -euo pipefail

# --- delta: side-by-side pager (Ubuntu/Debian apt) ---
if ! command -v delta >/dev/null 2>&1; then
  echo "installing git-delta..."
  sudo apt-get update -qq
  sudo apt-get install -y git-delta
else
  echo "git-delta present: $(delta --version)"
fi

# --- wire delta into the git CLI (git config overwrites same key -> idempotent) ---
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global delta.navigate true   # n/N jumps between files in the pager

# --- wire delta into lazygit (git.pagers list; lazygit >= ~0.40 schema) ---
# ponytail: create-only. If a config already exists without delta, warn instead of
# merging YAML in bash — point upgrade path is: add the pagers block by hand.
cfg="${HOME}/.config/lazygit/config.yml"
mkdir -p "$(dirname "$cfg")"
if [ ! -f "$cfg" ]; then
  cat > "$cfg" <<'YAML'
# delta as diff pager, side-by-side. --paging=never: lazygit scrolls, not delta.
git:
  pagers:
    - colorArg: always
      pager: delta --dark --paging=never --side-by-side --line-numbers
YAML
  echo "wrote lazygit config: $cfg"
elif ! grep -q delta "$cfg"; then
  echo "WARN: $cfg exists without a delta pager. Add under git.pagers:"
  echo "  - {colorArg: always, pager: delta --dark --paging=never --side-by-side --line-numbers}"
else
  echo "lazygit delta pager already configured"
fi

echo "delta wired. relaunch lazygit; 'git diff' now side-by-side."
