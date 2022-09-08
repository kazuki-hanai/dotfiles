[ -d "$HOME/google-cloud-sdk" ] && export PATH="$PATH:$HOME/google-cloud-sdk/bin"
if [ -x "`which gcloud`" ]; then
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then . ~/google-cloud-sdk/path.zsh.inc; fi

  # The next line enables shell command completion for gcloud.
  if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then . ~/google-cloud-sdk/completion.zsh.inc; fi
else
  echo 'You should install gcloud via https://cloud.google.com/sdk/docs/install'
  exit 1
fi
