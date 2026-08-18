# =============================================================================
# Brewfile - macOS system packages, GUI apps, and build dependencies.
#
# Language runtimes and dev tools live in mise.toml ([tools]). Neovim and tmux
# are built from source (see scripts/build-neovim, scripts/build-tmux), so this
# file provides their build dependencies rather than the tools themselves.
# Applied on macOS via `scripts/install-packages` (the `packages` mise task).
# Ubuntu uses packages/apt.txt instead.
# =============================================================================

# --- System CLIs ---
brew "mise"
brew "gh"
brew "gnupg"
brew "kubernetes-cli"
brew "pipx"
brew "protobuf"
brew "zizmor"
brew "cloudflared"
brew "gogcli"

# --- Build dependencies (Neovim) ---
brew "cmake"
brew "ninja"
brew "gettext"
brew "pkg-config"
brew "luajit"

# --- Build dependencies (tmux) ---
brew "libevent"
brew "ncurses"
brew "jemalloc"
brew "automake"
brew "autoconf"
brew "bison"
brew "reattach-to-user-namespace"   # tmux clipboard helper on macOS

# --- Casks (GUI apps) ---
cask "aqua-app"
cask "gcloud-cli"
cask "raycast"

# --- Fonts ---
# Already installed manually on this machine (a differing Hack Nerd Font in
# ~/Library/Fonts makes `brew bundle` fail when it tries to adopt it). Enable on
# a fresh machine, or run: brew install --cask --force font-hack-nerd-font
# cask "font-hack-nerd-font"
