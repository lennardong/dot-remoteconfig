#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_MIN="0.11"   # config uses the vim.lsp.config/enable API (Nvim 0.11+)

# Architecture → release asset suffixes
case "$(uname -m)" in
  aarch64|arm64) NVIM_ARCH="arm64";  MARKSMAN_ARCH="arm64" ;;
  x86_64|amd64)  NVIM_ARCH="x86_64"; MARKSMAN_ARCH="x64" ;;
  *) echo "unsupported architecture: $(uname -m)"; exit 1 ;;
esac

# --- neovim --------------------------------------------------------------------
# apt ships an old neovim (e.g. 0.10 on Debian/RPi OS); the config needs 0.11+.
# Install the official static tarball to /opt and expose it via /usr/local/bin.
nvim_ok() {
  command -v nvim &>/dev/null || return 1
  local v; v="$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)"
  [ "$(printf '%s\n%s\n' "$NVIM_MIN" "$v" | sort -V | head -1)" = "$NVIM_MIN" ]
}
if ! nvim_ok; then
  echo "installing neovim (latest stable, linux-${NVIM_ARCH})..."
  TARBALL="nvim-linux-${NVIM_ARCH}.tar.gz"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/${TARBALL}" -o "/tmp/${TARBALL}"
  sudo rm -rf "/opt/nvim-linux-${NVIM_ARCH}"
  sudo tar -C /opt -xzf "/tmp/${TARBALL}"
  sudo ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
  rm -f "/tmp/${TARBALL}"
  hash -r
fi

# --- LSP servers + formatters (mason-less; expected on PATH) --------------------
# basedpyright (types) + ruff (lint) drive lsp.lua; mdformat is a conform formatter.
# Installed as isolated uv tools into ~/.local/bin.
if command -v uv &>/dev/null; then
  for tool in ruff basedpyright mdformat; do
    echo "uv tool install ${tool}..."
    uv tool install "$tool"
  done
else
  echo "WARNING: uv not found — skipping ruff/basedpyright/mdformat."
  echo "         Install uv, then: uv tool install ruff basedpyright mdformat"
fi

# marksman (markdown LSP) if missing
if ! command -v marksman &>/dev/null; then
  echo "installing marksman (linux-${MARKSMAN_ARCH})..."
  MARKSMAN_URL="https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-${MARKSMAN_ARCH}"
  sudo curl -fsSL "$MARKSMAN_URL" -o /usr/local/bin/marksman
  sudo chmod +x /usr/local/bin/marksman
fi

# build tools needed by telescope-fzf-native
if ! command -v make &>/dev/null; then
  echo "installing build-essential (needed by telescope-fzf-native)..."
  sudo apt update --quiet && sudo apt install --yes build-essential
fi

mkdir -p "$NVIM_CONFIG"

# --- symlink config ------------------------------------------------------------
symlink_file() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "nvim: symlink already in place → $dst"
  elif [ -e "$dst" ]; then
    echo "nvim: backing up existing $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
    ln --symbolic "$src" "$dst"
    echo "nvim: symlinked $dst"
  else
    ln --symbolic "$src" "$dst"
    echo "nvim: symlinked $dst"
  fi
}

symlink_file "$SCRIPT_DIR/init.lua"        "$NVIM_CONFIG/init.lua"
symlink_file "$SCRIPT_DIR/lua"             "$NVIM_CONFIG/lua"
# lazy-lock.json symlinked too, so plugin versions track the repo (no per-machine drift)
symlink_file "$SCRIPT_DIR/lazy-lock.json"  "$NVIM_CONFIG/lazy-lock.json"

# --- install plugins at the pinned versions ------------------------------------
echo "installing plugins (Lazy restore)..."
nvim --headless "+Lazy! restore" +qa

echo "done. nvim $(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9.]+' | head -1) ready."
