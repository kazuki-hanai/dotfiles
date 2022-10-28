## nvim
local osversion=$(uname -s)
if ! which nvim 1>/dev/null; then
  if [ "${osversion:0:5}" = 'Linux' ]; then
    sudo apt-add-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install neovim
  elif [ "${osversion:0:6}" = 'Darwin' ]; then
    brew install neovim
  fi
  pip install neovim
else
  alias vim='nvim'
fi