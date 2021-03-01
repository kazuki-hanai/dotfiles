## nvim
if ! which nvim 1>/dev/null; then
    if [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
        sudo apt-add-repository ppa:neovim-ppa/stable
        sudo apt update
        sudo apt install neovim
    fi
else
    alias vim='nvim'
fi
