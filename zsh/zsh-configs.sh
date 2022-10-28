# Zshell configs

# bashcompinit
autoload bashcompinit
bashcompinit

# compinit
autoload -Uz compinit && compinit

# zstyle
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1 
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename $HOME'/.zshrc'

autoload -U promptinit; promptinit

# bindings
bindkey "^[[Z" reverse-menu-complete

# completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath+=~/.zfunc

# esc delay
KEYTIMEOUT=1
# user systemd
export XDG_RUNTIME_DIR=/run/user/$UID

# separate char
export WORDCHARS='*?_[]~=&;!#$%^(){}<>'
