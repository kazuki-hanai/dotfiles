if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"

eval "$(anyenv init -)"


########### Install nodenv ###########
local NODE_VERSION=19.6.0
if [ ! -d ~/.anyenv/envs/nodenv ]; then
  ~/.anyenv/bin/anyenv install nodenv
fi

eval "$(nodenv init -)"

if [[ $(nodenv versions 2>/dev/null | wc -l | awk '{print $1}') = 0 ]];then
  nodenv install $NODE_VERSION
  nodenv global $NODE_VERSION
fi


########### Install pyenv ###########
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

# poetry
if [ ! type poetry > /dev/null 2>&1 ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
fi


########### Install tfenv ###########
local TERRAFORM_VERSION=1.1.0

if [ ! -d ~/.anyenv/envs/tfenv ]; then
  ~/.anyenv/bin/anyenv install tfenv
fi

tfenv init

if [[ $(tfenv list 2>/dev/null | wc -l | awk '{print $1}') = 0 ]];then
  tfenv install $TERRAFORM_VERSION
  tfenv use $TERRAFORM_VERSION
fi


########### Install tfenv ###########
local GO_VERSION=1.22.0
if [ ! -d ~/.anyenv/envs/goenv ]; then
  ~/.anyenv/bin/anyenv install goenv
fi

if ! ~/.anyenv/envs/goenv/bin/goenv versions 1>/dev/null 2>&1; then
  ~/.anyenv/envs/goenv/bin/goenv install $GO_VERSION
  goenv global $GO_VERSION
fi
