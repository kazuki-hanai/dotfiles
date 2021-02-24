## anyenv
if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH=$PATH:$(go env GOPATH)/bin

source ~/.dotfiles/zsh/init/tools/anyenv/pyenv.sh
source ~/.dotfiles/zsh/init/tools/anyenv/nodenv.sh
source ~/.dotfiles/zsh/init/tools/anyenv/goenv.sh
