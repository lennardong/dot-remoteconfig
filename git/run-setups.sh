#!/usr/bin/env bash
# Run all git tooling setups in order. Each is idempotent, so re-running is safe.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for s in setup-lazygit setup-delta setup-difftool-fallback setup-globalignores; do
  echo "=== ${s} ==="
  "${here}/${s}.sh"
done

echo "all git setups done."
