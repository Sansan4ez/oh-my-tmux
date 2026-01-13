# oh-my-tmux

A friendly, modern tmux setup inspired by LazyVim and Zellij.

## Features
- IDE-like status bar (git, host, cpu, time)
- which-key menus (`prefix + Space`)
- mouse support
- session restore
- Catppuccin theme
- macOS & SSH friendly

## Install (macOS)
```bash
brew install tmux
git clone https://github.com/yourname/oh-my-tmux.git
cp oh-my-tmux/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux kill-server
tmux
```

## Inside tmux:
For install plugins press:
'prefix + I'

For which-key press:
'prefix + Space'

## Docs
See docs/ for details.
