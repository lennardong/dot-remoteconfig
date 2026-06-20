#!/usr/bin/env bash
#
# run-setups.sh — runner for the markdown-rendering tooling setups.
#
# What:       executes each setup-*.sh in order (latex2text CLI, then mdformat+plugins).
#             Each is idempotent, so re-running is safe.
# Why:        pairs with render-markdown.nvim (nvim/) + the mdformat conform formatter
#             to make in-buffer LaTeX render and survive format-on-save.
# Scope:      CLI tools only (latex2text + mdformat plugins). render-markdown ALSO needs
#             the `latex` tree-sitter parser, so "latex" must be in nvim's treesitter
#             install list (nvim/) — not handled here.
# Usage:      ./run-setups.sh
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for s in setup-pylatexenc setup-mdformat; do
  echo "=== ${s} ==="
  "${here}/${s}.sh"
done

echo "all md-rendering setups done."
