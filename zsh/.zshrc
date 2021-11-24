# Import standard settings
source ~/.dotfiles/zsh/zsh-configs.sh
source ~/.dotfiles/zsh/history.sh
source ~/.dotfiles/zsh/export-path.sh
source ~/.dotfiles/zsh/pkg.sh
source ~/.dotfiles/zsh/symbolic-link.sh
source ~/.dotfiles/zsh/dotfiles-private.sh

# Import tool settings
source ~/.dotfiles/zsh/tools/tmux.sh
source ~/.dotfiles/zsh/tools/zplug.sh
source ~/.dotfiles/zsh/tools/fzf/fzf.sh
source ~/.dotfiles/zsh/tools/cargo.sh
source ~/.dotfiles/zsh/tools/anyenv/anyenv.sh
source ~/.dotfiles/zsh/tools/go/go.sh
source ~/.dotfiles/zsh/tools/poetry.sh
source ~/.dotfiles/zsh/tools/nvim.sh

# Import local settings
source ~/.dotfiles/zsh/localconfig.sh

# Load starship
source ~/.dotfiles/zsh/starship.sh
