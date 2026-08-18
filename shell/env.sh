# =============================================================================
# shell/env.sh - enable mise for interactive shells.
#
# Sourced from zsh/zshrc. Points mise at this repo's mise.toml as the global
# config so the same runtimes and dev tools are available everywhere, while
# project-local mise.toml files still take precedence inside their projects.
# =============================================================================

export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

# Use this repo's mise.toml as the global config.
export MISE_GLOBAL_CONFIG_FILE="${DOTFILES_PATH}/mise.toml"
export MISE_GLOBAL_CONFIG_ROOT="${DOTFILES_PATH}"
# Cap ancestor-config search at $HOME so ~/.tool-versions etc. do not leak in.
export MISE_CEILING_PATHS="${MISE_CEILING_PATHS:-$HOME}"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
