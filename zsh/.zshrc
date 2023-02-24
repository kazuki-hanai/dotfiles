
source ~/.dotfiles/zsh/lib.sh

# Import basic settings before loading others
loadsh ~/.dotfiles/zsh/preload.sh

# Import standard settings
loadsh ~/.dotfiles/zsh/zsh-configs.sh
loadsh ~/.dotfiles/zsh/history.sh
loadsh ~/.dotfiles/zsh/export-path.sh
loadsh ~/.dotfiles/zsh/pkg.sh
loadsh ~/.dotfiles/zsh/symbolic-link.sh
loadsh ~/.dotfiles/zsh/dotfiles-private.sh
loadsh ~/.dotfiles/zsh/completion.sh

# Import tool settings
loadsh ~/.dotfiles/zsh/tools/tmux.sh
loadsh ~/.dotfiles/zsh/tools/zinit.sh
loadsh ~/.dotfiles/zsh/tools/fzf/fzf.sh
loadsh ~/.dotfiles/zsh/tools/cargo.sh
loadsh ~/.dotfiles/zsh/tools/anyenv/anyenv.sh
loadsh ~/.dotfiles/zsh/tools/go/go.sh
loadsh ~/.dotfiles/zsh/tools/poetry.sh
loadsh ~/.dotfiles/zsh/tools/deno.sh
loadsh ~/.dotfiles/zsh/tools/nvim.sh
loadsh ~/.dotfiles/zsh/tools/kubectl.sh

# Import local settings
loadsh ~/.dotfiles/zsh/localconfig.sh
