# non-destructive rm via trash-cli
if command -v trash-put &>/dev/null; then
  alias rm='trash-put'

  # auto-purge trashed files older than 90 days (runs at most once per day)
  _trash_stamp="$HOME/.local/state/trash-cleanup-stamp"
  if [ ! -f "$_trash_stamp" ] || \
     [ "$(( $(date +%s) - $(date -r "$_trash_stamp" +%s) ))" -ge 86400 ]; then
    trash-empty 90 &>/dev/null &
    mkdir -p "$(dirname "$_trash_stamp")"
    touch "$_trash_stamp"
  fi
  unset _trash_stamp
fi
