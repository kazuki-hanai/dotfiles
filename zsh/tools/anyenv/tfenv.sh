local TERRAFORM_VERSION=1.1.0

if [ ! -d ~/.anyenv/envs/tfenv ]; then
  ~/.anyenv/bin/anyenv install tfenv
fi

tfenv init

if [[ $(tfenv list 2>/dev/null | wc -l | awk '{print $1}') = 0 ]];then
  tfenv install $TERRAFORM_VERSION
  tfenv use $TERRAFORM_VERSION
fi
