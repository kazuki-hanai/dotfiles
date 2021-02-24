## anyenv
if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH=$PATH:$(go env GOPATH)/bin

### nodenv
if [ ! -d ~/.anyenv/envs/nodenv ]; then
    ~/.anyenv/bin/anyenv install nodenv
fi
### pyenv
if [ ! -d ~/.anyenv/envs/pyenv ]; then
    ~/.anyenv/bin/anyenv install pyenv
fi
### goenv
if [ ! -d ~/.anyenv/envs/goenv ]; then
    ~/.anyenv/bin/anyenv install goenv
fi
