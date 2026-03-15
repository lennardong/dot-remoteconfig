# fzf — fuzzy finder (installed via ~/.fzf)
# keybindings: Ctrl-R (history), Ctrl-T (files), Alt-C (cd)
# **<tab> fuzzy path completion
export PATH="$HOME/.fzf/bin:$PATH"
eval "$(fzf --bash)"

# use fd as file source (fast, respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory --hidden --exclude .git'

# preview: bat for files (Ctrl-T), tree for dirs (Alt-C)
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}'"
export FZF_ALT_C_OPTS="--preview 'ls --color=always {}'"
