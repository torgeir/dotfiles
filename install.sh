#!/bin/bash

case $(uname) in
  Darwin)
    echo "accepting xcode license.."
    sudo xcodebuild -license accept

    echo "installing nvm:"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    ;;
esac

case $(uname) in
  Darwin)
    source "~/.nvm/nvm.sh"
    ;;
  Linux)
    source "/usr/share/nvm/nvm.sh"
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
    for dotfile in \
      eslintrc \
        screenrc \
        yabairc \
        skhdrc;
    do
      echo installing ~/.$dotfile
      ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
    done
    ;;
  Linux)
    for dotfile in \
      Xresources \
        conky.lua \
        conkyrc.base \
        gitconfig \
        gtkrc-2.0 \
        i3 \
        inputrc \
        profile \
        zlogin;
    do
      echo installing ~/.$dotfile
      ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
    done

    # ~/.config/<configs>
    for config_folder in \
      alacritty \
        i3blocks \
        i3blocks-modules \
        i3-scrot.conf \
        mimeapps.list \
        monitors.xml \
        picom.conf \
        regolith \
        yabridgectl \
        qt5ct \
        dmenu-recent;
    do
      echo installing ~/.config/$config_folder
      ln -sf $HOME/dotfiles/config/$config_folder $HOME/.config/
    done
    ;;
esac

# everywhere
for dotfile in \
  inputrc \
    gitconfig \
    tmux.conf;
do
  echo installing ~/.$dotfile
  ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
done

# preloads for boot clj
mkdir -p $HOME/.boot
ln -sf $HOME/dotfiles/profile.boot $HOME/.boot/profile.boot
