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


########### fzf functions ###########

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# frg - rg
frg() {
    rg $1 -r .
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

fd_wrap() {
  flag='-f'
  if [ $# -eq 0 ]; then
    builtin cd
  elif [ $# -eq 1 ]; then
    if [ $1 = "$flag" ]; then
      dirs=$(fd --type d . $HOME | fzf)
      if [ "$dirs" != '' ]; then
        builtin cd "$dirs"
      fi
    else
      builtin cd $1
    fi
  elif [ $2 = "$flag" ]; then
    target=${1:-$HOME}
    dirs=$(fd --type d . $target | fzf)
    if [ "$dirs" != '' ]; then
      builtin cd "$dirs"
    fi
  fi
}
