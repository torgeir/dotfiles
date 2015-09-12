#!/bin/sh

echo installing nvm:
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh
NODE=v4.0.0
nvm install $NODE
nvm alias default $NODE
nvm use $NODE

echo installing npm modules:
npm i -g bluebird
npm i -g prettyjson
npm i -g http-server
npm i -g connect
npm i -g harp
npm i -g eslint babel-eslint
npm i -g jsdom
npm i -g mversion
npm i -g mrun
npm i -g npm-check-updates

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
