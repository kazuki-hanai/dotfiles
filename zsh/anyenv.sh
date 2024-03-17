if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    yes | ~/.anyenv/bin/anyenv install --init
fi
export PATH="$HOME/.anyenv/bin:$PATH"

eval "$(anyenv init -)"
