if ! exists kubectl; then
  if isMac; then
    brew install kubectl
  fi
fi

alias k=kubectl
