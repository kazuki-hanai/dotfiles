# dotfiles

mise-based dotfiles for **macOS and Ubuntu**. `mise.toml` is the single entry
point: it declares runtimes, dev tools, dotfile symlinks, macOS defaults, and
the provisioning tasks. Neovim, tmux, and my own tools (hjkl, aizu) are built
from source.

## Installation

On a brand-new machine, one command bootstraps the base tooling, clones this
repo, and provisions everything:

```bash
curl -fsSL https://raw.githubusercontent.com/kazuki-hanai/dotfiles/main/install.sh | bash
```

- macOS: installs Homebrew (which pulls in the Command Line Tools).
- Ubuntu: installs `git`/`curl` via apt.

If the repo is already cloned, run the bootstrap from inside it:

```bash
cd ~/.dotfiles
./up            # run the full setup
./up link       # or run a single task (see below)
```

## Layout

| Path | Role |
| --- | --- |
| `install.sh` | curl one-liner for a bare machine (base tooling → clone → `up`). |
| `up` | Ensures the package manager + mise, `mise trust`, then runs mise tasks. |
| `mise.toml` | Runtimes, dev tools, dotfile links, macOS defaults, tasks. |
| `Brewfile` | macOS system packages, casks, and build deps (`brew bundle`). |
| `packages/apt.txt` | Ubuntu system packages and build deps (`apt-get`). |
| `shell/env.sh` | Activates mise in interactive shells (sourced from `zsh/zshrc`). |
| `scripts/install-packages` | OS-aware system package install (Brewfile / apt). |
| `scripts/build-neovim` | Build Neovim from source into `~/.local`. |
| `scripts/build-tmux` | Build tmux from source into `~/.local`. |
| `scripts/build-hjkl` | Build/install [hjkl](https://github.com/kazuki-hanai/hjkl) (macOS keyboard remapper, replaces Karabiner). |
| `scripts/build-aizu` | Build/install [aizu](https://github.com/kazuki-hanai/aizu) (macOS notification app). |
| `scripts/setup-vim` | Install/sync Neovim (lazy.nvim) plugins headlessly. |

## Tasks

`./up` runs `mise run setup`, which executes these sub-tasks in order:

1. `packages` — system packages (Brewfile on macOS / `apt.txt` on Ubuntu)
2. `tools` — `mise install` (runtimes & dev tools)
3. `nvim-build` — build Neovim from source
4. `tmux-build` — build tmux from source
5. `hjkl` — build/install the hjkl keyboard remapper (macOS only)
6. `aizu` — build/install the Aizu notification app (macOS only)
7. `link` — symlink dotfiles (`mise bootstrap dotfiles apply`)
8. `defaults` — login shell (Unix) + macOS defaults (macOS only)
9. `vim` — Neovim plugins

Run any single task with `./up <task>` (e.g. `./up hjkl`, `./up nvim-build`) or
`mise run <task>`. List them with `mise tasks`.

macOS-only tasks (`hjkl`, `aizu`, macOS `defaults`) self-skip on Ubuntu.

## Managing things

- Add/upgrade a runtime or CLI tool: edit `[tools]` in `mise.toml` (or `mise use <tool>@<version>`).
- Add a macOS package/app: edit `Brewfile`. Add an Ubuntu package: edit `packages/apt.txt`.
- Add a dotfile symlink: edit `[dotfiles]` in `mise.toml`, then `./up link`.
- Change the source-build ref: e.g. `NVIM_REF=v0.10.2 ./up nvim-build`, `HJKL_REF=main ./up hjkl`.
