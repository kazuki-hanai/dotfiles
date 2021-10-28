# Import dotfiles-private
if [ ! -d ~/.dotfiles-private ]; then
    git clone git@github.com:wan-nyan-wan/dotfiles-private.git ~/.dotfiles-private
fi
source ~/.dotfiles-private/init.sh
