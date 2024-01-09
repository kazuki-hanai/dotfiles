installUbuntu git
installUbuntu zsh
installUbuntu tmux
installUbuntu curl
installUbuntu wget
installUbuntu build-essential
installUbuntu libbz2-dev
installUbuntu libdb-dev
installUbuntu libreadline-dev
installUbuntu libffi-dev
installUbuntu libgdbm-dev
installUbuntu liblzma-dev
installUbuntu libncursesw5-dev
installUbuntu libsqlite3-dev
installUbuntu libssl-dev
installUbuntu zlib1g-dev
installUbuntu uuid-dev
installUbuntu tk-dev
installUbuntu llvm
installUbuntu clang
installUbuntu ca-certificates
installUbuntu git-delta

# gh command
if [ -e /etc/lsb-release ] && ! type gh > /dev/null 2>&1; then
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
fi

installMac gomi b4b4r07/tap/gomi
installMac gh
installMac reattach-to-user-namespace
installMac tmux
