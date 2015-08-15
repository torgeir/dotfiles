#!/bin/sh

echo installing nvm:
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh
IOJS=iojs-v3.0.0
nvm install $IOJS v0.12
nvm alias default $IOJS
nvm use $IOJS

echo installing npm modules:
npm install -g sweet.js
npm install -g bluebird
npm install -g prettyjson
npm install -g http-server
npm install -g connect
npm install -g harp
npm install -g jshint
npm install -g jsdom
npm install -g mversion
npm install -g mrun

echo installing dotfiles:
for dotfile in   \
  aliases        \
  brew-installer \
  functions      \
  gitconfig      \
  inputrc        \
  mackup.cfg     \
  rvm-installer  \
  screenrc       \
  sweetjs-macros \
  tmux.conf      \
  exports;
  do
    echo installing .$dotfile
    ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
  done

touch $HOME/.marks
