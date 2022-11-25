## fzf
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # yes yes no
    echo 'y\ny\nn' | ~/.fzf/install
fi

# fzf
export FZF_DEFAULT_COMMAND="rg -u --files --hidden --follow --glob '!.git' 2> /dev/null"
export FZF_CTRL_T_COMMAND='rg -u --files --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.dotfiles/zsh/tools/fzf/fzf_functions.sh
