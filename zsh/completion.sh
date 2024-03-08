zmodload zsh/zprof && zprof

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# gh
source <(gh completion -s zsh)

if (which zprof > /dev/null) ;then
  zprof | less
fi
