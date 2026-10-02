#!/usr/bin/env bash
for f in \
  ideavimrc \
  zsh \
  zshrc \
  gitconfig \
  gitattributes \
  inputrc \
  vimrc \
  fzfrc \
  skhdrc \
  screenrc \
  tmux.conf;
do
  echo installing $PWD/$f to ~/.$f
  ln -sf $PWD/$f $HOME/.$f
done
