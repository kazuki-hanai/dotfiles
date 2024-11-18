brew_path=""
if isMac; then
  brew_path="/opt/homebrew/bin/brew"
elif isUbuntu; then
  brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
fi

if $brew_path 1>/dev/null 2&>1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$($brew_path shellenv)"
