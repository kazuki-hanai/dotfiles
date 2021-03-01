## Rust
if [ ! -d ~/.cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

source ~/.cargo/bin
source ~/.cargo/env
export PATH="$HOME/cargo/.bin:$PATH"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

## cargo tools
if [ ! -f ~/.cargo/bin/exa ]; then
    cargo install exa;
else
    alias ls=exa;
fi
if [ ! -f ~/.cargo/bin/bat ]; then
    cargo install --locked bat;
else
    alias cat=bat;
fi
if [ ! -f ~/.cargo/bin/rg ]; then
    cargo install ripgrep;
else
    alias grep=rg;
fi

