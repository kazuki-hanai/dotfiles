## Rust
if [ ! -d ~/.cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source ~/.cargo/bin
source ~/.cargo/env
export PATH="$HOME/cargo/.bin:$PATH"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

## cargo tools
installCargoPackage() {
  if [ "$#" = 2 ]; then
    binary_file=$2
  else
    binary_file=$1
  fi

  if [ ! -f ~/.cargo/bin/$binary_file ]; then
    cargo install $1;
  fi
}

# Install package
installCargoPackage tokei

# Alias for cargo package
