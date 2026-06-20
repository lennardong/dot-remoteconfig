#!/usr/bin/env bash
#
# setup-pylatexenc.sh — install the latex2text CLI (via pylatexenc).
#
# What:       `uv tool install pylatexenc`, putting `latex2text` on PATH (~/.local/bin).
#             render-markdown.nvim shells out to it to convert inline LaTeX
#             ($..$, $$..$$) into unicode for in-buffer display.
# Idempotent: exits early if `latex2text` is already on PATH; installs only when absent.
# Requires:   uv (fail-fast if missing).
# Usage:      ./setup-pylatexenc.sh   (or via ./run-setups.sh)
#
set -euo pipefail

if command -v latex2text >/dev/null 2>&1; then
  echo "latex2text present: $(command -v latex2text)"
  exit 0
fi

command -v uv >/dev/null 2>&1 || { echo "uv not found — install uv first" >&2; exit 1; }

echo "installing pylatexenc (latex2text)..."
uv tool install pylatexenc
echo "latex2text installed: $(command -v latex2text)"
