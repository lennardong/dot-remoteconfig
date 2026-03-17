# config-remote

Terminal ergonomics for remote WSL2/SSH machines. Designed for Ghostty + tmux + Neovim over SSH.

## What's included

| Module | What it does |
|--------|-------------|
| **bash/** | Shell snippets sourced from `.bashrc` — fzf config, editor default, SSH login hints |
| **nvim/** | Neovim config with lazy.nvim, Dracula theme, LSP, Telescope, Treesitter, Oil |
| **tmux/** | tmux config — OSC 52 clipboard passthrough, true color, extended keys (CSI u) |
| **vim/** | Minimal `.vimrc` fallback |

## Prerequisites

- A Debian/Ubuntu remote machine (install scripts use `apt`)
- [Ghostty](https://ghostty.org/) terminal (for proper `xterm-ghostty` terminfo)

### Ghostty terminfo (one-time, from local machine)

The remote needs the `xterm-ghostty` terminfo so that `TERM=xterm-ghostty` works over SSH.
Run this **from your local Ghostty terminal**:

```bash
infocmp -x xterm-ghostty | ssh <remote-host> 'tic -x -'
```

## Install

Clone the repo and run the top-level install script:

```bash
git clone <repo-url> ~/.config-remote
~/.config-remote/install.sh
```

Or run individual modules:

```bash
~/.config-remote/bash/install.sh
~/.config-remote/tmux/install.sh
~/.config-remote/nvim/install.sh
~/.config-remote/vim/install.sh
```

## Structure

```
~/.config-remote/
  bash/
    install.sh          # installs fzf, fd, bat, rg; sources *.bash from .bashrc
    editor.bash         # EDITOR=nvim
    fzf.bash            # fzf keybindings, fd integration, bat preview
    ssh-hints.bash      # tmux session hints on SSH login
  nvim/
    install.sh          # installs neovim, symlinks config to ~/.config/nvim
    init.lua            # entry point — OSC 52 clipboard, lazy.nvim bootstrap
    lua/
      config/
        options.lua     # shared options (leader, relative numbers, wrap, etc.)
        vscode.lua      # VSCode-specific overrides
      plugins/          # lazy.nvim plugin specs
  tmux/
    install.sh          # installs tmux, symlinks tmux.conf
    tmux.conf           # OSC 52, true color, extended keys, mouse
  vim/
    install.sh          # installs vim, symlinks vimrc
    vimrc               # minimal fallback config
```
