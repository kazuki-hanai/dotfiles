existsCmd() {
    type -a $1 > /dev/null 2>&1
}

installMac() {
    if [ "$(uname)" = 'Darwin' ] && ! existsCmd $1; then
        brew install $2;
    fi
}

installUbuntu() {
    if [ -e /etc/lsb-release ]; then
        if ! dpkg -s $1 1>/dev/null; then sudo apt -y install $1; fi
    fi
}


if [ "$(uname)" = 'Darwin' ] && ! existsCmd brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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
installUbuntu clangd-10
installUbuntu ca-certificates

installMac gomi b4b4r07/tap/gomi
