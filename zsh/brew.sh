brew_path=""
if isMac; then
  brew_path="/opt/homebrew/bin/brew"
elif isUbuntu; then
  brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
fi

if [ -x "$brew_path" ]; then
  eval "$("$brew_path" shellenv)"
elif [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x "$brew_path" ]; then
    eval "$("$brew_path" shellenv)"
  fi
fi
