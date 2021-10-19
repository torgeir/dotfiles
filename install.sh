#!/bin/sh

case $(uname) in
  Darwin)
    echo "accepting xcode license.."
    sudo xcodebuild -license accept

    echo "installing nvm:"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source ~/.nvm/nvm.sh
    ;;
esac

NODE=v16
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
case $(uname) in
  Darwin)
    for dotfile in   \
      eslintrc       \
      screenrc       \
      yabairc        \
      skhdrc;
    do
      echo installing .$dotfile
      ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
    done
    ;;
  Linux)
    for dotfile in   \
      inputrc        \
      gitconfig;
    do
      echo installing .$dotfile
      ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
    done
    ;;
esac

# everywhere
for dotfile in   \
  inputrc        \
  gitconfig      \
  tmux.conf;
do
  echo installing .$dotfile
  ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
done

mkdir -p $HOME/.boot
ln -sf $HOME/dotfiles/profile.boot $HOME/.boot/profile.boot
