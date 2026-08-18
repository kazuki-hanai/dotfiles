## Rust
# The Rust toolchain is managed by rustup; the CLI tools that used to be
# installed with `cargo install` (eza, bat, delta, ripgrep, tokei, bottom,
# dust) are now declared in mise.toml ([tools]). This file only sets up the
# Cargo env and the aliases for those tools.
if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
fi
export PATH="$HOME/.cargo/bin:$PATH"

if exists rustc; then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"
fi

if exists eza; then
  alias ls=eza
fi
if exists bat; then
  alias cat=bat
fi
if exists delta; then
  alias git-delta=delta
fi
