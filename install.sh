#!/bin/sh

echo installing nvm:
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh
NODE=0.10.28
nvm install v$NODE v0.11
nvm alias default v$NODE
nvm use v$NODE

echo installing npm modules:
npm install -g sweet.js
npm install -g prettyjson
npm install -g http-server
npm install -g connect
npm install -g harp
npm install -g jshint
npm install -g jsdom

echo installing dotfiles:
for dotfile in   \
  rvm-installer  \
  brew-installer \
  screenrc       \
  tmux.conf      \
  gitconfig      \
  aliases        \
  functions      \
  inputrc        \
  sweetjs-macros \
  exports;
  do
    echo installing .$dotfile
    ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
  done

touch $HOME/.marks
