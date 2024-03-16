if ! exists kubectl; then
  if isMac; then
    brew install kubectl
  fi
fi

alias k=kubectl

# If _kubectl completions exists in fpath, skip set completions
if type _kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi
