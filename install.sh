#!/usr/bin/env bash
# =============================================================================
# install.sh - one-line bootstrap for a fresh machine (macOS or Ubuntu).
#
#   curl -fsSL https://raw.githubusercontent.com/kazuki-hanai/dotfiles/main/install.sh | bash
#
# macOS : installs Homebrew (which pulls in the Command Line Tools, so `git`
#         becomes available), clones this repo, then runs `./up`.
# Ubuntu: installs git/curl via apt, clones this repo, then runs `./up`.
# =============================================================================
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/kazuki-hanai/dotfiles.git}"
DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

bootstrap_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    # Homebrew installs the Command Line Tools if missing, so no separate
    # `xcode-select --install` step is needed. NONINTERACTIVE avoids the
    # confirmation prompt that would block a `curl | bash` run.
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

bootstrap_ubuntu() {
  local SUDO=""
  if [ "$(id -u)" -ne 0 ]; then
    command -v sudo >/dev/null 2>&1 || { echo "need root or sudo on Ubuntu" >&2; exit 1; }
    SUDO="sudo"
  fi
  $SUDO apt-get update
  DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y git curl ca-certificates
}

clone_or_update_repo() {
  if [ -d "$DOTFILES_PATH/.git" ]; then
    git -C "$DOTFILES_PATH" pull --ff-only
  else
    git clone "$DOTFILES_REPO" "$DOTFILES_PATH"
  fi
}

main() {
  case "$(uname -s)" in
    Darwin) bootstrap_macos ;;
    Linux)
      if [ -e /etc/lsb-release ] || command -v apt-get >/dev/null 2>&1; then
        bootstrap_ubuntu
      else
        echo "Unsupported Linux distro (expected Ubuntu/apt)." >&2
        exit 1
      fi
      ;;
    *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
  esac

  clone_or_update_repo
  exec "$DOTFILES_PATH/up"
}

main "$@"
