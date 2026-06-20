#!/usr/bin/env bash
# Install pylatexenc via uv — provides the `latex2text` CLI that render-markdown.nvim
# shells out to for inline LaTeX ($..$, $$..$$) → unicode in the buffer. Idempotent.
set -euo pipefail

if command -v latex2text >/dev/null 2>&1; then
  echo "latex2text present: $(command -v latex2text)"
  exit 0
fi

command -v uv >/dev/null 2>&1 || { echo "uv not found — install uv first" >&2; exit 1; }

echo "installing pylatexenc (latex2text)..."
uv tool install pylatexenc
echo "latex2text installed: $(command -v latex2text)"
