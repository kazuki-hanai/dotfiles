# symbolic link
# .zshrc
link ~/.dotfiles/zsh/.zshrc ~/.zshrc

# .gitconfig
link ~/.dotfiles/gitconfig ~/.gitconfig

# nvim
mkdir -p ~/.config && link ~/.dotfiles/nvim ~/.config/nvim

# starship
mkdir -p ~/.config && link ~/.dotfiles/starship.toml ~/.config/starship.toml

# .bin
link ~/.dotfiles/bin ~/.bin
