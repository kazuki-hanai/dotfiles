source ~/.dotfiles/zsh/init/zsh.sh
source ~/.dotfiles/zsh/init/path.sh
source ~/.dotfiles/zsh/init/pkg.sh
source ~/.dotfiles/zsh/init/symboliclink.sh
source ~/.dotfiles/zsh/init/ssh.sh

source ~/.dotfiles/zsh/init/tools/tmux.sh
source ~/.dotfiles/zsh/init/tools/zplug.sh
source ~/.dotfiles/zsh/init/tools/fzf.sh
source ~/.dotfiles/zsh/init/tools/gomi.sh
source ~/.dotfiles/zsh/init/tools/cargo.sh
source ~/.dotfiles/zsh/init/tools/anyenv.sh
source ~/.dotfiles/zsh/init/tools/nvim.sh

# import localsetting
if [ ! -f ~/.localbash ]; then
    touch ~/.localbash
else
    source ~/.localbash
fi

