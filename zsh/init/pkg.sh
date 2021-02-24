install() {
    if [ "$(uname)" = 'Darwin' ]; then
	echo mac...
    elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
        if ! dpkg -s $1 1>/dev/null; then sudo apt -y install $1; fi
    fi
}

if [ "$(uname)" = 'Darwin' ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

install git
install zsh
install tmux
install curl
install wget
install build-essential
install libbz2-dev
install libdb-dev
install libreadline-dev
install libffi-dev
install libgdbm-dev
install liblzma-dev
install libncursesw5-dev
install libsqlite3-dev
install libssl-dev
install zlib1g-dev
install uuid-dev
install tk-dev
install llvm
install clang
install clangd-10
install ca-certificates

