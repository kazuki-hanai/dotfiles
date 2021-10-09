## anyenv

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"

# TODO remove these snipet if the problem resolve
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(anyenv init -)"

source ~/.dotfiles/zsh/tools/anyenv/pyenv.sh
source ~/.dotfiles/zsh/tools/anyenv/nodenv.sh
