# Import dotfiles-private
if [ ! -d ~/.dotfiles-private ]; then
  ssh -o StrictHostKeyChecking=no -T git@github.com 1>/dev/null 2>&1
  if [ "$?" = 1 ]; then
    git clone git@github.com:wan-nyan-wan/dotfiles-private.git ~/.dotfiles-private
  fi
else
  source ~/.dotfiles-private/init.sh
fi
