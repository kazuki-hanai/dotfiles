if isMac && ! exists gomi && [ "${DOTFILES_BOOTSTRAP:-false}" = "true" ]; then
  curl -LO https://github.com/babarot/gomi/releases/download/v1.1.6/gomi_darwin_arm64.tar.gz
  tar -xzvf gomi_darwin_arm64.tar.gz gomi
  chmod +x gomi
  mv gomi ~/.bin/gomi
  /bin/rm -f gomi_darwin_arm64.tar.gz
fi

if exists gomi; then
  alias rm="gomi"
fi
