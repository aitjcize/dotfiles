#!/bin/bash

SRC=$PWD

cd $HOME

for config in .vimrc .zshrc .tmux.conf .gitconfig .bashrc; do
  echo "Creating soft link for $config ..."
  ln -sf $SRC/$config .
done

# Bin
mkdir -p $HOME/bin
cd $HOME/bin

# Kitty
mkdir -p $HOME/.config/kitty
ln -sf $SRC/kitty.conf $HOME/.config/kitty

# autojump
git clone https://github.com/wting/autojump.git $HOME/bin/autojump.git
ln -s autojump.git/bin/autojump .

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Zsh plugins
ZSH_DIR=$HOME/bin/zsh
mkdir -p $ZSH_DIR
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_DIR/zsh-syntax-highlighting.git
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_DIR/zsh-autosuggestions.git

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
