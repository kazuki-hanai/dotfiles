# dotfiles

mise-based dotfiles for **macOS and Ubuntu**. `mise.toml` is the single entry
point: it declares runtimes, dev tools, dotfile symlinks, macOS defaults, and
the provisioning tasks. Neovim, tmux, and my own tools (hjkl, aizu) are built
from source.

## Requirements

- macOS (Apple Silicon) or Ubuntu.
- Internet access. On Ubuntu, a user with `sudo` (or run as root).
- Nothing else preinstalled — `install.sh` bootstraps the base tooling
  (Homebrew on macOS, `git`/`curl` on Ubuntu) and mise.

Provisioning is idempotent: re-running `./up` only changes what is out of date,
so it is safe to run again anytime.

## Quick start

On a brand-new machine, one command bootstraps the base tooling, clones this
repo to `~/.dotfiles`, and provisions everything:

```bash
curl -fsSL https://raw.githubusercontent.com/kazuki-hanai/dotfiles/main/install.sh | bash
```

If the repo is already cloned, run the bootstrap from inside it:

```bash
cd ~/.dotfiles
./up              # run the full setup
./up <task>       # or run a single task, e.g. ./up link
```

## Tasks

`./up` runs `mise run setup`, which executes these sub-tasks in order:

| # | Task | What it does |
| --- | --- | --- |
| 1 | `packages` | System packages (Brewfile on macOS / `packages/apt.txt` on Ubuntu) |
| 2 | `tools` | `mise install` — runtimes & CLI dev tools |
| 3 | `nvim-build` | Build Neovim from source into `~/.local` |
| 4 | `tmux-build` | Build tmux from source into `~/.local` |
| 5 | `hjkl` | Build/install the hjkl keyboard remapper (**macOS only**) |
| 6 | `aizu` | Build/install the Aizu notification app (**macOS only**) |
| 7 | `link` | Symlink dotfiles (`mise bootstrap dotfiles apply`) |
| 8 | `defaults` | Login shell (Unix) + macOS defaults (**macOS only**) |
| 9 | `vim` | Install/sync Neovim (lazy.nvim) plugins |

Run any single task with `./up <task>` (e.g. `./up hjkl`, `./up nvim-build`) or
`mise run <task>`. List them with `mise tasks`. macOS-only tasks self-skip on
Ubuntu.

## After installing

A few steps need manual follow-up:

- **New shell:** the login shell is set to `/bin/zsh`, but it only takes effect
  after you log out and back in (or `exec zsh` for the current session).
- **hjkl (macOS):** grant Accessibility permission to `~/.local/bin/hjkl` under
  System Settings → Privacy & Security → Accessibility, then `hjkl restart`.
  Manage it with `hjkl status | start | stop | enable | disable`.
- **aizu (macOS):** open `/Applications/Aizu.app` and complete the first-run
  setup to connect Codex / Claude Code.

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
| `scripts/test-clean-ubuntu.sh` | Provision this repo in a throwaway Ubuntu container to test the Linux path. |

## Managing things

- Add/upgrade a runtime or CLI tool: edit `[tools]` in `mise.toml` (or `mise use <tool>@<version>`).
- Add a macOS package/app: edit `Brewfile`. Add an Ubuntu package: edit `packages/apt.txt`.
- Add a dotfile symlink: edit `[dotfiles]` in `mise.toml`, then `./up link`.
- Change a source-build ref: e.g. `NVIM_REF=v0.10.2 ./up nvim-build`, `HJKL_REF=main ./up hjkl`.
- The source-build tasks (`nvim-build`, `tmux-build`, `hjkl`, `aizu`) skip when
  the tool is already installed. Force a rebuild with `FORCE=1`, e.g.
  `FORCE=1 ./up hjkl` or `FORCE=1 ./up nvim-build`.
- Machine-local, untracked overrides: `~/.localconfig.sh` (env/PATH) and
  `~/.prezshrc` (loaded before everything) are sourced if present.

## Testing in a clean environment

Verify the Ubuntu path end-to-end in a throwaway container (needs Docker or
Podman):

```bash
./scripts/test-clean-ubuntu.sh                          # full ./up
./scripts/test-clean-ubuntu.sh packages tools link defaults   # fast subset
```

The repo is copied into the container, so host files are never modified. A
`GITHUB_TOKEN` (or `gh auth token`) is forwarded automatically to avoid GitHub
API rate limits while resolving tool versions.

## Notes

- `~/.dotfiles/mise.toml` is used as the global mise config
  (`MISE_GLOBAL_CONFIG_FILE`), so the same runtimes/tools are available
  everywhere; project-local `mise.toml` files still take precedence in their
  own directories.
- `tokei` is built via `cargo` (no linux-arm64 prebuilt); the Rust toolchain is
  declared in `[tools]` so a clean machine can build it.
