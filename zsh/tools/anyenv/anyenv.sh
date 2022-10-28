## anyenv

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"

eval "$(anyenv init -)"

# To export PYENV paths, these source processes
# should be executed before `anyenv init -`
source ~/.dotfiles/zsh/tools/anyenv/pyenv.sh
source ~/.dotfiles/zsh/tools/anyenv/nodenv.sh

