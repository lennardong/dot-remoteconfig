# config-remote

Terminal ergonomics for remote WSL2/SSH machines and macOS. Designed for Ghostty + tmux + Neovim over SSH.

## What's included

| Module | What it does |
|--------|-------------|
| **bash/** | Shell snippets sourced from `.bashrc` — fzf config, editor default, SSH login hints |
| **nvim/** | Neovim config with lazy.nvim, Dracula theme, LSP, Telescope, Treesitter, Oil |
| **tmux/** | tmux config — Ctrl-Space prefix, OSC 52 clipboard passthrough, true color, extended keys (CSI u) |
| **vim/** | Minimal `.vimrc` fallback |

## Quick start

### Debian/Ubuntu (remote machines)

```bash
git clone <repo-url> ~/.config-remote
~/.config-remote/install-debian.sh
```

### macOS

```bash
git clone <repo-url> ~/.config-remote
~/.config-remote/install-macos.sh
```

macOS install symlinks tmux.conf and vimrc. Packages (tmux, nvim, etc.) managed separately via Homebrew.

For nvim on macOS:

```bash
~/.config-remote/nvim/install-osx.sh
```

### Individual modules

```bash
# Debian/Ubuntu
~/.config-remote/bash/install-debian.sh
~/.config-remote/tmux/install-debian.sh
~/.config-remote/nvim/install-debian.sh
~/.config-remote/vim/install-debian.sh

# macOS
~/.config-remote/nvim/install-osx.sh
```

## Post-install

### Ghostty terminfo (one-time, from local machine)

Remote needs `xterm-ghostty` terminfo so `TERM=xterm-ghostty` works over SSH.
Run **from your local Ghostty terminal**:

```bash
infocmp -x xterm-ghostty | ssh <remote-host> 'tic -x -'
```

### tmux prefix: Ctrl-Space

Prefix is `Ctrl-Space` (not default `Ctrl-b`). If it doesn't work:

1. **macOS** — System Settings > Keyboard > Keyboard Shortcuts > Input Sources > disable `^Space` (input source toggle steals the key)
2. **Config not loaded** — tmux only reads config on server start. Either:
   - `tmux source-file ~/.tmux.conf` (reload in running session)
   - `tmux kill-server && tmux` (restart server)
3. **Verify** — `tmux show -g prefix` should show `C-Space`

### nvim plugins

First launch of nvim auto-installs plugins via lazy.nvim. Wait for install to finish, then restart nvim.

## What the install scripts do

| Script | Installs | Symlinks |
|--------|----------|----------|
| `install-debian.sh` | Runs all Debian module scripts below | — |
| `install-macos.sh` | — | `~/.tmux.conf`, `~/.vimrc` |
| `bash/install-debian.sh` | fzf, fd, bat, ripgrep, trash-cli | Sources `bash/*.bash` from `.bashrc` |
| `tmux/install-debian.sh` | tmux | `~/.tmux.conf` |
| `nvim/install-debian.sh` | neovim, marksman, build-essential | `~/.config/nvim/init.lua`, `~/.config/nvim/lua/` |
| `nvim/install-osx.sh` | neovim, basedpyright, ruff, marksman | `~/.config/nvim/init.lua`, `~/.config/nvim/lua/` |
| `vim/install-debian.sh` | vim | `~/.vimrc` |

All symlink scripts back up existing files to `*.bak` before overwriting.

## Structure

```
~/.config-remote/
  install-debian.sh       # top-level Debian/Ubuntu installer
  install-macos.sh        # top-level macOS installer
  bash/
    install-debian.sh     # installs fzf, fd, bat, rg; sources *.bash from .bashrc
    editor.bash           # EDITOR=nvim
    fzf.bash              # fzf keybindings, fd integration, bat preview
    ssh-hints.bash        # tmux session hints on SSH login
  nvim/
    install-debian.sh     # installs neovim, symlinks config
    install-osx.sh        # installs neovim + LSPs via brew/uv, symlinks config
    init.lua              # entry point — OSC 52 clipboard, lazy.nvim bootstrap
    lua/
      config/
        options.lua       # shared options (leader, relative numbers, wrap, etc.)
        vscode.lua        # VSCode-specific overrides
      plugins/            # lazy.nvim plugin specs
  tmux/
    install-debian.sh     # installs tmux, symlinks tmux.conf
    tmux.conf             # Ctrl-Space prefix, OSC 52, true color, extended keys, mouse
    tmux-sessionizer      # fuzzy repo picker (prefix + f)
  vim/
    install-debian.sh     # installs vim, symlinks vimrc
    vimrc                 # minimal fallback config
```
