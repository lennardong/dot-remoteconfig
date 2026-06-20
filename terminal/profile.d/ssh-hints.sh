# cheatsheet and tmux session hint on SSH login
if [ -n "$SSH_TTY" ] && [ -z "$TMUX" ]; then
  cd ~/lumigaia

  echo "fzf:  Ctrl-R history | Ctrl-T files | Alt-C cd | cmd path/**<tab>"
  echo "tmux: Ctrl-b d detach | Ctrl-b c new window | Ctrl-b n/p next/prev"
  echo ""

  if command -v tmux &>/dev/null; then
    sessions=$(tmux ls 2>/dev/null)
    if [ -n "$sessions" ]; then
      echo "--- tmux sessions ---"
      echo "$sessions"
      echo ""
      echo "  tmux attach-session -t <name>"
    else
      echo "no tmux sessions. start one: tmux new-session -s <name>"
    fi
  fi
fi
