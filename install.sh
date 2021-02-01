#!/bin/sh

#echo "accepting xcode license.."
sudo xcodebuild -license accept

echo "installing nvm:"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
source ~/.nvm/nvm.sh

NODE=v14
nvm install $NODE
nvm alias default $NODE
nvm use $NODE

echo installing modules:
npm install -g npm
npm install -g http-server
npm install -g npm-check-updates
npm install -g browser-sync
# emacs uses these
npm install -g eslint babel-eslint jsonlint eslint-plugin-react prettier

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

mkdir -p $HOME/.boot
ln -sf $HOME/dotfiles/profile.boot $HOME/.boot/profile.boot