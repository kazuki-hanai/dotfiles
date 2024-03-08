ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit load "zsh-users/zsh-syntax-highlighting"
zinit load "zsh-users/zsh-autosuggestions"
zinit load "zsh-users/zsh-completions"
# zinit load "chrissicool/zsh-256color"
# zinit load "mollifier/anyframe"
# zinit load "darvid/zsh-poetry"
zinit ice pick"async.zsh"

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

zstyle :prompt:pure:git:stash show yes
