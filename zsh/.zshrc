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
zstyle :compinstall filename $HOME'/.zshrc'

autoload -Uz compinit
compinit

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hanaiikki/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hanaiikki/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hanaiikki/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hanaiikki/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin
