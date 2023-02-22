local NODE_VERSION=19.0.0
if [ ! -d ~/.anyenv/envs/nodenv ]; then
  ~/.anyenv/bin/anyenv install nodenv
  eval "$(anyenv init -)"
fi

eval "$(nodenv init -)"

if [[ $(nodenv versions 2>/dev/null | wc -l | awk '{print $1}') = 0 ]];then
  nodenv install $NODE_VERSION
  nodenv global $NODE_VERSION
fi
