### pyenv
local PYENV_VERSION=3.11.0
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PYENV_SHELL=zsh
export PATH="$PYENV_ROOT/bin:$PATH"

# Load completions
source "$PYENV_ROOT/completions/pyenv.zsh"

if [ ! -d ~/.anyenv/envs/pyenv ]; then
  ~/.anyenv/bin/anyenv install pyenv
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
else
  eval "$(pyenv init -)"
fi

if [[ $(pyenv versions | wc -l | awk '{print $1}') = 1 ]];then
  pyenv install $PYENV_VERSION
  pyenv global $PYENV_VERSION
fi
