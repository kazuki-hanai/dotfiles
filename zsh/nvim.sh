## nvim
# Neovim is built from source into ~/.local (scripts/build-neovim /
# `mise run nvim-build`); plugins are managed by lazy.nvim (scripts/setup-vim /
# `mise run vim`).
if exists nvim; then
  alias vim='nvim'
fi
