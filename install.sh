#!/bin/bash

# require: pip, curl, git
pip install virtualenv virtualenvwrapper
curl -kL https://raw.github.com/saghul/pythonz/master/pythonz-install | bash

# pythonz list -a
# pythonz install 3.3.5

# vim ~/.bashrc
source /usr/local/bin/virtualenvwrapper.sh

# mkvirtualenv -p .pythonz/pythons/CPython-3.3.5/bin/python py335


git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -s -b $f ~/$f
done
