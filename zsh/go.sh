# Import Go environment variables
if [ -f ~/.asdf/plugins/golang/set-env.zsh ]; then
  . ~/.asdf/plugins/golang/set-env.zsh
fi

if exists go && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  go install golang.org/x/tools/gopls@latest
fi
