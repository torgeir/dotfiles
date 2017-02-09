#!/bin/sh

#echo "accepting xcode license.."
#sudo xcodebuild -license accept

echo "installing nvm:"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.nvm/nvm.sh

NODE=v6
nvm install $NODE
nvm alias default $NODE
nvm use $NODE

echo installing npm modules:
npm i -g http-server
npm i -g npm-check-updates
npm i -g browser-sync
# emacs uses these
npm i -g eslint babel-eslint jsonlint eslint-plugin-react tern

echo installing dotfiles:
for dotfile in   \
  inputrc        \
  gitconfig      \
  eslintrc       \
  screenrc       \
  tmux.conf;
  do
    echo installing .$dotfile
    ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
  done

ln -sf $HOME/dotfiles/profile.boot $HOME/.boot/profile.boot

touch $HOME/.marks
ln -fs $HOME/.emacs.d/ $HOME/.marks/e
ln -fs $HOME/Code/ $HOME/.marks/c
ln -fs $HOME/dotfiles/ $HOME/.marks/dot
