## nvim

# vim-plug
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ] && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

osversion=$(uname -s)
if ! exists nvim && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  if [ "${osversion:0:5}" = 'Linux' ]; then
    sudo apt-add-repository -y ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
  elif [ "${osversion:0:6}" = 'Darwin' ]; then
    brew install neovim
  fi
  if exists pip; then
    pip install neovim
  fi

  if exists nvim; then
    nvim +PlugInstall
  fi
fi

if exists nvim; then
  alias vim='nvim'
fi
