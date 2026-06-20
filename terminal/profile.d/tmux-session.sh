# Bare `tmux` drops into session `main` (create if missing). Args pass through.
tmux() {
  [ $# -gt 0 ] && { command tmux "$@"; return; }
  if [ -n "${TMUX:-}" ]; then
    # already inside tmux: switch instead of nesting an attach
    command tmux new-session -d -s main 2>/dev/null
    command tmux switch-client -t main
  else
    command tmux new-session -A -s main
  fi
}
