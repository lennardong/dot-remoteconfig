# config-remote

Terminal ergonomics for remote WSL2/SSH machines and macOS. Designed for Ghostty + tmux + Neovim over SSH.

## What's included

| Module | What it does |
|--------|-------------|
| **terminal/** | Shell snippets sourced by bash + zsh — fzf, editor default, SSH hints, `tmux` → session `main` |
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
~/.config-remote/terminal/run-setups.sh        # installs tools (apt) + wires bash/zsh
~/.config-remote/tmux/run-setups.sh
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
| `terminal/run-setups.sh` | fzf, fd, bat, ripgrep, trash-cli (apt; skipped off Debian) | Wires `terminal/profile.d/*.sh` into `.bashrc` + `.zshrc` |
| `tmux/run-setups.sh` | tmux (apt; skipped off Debian) | `~/.tmux.conf`, +x on `tmux-worktree` |
| `nvim/install-debian.sh` | neovim, marksman, build-essential | `~/.config/nvim/init.lua`, `~/.config/nvim/lua/` |
| `nvim/install-osx.sh` | neovim, basedpyright, ruff, marksman | `~/.config/nvim/init.lua`, `~/.config/nvim/lua/` |
| `vim/install-debian.sh` | vim | `~/.vimrc` |

All symlink scripts back up existing files to `*.bak` before overwriting.

## Structure

```
~/.config-remote/
  install-debian.sh       # top-level Debian/Ubuntu installer
  install-macos.sh        # top-level macOS installer
  terminal/
    run-setups.sh         # orchestrator: runs every setup-*.sh (idempotent)
    setup-fzf.sh          # apt install fzf
    setup-fd.sh           # apt fd-find + symlink fdfind -> fd
    setup-bat.sh          # apt bat + symlink batcat -> bat
    setup-trash.sh        # apt trash-cli
    setup-ripgrep.sh      # apt ripgrep
    setup-shell.sh        # wires profile.d/*.sh into .bashrc + .zshrc
    profile.d/            # sourced at shell startup (bash + zsh)
      editor.sh           # EDITOR=nvim
      fzf.sh              # fzf keybindings (bash/zsh), fd integration, bat preview
      trash.sh            # rm -> trash-put, 90-day auto-purge
      ssh-hints.sh        # tmux session hints on SSH login
      tmux-session.sh     # bare `tmux` -> attach/create session `main`
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
    run-setups.sh         # orchestrator: runs every setup-*.sh (idempotent)
    setup-debian.sh       # apt install tmux
    setup-tmux.sh         # symlink ~/.tmux.conf -> tmux.conf
    setup-worktreesession.sh # chmod +x tmux-worktree
    tmux.conf             # Ctrl-Space prefix, OSC 52, true color, extended keys, mouse
    tmux-worktree         # one session, one window per worktree (prefix + S)
  vim/
    install-debian.sh     # installs vim, symlinks vimrc
    vimrc                 # minimal fallback config
```
