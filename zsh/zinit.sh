ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit load "zsh-users/zsh-syntax-highlighting"
zinit load "zsh-users/zsh-autosuggestions"
zinit load "zsh-users/zsh-completions"
zinit light asdf-vm/asdf

# Load pure theme
# with zsh-async library that's bundled with it.
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure
# zstyle :prompt:pure:git:stash show yes
zinit ice depth=1
zinit light romkatv/powerlevel10k

