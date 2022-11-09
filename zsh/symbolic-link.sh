link() {
    if [ ! -e $2 ]; then
        ln -s $1 $2
    fi
}

# symbolic link
# .zshrc
link ~/.dotfiles/zsh/.zshrc ~/.zshrc

# alacritty.yml
mkdir -p ~/.config/alacritty && \
    link ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# .gitconfig
link ~/.dotfiles/.gitconfig ~/.gitconfig

# nvim
mkdir -p ~/.config && link ~/.dotfiles/nvim ~/.config/nvim

# starship
mkdir -p ~/.config && link ~/.dotfiles/starship.toml ~/.config/starship.toml

# .bin
link ~/.dotfiles/.bin ~/.bin
