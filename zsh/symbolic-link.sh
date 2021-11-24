link() {
    if [ ! -e $2 ]; then
        ln -s $1 $2
    fi
}

# symbolic link
link ~/.dotfiles/.zshrc ~/.zshrc
link ~/.dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/alacritty && \
    link ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
link ~/.dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config && link ~/.dotfiles/nvim ~/.config/nvim
mkdir -p ~/.config && link ~/.dotfiles/starship.toml ~/.config/starship.toml
