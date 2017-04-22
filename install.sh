#!/bin/bash

if type git > /dev/null 2&1; then
  brew install git
  # apt-get -y install git
  # yum -y install git
fi
# install pythonz
if type curl > /dev/null 2&1; then
  curl -kL https://raw.github.com/saghul/pythonz/master/pythonz-install | bash
  pythonz list -a
  pythonz install 3.3.5

fi

# require: pip, curl
if type pip > /dev/null 2>&1; then
  pip install virtualenv virtualenvwrapper
  source /usr/local/bin/virtualenvwrapper.sh
  mkvirtualenv -p .pythonz/pythons/CPython-3.3.5/bin/python py335
fi

# install zsh
ZSH_VERSION=5.3.1
if type wget > /dev/null 2>&1; then
  wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.gz/download
  tar zxf download
  cd zsh zsh-${ZSH_VERSION}
  ./configure && make && sudo make install
fi

# install some module related with rbenv
if type git > /dev/null 2>&1; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
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

# install dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -sb $(pwd)/$f ~/$f
done
