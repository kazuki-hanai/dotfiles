if isMac ;then
  if ! exists protoc && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
    brew install protobuf
  fi
fi
