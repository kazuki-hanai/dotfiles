if ! exists kubectl; then
  if isMac; then
    brew install kubectl
  fi
fi

alias k=kubectl

# If _kubectl completions exists in fpath, skip set completions
if [ ! -f "${fpath[1]}/_kubectl" ] &>/dev/null; then
  kubectl completion zsh > "${fpath[1]}/_kubectl"
fi
