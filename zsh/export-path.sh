
# Check wether a directory exists and 
# export the directory
check_and_export_dir () {
    local DIR=$1
    if [ ! -d $DIR ]; then
        mkdir -p $DIR
    fi
    export PATH="$DIR:$PATH"
}

# local binary
check_and_export_dir $HOME/.bin
check_and_export_dir $HOME/.dotfiles/bin
check_and_export_dir $HOME/.local/bin
export PATH="$HOME/.localbin:$PATH"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# bvm
export PATH=$HOME/bin:$PATH

# brew
if [ "$(uname)" = 'Darwin' ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
