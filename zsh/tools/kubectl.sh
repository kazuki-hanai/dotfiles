if ! type kubectl > /dev/null 2>&1; then
  if [ "$(uname)" = 'Darwin' ] && ! existsCmd brew; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl.sha256"
  elif [ -e /etc/lsb-release ]; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  fi
  chmod +x kubectl
  mv ./kubectl ~/.bin/kubectl
fi
alias k=kubectl
