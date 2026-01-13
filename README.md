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

## 🧠 Architecture & UX Philosophy

This tmux configuration follows a clear, intentional hierarchy to reduce cognitive load and keep context visible at the right level.

### The Three-Level Model

tmux is structured around **three distinct entities**, each with its own role, lifespan, and UI representation:

### 1️⃣ Session — *Long-lived purpose*

* **What it represents:**
  A long-running context or goal (e.g. `work`, `infra`, `client-x`, `prod`)
* **Lifetime:**
  Hours or days
* **UI location:**
  Status bar (left)
* **Why:**
  Sessions change rarely and should always be visible, but not demand attention.

### 2️⃣ Window — *Primary working context*

* **What it represents:**
  What you are working on right now:
  * a project directory
  * an SSH host
  * a service (`api`, `db`, `docs`)
* **Lifetime:**
  Medium — frequently switched
* **UI location:**
  Status bar tabs
* **Why:**
  Windows are the main navigation unit in tmux and must always be visible and easy to scan.

Window names are **explicit and stable** (auto-renaming is disabled) and should answer the question:
*“What is this tab about?”*

### 3️⃣ Pane — *Short-lived operational role*

* **What it represents:**
  The role of a specific split inside a window:
  * `editor`
  * `logs`
  * `server`
  * `shell`
* **Lifetime:**
  Short — created and destroyed often
* **UI location:**
  Pane borders (local to the window)
* **Why:**
  Pane information is only relevant **inside its window** and should not pollute the global status bar.

Pane titles are shown directly in the pane border, providing immediate local context without visual noise.

## 🎯 Design Principles

* **Each entity has exactly one place in the UI**
* **No global UI element shows local-only information**
* **Context is visible where it matters, invisible where it doesn’t**
* **Fast navigation first, discoverability on demand**

This mirrors the mental model of experienced terminal users while remaining friendly to newcomers.

### Summary

| Entity  | Answers the question       | Visible where     |
| ------- | -------------------------- | ----------------- |
| Session | *Why am I here?*           | Status bar (left) |
| Window  | *What am I working on?*    | Status bar tabs   |
| Pane    | *What is this part doing?* | Pane border       |

