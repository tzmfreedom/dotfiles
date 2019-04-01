#!/bin/bash

if type git > /dev/null 2&1; then
  brew install git
  # apt-get -y install git
  # yum -y install git
fi

# install pyenv
# install pyenv-virtualenv
if type curl > /dev/null 2&1; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

  # brew install zlib
  # sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

  git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

  # pyenv install 2.7.16
  # pyenv virtualenv 2.7.16 my_2.7.16
  # pyenv shell my_2.7.16
fi

# require: pip, curl
# if type pip > /dev/null 2>&1; then
#   pip install virtualenv virtualenvwrapper
#   source /usr/local/bin/virtualenvwrapper.sh
#   mkvirtualenv -p .pythonz/pythons/CPython-3.3.5/bin/python py335
# fi

# install zsh
# ZSH_VERSION=5.3.1
# if type wget > /dev/null 2>&1; then
#   wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.gz/download
#   tar zxf download
#   cd zsh zsh-${ZSH_VERSION}
#   ./configure && make && sudo make install
# fi
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

if type gem > /dev/null 2>&1; then
  gem install gist
fi

if type hub > /dev/null 2>&1; then
  brew install hub
fi

if type colordiff > /dev/null 2&1; then
  brew install colordiff
fi

# install dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -sb $(pwd)/$f ~/$f
done
