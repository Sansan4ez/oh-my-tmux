#!/usr/bin/env bash
set -euo pipefail

REPO_DEFAULT="https://github.com/Sansan4ez/oh-my-tmux.git"
BRANCH_DEFAULT="main"

REPO="${REPO:-$REPO_DEFAULT}"
BRANCH="${BRANCH:-$BRANCH_DEFAULT}"

TARGET_CONF="${TARGET_CONF:-$HOME/.tmux.conf}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.tmux-backups}"
TPM_DIR="${TPM_DIR:-$HOME/.tmux/plugins/tpm}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.oh-my-tmux}"

say() { printf "%s\n" "$*"; }
die() { printf "ERROR: %s\n" "$*" >&2; exit 1; }

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Command not found: $1"
}

is_macos() { [[ "${OSTYPE:-}" == "darwin"* ]]; }

say "==> oh-my-tmux installer"
need_cmd git

# tmux check (install if possible on macOS)
if ! command -v tmux >/dev/null 2>&1; then
  if [[ "${OSTYPE:-}" == "darwin"* ]]; then
    if command -v brew >/dev/null 2>&1; then
      say "==> tmux not found; installing via Homebrew..."
      brew install tmux
    else
      die "tmux not found. Please install Homebrew or tmux manually."
    fi
  else
    die "tmux not found.
Please install tmux using your package manager, for example:
  Debian/Ubuntu: sudo apt install tmux
  Fedora:        sudo dnf install tmux
  Arch:          sudo pacman -S tmux
Then re-run this script."
  fi
fi

TMUX_VER="$(tmux -V | awk '{print $2}')"
say "==> tmux version: ${TMUX_VER}"

# Ensure install dir
mkdir -p "$INSTALL_DIR"
mkdir -p "$BACKUP_DIR"

# Clone/update repo
if [[ -d "$INSTALL_DIR/.git" ]]; then
  say "==> Updating existing repo at $INSTALL_DIR"
  git -C "$INSTALL_DIR" fetch --all --prune
  git -C "$INSTALL_DIR" checkout "$BRANCH"
  git -C "$INSTALL_DIR" pull --ff-only
else
  say "==> Cloning $REPO into $INSTALL_DIR"
  git clone --branch "$BRANCH" --depth 1 "$REPO" "$INSTALL_DIR"
fi

# Backup existing tmux.conf if present
if [[ -f "$TARGET_CONF" ]]; then
  TS="$(date +%Y%m%d-%H%M%S)"
  BK="$BACKUP_DIR/tmux.conf.$TS"
  say "==> Backing up existing $TARGET_CONF to $BK"
  cp -a "$TARGET_CONF" "$BK"
fi

# Install config
if [[ ! -f "$INSTALL_DIR/tmux.conf" ]]; then
  die "tmux.conf not found in repo root: $INSTALL_DIR/tmux.conf"
fi

say "==> Installing tmux.conf to $TARGET_CONF"
cp -a "$INSTALL_DIR/tmux.conf" "$TARGET_CONF"

# Install TPM
if [[ -d "$TPM_DIR/.git" ]]; then
  say "==> Updating TPM at $TPM_DIR"
  git -C "$TPM_DIR" pull --ff-only || true
else
  say "==> Installing TPM into $TPM_DIR"
  mkdir -p "$(dirname "$TPM_DIR")"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Restart tmux server if running
if tmux ls >/dev/null 2>&1; then
  say "==> Restarting tmux server (kill-server) to apply config cleanly"
  tmux kill-server || true
fi

say "==> Done."
say "Next steps:"
say "  1) Start tmux: tmux"
say "  2) Install plugins inside tmux: prefix + I"
say ""
say "Tip (safe review): you can inspect the script before running it."

