
# This function is used to suggest a command based on the current input.
function _afa-suggest-command() {
  local command=$(afa_command_suggestion.zsh -p "$BUFFER")
  if [ -n "$command" ]; then
    BUFFER="$command"
  fi
  CURSOR=$#BUFFER
  zle reset-prompt
}

autoload -Uz _afa-suggest-command

zle -N afa-suggest-command _afa-suggest-command
bindkey "^G" afa-suggest-command
