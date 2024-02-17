alias rm="gomi"

if isMac && ! exists gomi; then
  curl -LO https://github.com/babarot/gomi/releases/download/v1.1.6/gomi_darwin_arm64.tar.gz
  tar -xzvf gomi_darwin_arm64.tar.gz gomi
  chmdo +x gomi
  mv gomi ~/.bin/gomi
  rm gomi_darwin_arm64.tar.gz
fi

