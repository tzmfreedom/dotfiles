#!/bin/bash

brew install zsh

# install some module related with rbenv
if type git > /dev/null 2>&1; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc

  # git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# install neobundle
if type git > /dev/null 2>&1; then
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# install with brew
if type brew > /dev/null 2>&1; then
  brew update
  brew install ack pt tig mycli
fi

if type hub > /dev/null 2>&1; then
  brew install hub
fi

if type colordiff > /dev/null 2>&1; then
  brew install colordiff
fi

if type gdate > /dev/null 2>&1; then
  brew install coreutils
fi

# install dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -sb $(pwd)/$f ~/$f
done
