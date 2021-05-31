## Rust
if [ ! -d ~/.cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

source ~/.cargo/bin
source ~/.cargo/env
export PATH="$HOME/cargo/.bin:$PATH"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

## cargo tools
installCargoPackage() {
    if [ ! -f ~/.cargo/bin/$2 ]; then
        cargo install $1;
    fi
    alias $3=$2;
}

installCargoPackage exa exa ls
installCargoPackage bat bat cat
installCargoPackage ripgrep rg grep
installCargoPackage kmon kmon kmon
installCargoPackage git-delta delta git-delta
installCargoPackage procs procs ps
installCargoPackage du-dust dust dust
installCargoPackage tokei tokei tokei
installCargoPackage hyperfine hyperfine hyperfine
installCargoPackage ytop ytop top
installCargoPackage bandwhich bandwhich bandwhich
installCargoPackage grex grex grex
