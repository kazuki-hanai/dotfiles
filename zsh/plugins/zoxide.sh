if [ ! -x "`which zoxide`" ]; then
  cargo install zoxide --locked
fi

eval "$(zoxide init zsh)"
alias cd=z
alias z=__zoxide_zi
