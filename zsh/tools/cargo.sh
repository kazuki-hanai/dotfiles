## Rust
if [ ! -d ~/.cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source ~/.cargo/bin
source ~/.cargo/env
export PATH="$HOME/cargo/.bin:$PATH"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

if ! type eza > /dev/null 2>&1; then
     cargo install eza
fi
alias ls=eza

if ! type bat > /dev/null 2>&1; then
     cargo install bat
fi
alias cat=bat

if ! type delta > /dev/null 2>&1; then
     cargo install git-delta
fi
alias git-delta=delta

if ! type rg > /dev/null 2>&1; then
     cargo install ripgrep
fi

if ! type zoxide > /dev/null 2>&1; then
     cargo install zoxide
fi

if ! type tokei > /dev/null 2>&1; then
     cargo install tokei
fi

if ! type btm > /dev/null 2>&1; then
     cargo install bottom
fi

if ! type dust > /dev/null 2>&1; then
     cargo install dust
fi
