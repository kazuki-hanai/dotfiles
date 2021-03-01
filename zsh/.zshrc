source ~/.dotfiles/zsh/init/zsh.sh
source ~/.dotfiles/zsh/init/path.sh
source ~/.dotfiles/zsh/init/pkg.sh
source ~/.dotfiles/zsh/init/symboliclink.sh
source ~/.dotfiles/zsh/init/ssh.sh

source ~/.dotfiles/zsh/tools/tmux.sh
source ~/.dotfiles/zsh/tools/zplug.sh
source ~/.dotfiles/zsh/tools/fzf.sh
source ~/.dotfiles/zsh/tools/gomi.sh
source ~/.dotfiles/zsh/tools/cargo.sh
source ~/.dotfiles/zsh/tools/anyenv.sh
source ~/.dotfiles/zsh/tools/nvim.sh

# import localsetting
if [ ! -f ~/.localbash ]; then
    touch ~/.localbash
else
    source ~/.localbash
fi

