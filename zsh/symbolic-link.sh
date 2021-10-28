link() {
    if [ ! -e $2 ]; then
        ln -s $1 $2
    fi
}

# symbolic link
link ~/.dotfiles/.zshrc ~/.zshrc
link ~/.dotfiles/.tmux.conf ~/.tmux.conf
link ~/.dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config && link ~/.dotfiles/nvim ~/.config/nvim
