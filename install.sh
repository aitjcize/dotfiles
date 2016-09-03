#!/bin/bash

SRC=$PWD

cd $HOME

for config in .vimrc .zshrc .tmux.conf .gitconfig .bashrc; do
  echo "Creating soft link for $config ..."
  ln -sf $SRC/$config .
done

# Bin utils
cp -r $SRC/bin $HOME/bin
cd $HOME/bin

# autojump
git clone https://github.com/wting/autojump.git $HOME/bin/autojump.git
ln -s autojump.git/bin/autojump .

# Zsh plugins
ZSH_DIR=$HOME/bin/zsh
mkdir -p $ZSH_DIR
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_DIR/zsh-syntax-highlighting.git
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_DIR/zsh-autosuggestions.git

# vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +BundleInstall
