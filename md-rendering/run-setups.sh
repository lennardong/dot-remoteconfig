#!/usr/bin/env bash
# Run all markdown-rendering tooling setups in order. Each is idempotent, so re-running is safe.
# Pairs with render-markdown.nvim (nvim/) + the mdformat conform formatter to make
# in-buffer LaTeX render and survive format-on-save. This script only handles the CLI
# tools (latex2text + mdformat plugins) — render-markdown ALSO needs the `latex`
# tree-sitter parser, so "latex" must be in nvim's treesitter install list (nvim/).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for s in setup-pylatexenc setup-mdformat; do
  echo "=== ${s} ==="
  "${here}/${s}.sh"
done

echo "all md-rendering setups done."
