# symbolic link
# .zshrc
link ~/.dotfiles/zsh/zshrc ~/.zshrc

# .gitconfig
link ~/.dotfiles/gitconfig ~/.gitconfig

# nvim
mkdir -p ~/.config && link ~/.dotfiles/nvim ~/.config/nvim

# starship
mkdir -p ~/.config && link ~/.dotfiles/starship.toml ~/.config/starship.toml

# .bin
link ~/.dotfiles/bin ~/.bin

# claude code
mkdir -p ~/.claude/commands
link ~/.dotfiles/claude/commands/handover.md ~/.claude/commands/handover.md
link ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

# codex
mkdir -p ~/.codex/skills
link ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md
link ~/.dotfiles/codex/skills/handover ~/.codex/skills/handover
