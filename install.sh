#!/bin/sh

echo "accepting xcode license.."
sudo xcodebuild -license accept

echo installing nvm:
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh

NODE=v4
nvm install $NODE
nvm alias default $NODE
nvm use $NODE

echo installing npm modules:
npm i -g http-server
npm i -g npm-check-updates
# emacs uses these
npm i -g eslint babel-eslint jsonlint eslint-plugin-react
npm i -g browser-sync
npm i -g tern

echo installing dotfiles:
for dotfile in   \
  brew-installer \
  gitconfig      \
  eslintrc       \
  rvm-installer  \
  screenrc       \
  tmux.conf;
  do
    echo installing .$dotfile
    ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
  done

touch $HOME/.marks
