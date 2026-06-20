#!/usr/bin/env bash
# Shared helpers for setup-*.sh. Source, don't execute. Cross-platform: Debian + macOS.

# Echo "macos" or "debian". Fail-fast on anything else (these scripts assume one of the two).
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        echo "debian"
      else
        echo "ERROR: Linux without apt-get. Supported: Debian/Ubuntu, macOS." >&2
        return 1
      fi
      ;;
    *) echo "ERROR: unsupported OS '$(uname -s)'. Supported: Debian/Ubuntu, macOS." >&2; return 1 ;;
  esac
}

# uname arch -> Go release naming used by GitHub binary assets. x86_64 / arm64.
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64) echo "x86_64" ;;
    arm64|aarch64) echo "arm64" ;;
    *) echo "ERROR: unsupported arch '$(uname -m)'." >&2; return 1 ;;
  esac
}

# require_brew: ensure Homebrew present on macOS, else fail-fast with install pointer.
require_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: Homebrew not found. Install: https://brew.sh" >&2
    return 1
  fi
}
