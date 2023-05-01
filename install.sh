#!/bin/bash

case $(uname) in
  Darwin)
    echo "accepting xcode license.."
    sudo xcodebuild -license accept

    echo "installing nvm:"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    ;;
esac

source $HOME/.nvm/nvm.sh

NODE=v18
nvm install $NODE
nvm alias default $NODE
nvm use $NODE

echo installing modules:
npm install -g npm \
  http-server \
  npm-check-updates \
  eslint \
  eslint-plugin-react \
  nodemon \
  npm-check-updates \
  prettier \
  pyright \
  ts-node \
  typescript \
  typescript-language-server \
  bash-language-server;

echo installing dotfiles:
case $(uname) in
  Darwin)
    for dotfile in \
      ideavimrc \
      eslintrc \
        gpg-agent.conf \
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
        gitconfig \
        gpg-agent.conf \
        gtkrc-2.0 \
        inputrc \
        profile \
        zlogin;
    do
      echo installing ~/.$dotfile
      ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
    done
    ln -sf $HOME/dotfiles/profile $HOME/.zprofile

    # ~/.config/<configs>
    for config_folder in \
      alacritty \
        mimeapps.list \
        i3status-rust \
        pipewire \
        MangoHud \
        environment.d \
        rofi \
        mako \
        dunst \
        sway \
        xkb \
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
    p10k.zsh \
    zsh \
    zshrc \
    gitconfig \
    gitattributes \
    tmux.conf;
do
  echo installing ~/.$dotfile
  ln -sf $HOME/dotfiles/$dotfile $HOME/.$dotfile
done

echo installing zsh plugins
bash $HOME/.zsh/install.sh

# preloads for boot clj
mkdir -p $HOME/.boot
ln -sf $HOME/dotfiles/profile.boot $HOME/.boot/profile.boot
