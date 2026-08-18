## tmux
# tmux is built from source into ~/.local (scripts/build-tmux / `mise run
# tmux-build`); ~/.tmux.conf is symlinked by mise ([dotfiles]).
# Install the tmux plugin manager (tpm) if it is missing.
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
