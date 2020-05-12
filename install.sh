#!/bin/sh

#echo "accepting xcode license.."
#sudo xcodebuild -license accept

echo "installing nvm:"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
source ~/.nvm/nvm.sh

NODE=v12
nvm install $NODE
# nvm slow down hack
# https://github.com/dylanpyle/dotfiles/blob/11b341d87686d02c098c214d4c0980d06795fc41/.zshrc#L118
# nvm alias default $NODE
# nvm use $NODE

echo installing npm modules:
npm i -g http-server
npm i -g npm-check-updates
npm i -g browser-sync
# emacs uses these
npm i -g eslint babel-eslint jsonlint eslint-plugin-react tern prettier

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

mkdir -p $HOME/.marks
ln -fs $HOME/.emacs.d/ $HOME/.marks/e
ln -fs $HOME/Code/ $HOME/.marks/c
ln -fs $HOME/dotfiles/ $HOME/.marks/dot
