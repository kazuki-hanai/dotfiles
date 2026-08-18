# Go is provided by mise ([tools] go). gopls and codegen tools are declared in
# mise.toml, so this file only holds extra Go shell configuration.
if exists go; then
  export GOPATH="${GOPATH:-$HOME/go}"
  export PATH="$GOPATH/bin:$PATH"
fi
