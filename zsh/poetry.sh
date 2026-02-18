if [ ! -f ~/.local/bin/poetry ] && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  pipx install poetry
fi
