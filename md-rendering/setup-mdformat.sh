#!/usr/bin/env bash
#
# setup-mdformat.sh — install mdformat with the math-preserving plugin set.
#
# What:       `uv tool install --force mdformat` with the gfm, frontmatter, and
#             dollarmath plugins. dollarmath is the critical one — it teaches mdformat
#             to recognise $..$/$$..$$ math and leave it verbatim. Stock mdformat
#             escapes LaTeX backslashes (\beta -> \\beta) on every format-on-save,
#             silently breaking math rendering.
# Idempotent: exits early if `mdformat` already reports the dollarmath plugin; otherwise
#             reinstalls (--force) to add the plugins to its tool venv.
# Requires:   uv (fail-fast if missing).
# Usage:      ./setup-mdformat.sh   (or via ./run-setups.sh)
#
set -euo pipefail

if command -v mdformat >/dev/null 2>&1 && mdformat --version 2>&1 | grep -q dollarmath; then
  echo "mdformat present with dollarmath: $(mdformat --version)"
  exit 0
fi

command -v uv >/dev/null 2>&1 || { echo "uv not found — install uv first" >&2; exit 1; }

# --force: reinstall over any existing plugin-less mdformat to add the plugins to its venv.
echo "installing mdformat + plugins (gfm, frontmatter, dollarmath)..."
uv tool install --force mdformat \
  --with mdformat-gfm \
  --with mdformat-frontmatter \
  --with mdformat-dollarmath
echo "mdformat installed: $(mdformat --version)"
