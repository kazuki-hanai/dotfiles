
if [ ! -d "$HOME/.bun/bin" ]; then
  echo "Installing Bun..."
  curl -fsSL https://bun.com/install | bash
fi

export PATH="$PATH:$HOME/.bun/bin"
