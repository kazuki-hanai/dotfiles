# Azure CLI (`az`) is installed via mise ([tools] "pipx:azure-cli").
#
# Its completions are argcomplete based. The shipped az.completion.sh runs
# `register-python-argcomplete az`, but that helper lives inside the pipx venv
# and is not on PATH (mise only exposes `az`), so sourcing it prints
# "command not found: register-python-argcomplete". Instead we resolve the
# helper next to az's real venv target and evaluate it directly.
if exists az; then
  autoload -U +X bashcompinit && bashcompinit

  _az_bin="$(mise which az 2>/dev/null || command -v az)"
  _az_target="$(readlink "$_az_bin" 2>/dev/null || echo "$_az_bin")"
  _az_register="$(dirname "$_az_target")/register-python-argcomplete"
  if [ -x "$_az_register" ]; then
    eval "$("$_az_register" az 2>/dev/null)"
  fi
  unset _az_bin _az_target _az_register
fi
