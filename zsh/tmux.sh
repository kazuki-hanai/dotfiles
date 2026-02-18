link ~/.dotfiles/tmux.conf ~/.tmux.conf
## tmux plugin
if [ ! -d ~/.tmux/plugins/tpm ] && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
