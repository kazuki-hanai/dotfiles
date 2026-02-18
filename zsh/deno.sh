if ! exists deno && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  # curl -fsSL https://deno.land/x/install/install.sh | sh
  if exists cargo; then
    cargo install deno --locked
  fi
fi
