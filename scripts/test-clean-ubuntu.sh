#!/usr/bin/env bash
# =============================================================================
# test-clean-ubuntu.sh - provision this dotfiles repo in a throwaway Ubuntu
# container to verify the Ubuntu code path end-to-end.
#
#   scripts/test-clean-ubuntu.sh                 # full `./up` (setup)
#   scripts/test-clean-ubuntu.sh packages tools link defaults   # fast subset
#
# The repo is copied into the container (host files are never modified).
# macOS-only tasks (hjkl, aizu, macOS defaults) self-skip on Linux.
# =============================================================================
set -euo pipefail

DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="${TEST_IMAGE:-ubuntu:24.04}"

# Pick an available container runtime (docker or podman).
RUNTIME=""
for c in docker podman nerdctl; do
  if command -v "$c" >/dev/null 2>&1; then RUNTIME="$c"; break; fi
done
[ -n "$RUNTIME" ] || { echo "no container runtime found (docker/podman/nerdctl)" >&2; exit 1; }

echo ">> runtime: $RUNTIME   image: $IMAGE"
echo ">> tasks:   ${*:-setup (full)}"

# Forward a GitHub token if available so mise does not hit the unauthenticated
# GitHub API rate limit (403) while resolving aqua/github tool versions.
GH_TOKEN_VALUE="${GITHUB_TOKEN:-$(gh auth token 2>/dev/null || true)}"

"$RUNTIME" run --rm -i \
  -v "$DOTFILES_PATH":/src:ro \
  -e DOTFILES_PATH=/root/.dotfiles \
  -e DEBIAN_FRONTEND=noninteractive \
  -e GITHUB_TOKEN="$GH_TOKEN_VALUE" \
  -e MISE_GITHUB_TOKEN="$GH_TOKEN_VALUE" \
  "$IMAGE" bash -lc '
    set -euo pipefail
    echo "==> copying repo into container"
    cp -a /src /root/.dotfiles
    cd /root/.dotfiles
    echo "==> running ./up '"$*"'"
    ./up '"$*"'
    echo "==> verifying results"
    export PATH="$HOME/.local/bin:$PATH"
    eval "$(mise activate bash)" || true
    echo "-- mise ls --"; mise ls --current || true
    echo "-- versions --"
    for b in node nvim tmux rg bat eza tokei delta dust zoxide fzf; do
      printf "%-7s " "$b"; (command -v "$b" >/dev/null 2>&1 && "$b" --version 2>&1 | head -1) || echo "(missing)"
    done
    for b in go gopls; do printf "%-7s " "$b"; command -v "$b" >/dev/null 2>&1 && echo present || echo "(missing)"; done
    echo "-- login shell --"; getent passwd root | cut -d: -f7
    echo "-- symlinks --"; ls -l ~/.zshrc ~/.gitconfig ~/.tmux.conf 2>&1
  '
echo ">> clean-env test finished."
