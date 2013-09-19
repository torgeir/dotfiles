#!/bin/sh

echo installing nvm:
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh
NODE=0.10.18
nvm install v$NODE
nvm alias default v$NODE
nvm use v$NODE

echo installing npm modules:
npm install -g prettyjson
npm install -g http-server

echo installing dotfiles:
for dotfile in \
  screenrc     \
  gitconfig    \
  aliases      \
  functions    \
  exports;
  do
    echo installing .$dotfile
    ln -sf ~/dotfiles/$dotfile ~/.$dotfile
  done

touch ~/.marks
