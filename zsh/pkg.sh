existsCmd() {
    type -a $1 > /dev/null 2>&1
}

installMac() {
    if [ "$#" = 1 ]; then
        if [ "$(uname)" = 'Darwin' ] && ! existsCmd $1; then
            brew install $1;
        fi
    elif [ "$#" = 2 ]; then
        if [ "$(uname)" = 'Darwin' ] && ! existsCmd $1; then
            brew install $2;
        fi
    fi
}

installUbuntu() {
    if [ "$#" = 1 ]; then
      if [ -e /etc/lsb-release ]; then
          if ! dpkg -s $1 1>/dev/null; then sudo apt -y install $1; fi
      fi
    elif [ "$#" = 2 ]; then
      if [ -e /etc/lsb-release ]; then
          if ! dpkg -s $2 1>/dev/null; then sudo apt -y install $1; fi
      fi
    fi
}

# Install brew
if [ "$(uname)" = 'Darwin' ] && ! existsCmd brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
installUbuntu exa
installUbuntu bat
installUbuntu ripgrep rg
installUbuntu git-delta

installMac gomi b4b4r07/tap/gomi
installMac gh
installMac reattach-to-user-namespace
installMac tmux
installMac exa
installMac bat
installMac rg
installMac delta git-delta

# alias
alias cat=bat
alias ls=exa
alias git-delta=delta
