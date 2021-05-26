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

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/sugerme/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
