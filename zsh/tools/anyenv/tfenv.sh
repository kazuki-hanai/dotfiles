local TERRAFORM_VERSION=1.1.0

if [ ! -d ~/.anyenv/envs/tfenv ]; then
  ~/.anyenv/bin/anyenv install tfenv
  eval "$(anyenv init -)"
fi

tfenv init

if [[ $(tfenv list 2>/dev/null | wc -l | awk '{print $1}') = 0 ]];then
  tfenv install $NODE_VERSION
  tfenv use $NODE_VERSION
fi
