## Rust
if [ ! -d ~/.cargo ] && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
fi
export PATH="$HOME/.cargo/bin:$PATH"

if exists rustc; then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"
fi

if ! exists eza && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install eza
fi
if exists eza; then
  alias ls=eza
fi

if ! exists bat && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install bat
fi
if exists bat; then
  alias cat=bat
fi

if ! exists delta && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install git-delta
fi
if exists delta; then
  alias git-delta=delta
fi

if ! exists rg && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install ripgrep
fi

if ! exists tokei && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install tokei
fi

if ! exists btm && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install bottom
fi

if ! exists dust && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
     cargo install du-dust
fi
