if [ ! -x "`which deno`" ]; then
  # curl -fsSL https://deno.land/x/install/install.sh | sh
  cargo install deno --locked
fi
