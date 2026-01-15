#!/usr/bin/env bash
set -e

# Check dependencies
command -v git >/dev/null 2>&1 || { echo "ERROR: git not found"; exit 1; }
command -v tmux >/dev/null 2>&1 || { echo "ERROR: tmux not found"; exit 1; }

INSTALL_DIR="$HOME/.oh-my-tmux"
TPM_DIR="$HOME/.tmux/plugins/tpm"

# Backup existing config
if [[ -f "$HOME/.tmux.conf" ]]; then
  cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
  echo "Backed up existing config to ~/.tmux.conf.backup"
fi

# Clone or update oh-my-tmux
if [[ -d "$INSTALL_DIR/.git" ]]; then
  git -C "$INSTALL_DIR" pull
else
  git clone https://github.com/Sansan4ez/oh-my-tmux.git "$INSTALL_DIR"
fi

# Install config
cp "$INSTALL_DIR/tmux.conf" "$HOME/.tmux.conf"

# Install or update TPM
if [[ -d "$TPM_DIR/.git" ]]; then
  git -C "$TPM_DIR" pull
else
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "Done! Start tmux and press prefix + I to install plugins."

