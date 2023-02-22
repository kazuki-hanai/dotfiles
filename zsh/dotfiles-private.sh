# Import dotfiles-private
if [ ! -d ~/.dotfiles-private ]; then
  ssh -T git@github.com
  echo $?
  if [ "$?" = 1 ]; then
    git clone git@github.com:wan-nyan-wan/dotfiles-private.git ~/.dotfiles-private
  fi
else
  source ~/.dotfiles-private/init.sh
fi
