if ! exists kubectl; then
  if isMac && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
    brew install kubectl
  fi
fi

if exists kubectl; then
  alias k=kubectl

  # If _kubectl completions exists in fpath, skip set completions
  if [ ! -f "${fpath[1]}/_kubectl" ] &>/dev/null; then
    kubectl completion zsh > "${fpath[1]}/_kubectl"
  fi
fi
