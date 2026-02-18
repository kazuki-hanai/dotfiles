if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Default editor is nvim
set -U EDITOR nvim

# Export PATH
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.bin
fish_add_path $HOME/.dotfiles/bin

# Deno
set -x DENO_INSTALL $HOME/.deno
fish_add_path $DENO_INSTALL/bin

# Poetry
fish_add_path $HOME/.poetry/bin

# brew
if test (uname) = 'Darwin'
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

# symbolic link
function link
  if test ! -e $argv[2]
    ln -s $argv[1] $argv[2]
  end
end

mkdir -p ~/.config

link ~/.dotfiles/zsh/zshrc ~/.zshrc
link ~/.dotfiles/gitconfig ~/.gitconfig
link ~/.dotfiles/nvim ~/.config/nvim
link ~/.dotfiles/bin ~/.bin
