## nvim

# vim-plug
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

local osversion=$(uname -s)
if ! which nvim 1>/dev/null; then
  if [ "${osversion:0:5}" = 'Linux' ]; then
    sudo apt-add-repository -y ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
  elif [ "${osversion:0:6}" = 'Darwin' ]; then
    brew install neovim
  fi
  pip install neovim

  nvim +PlugInstall
else
  alias vim='nvim'
fi
