#!/bin/bash

docker build ./ --progress plain -f ~/.dotfiles/docker/myown -t myown
