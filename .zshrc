# Path to your oh-my-zsh installation.
export ZSH=/Users/mtajitsu/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git)

# User configuration

# export PATH="/Users/mtajitsu/.pythonz/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

# alias ohmyzsh="mate ~/.oh-my-zsh"

# if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#     export WORKON_HOME=$HOME/.virtualenvs
#     source /usr/local/bin/virtualenvwrapper.sh
# fi
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# export GOPATH=$HOME/dev
# export PATH="$GOPATH/bin:$PATH"
# export PATH=$PATH:$HOME/.gvm/bin
# export PATH=$PATH:/usr/local/go/bin
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/mtajitsu/.sdkman"
# [[ -s "/Users/mtajitsu/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mtajitsu/.sdkman/bin/sdkman-init.sh"

# added by travis gem
# [ -f /Users/mtajitsu/.travis/travis.sh ] && source /Users/mtajitsu/.travis/travis.sh

ulimit -n 65536
alias gcd='$(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

function login_sf() {
  username=$(lpass show --username $1)
  password=$(lpass show --password $1)
  url=$(lpass show --url $1)
  /usr/bin/open -a "/Applications/Google Chrome.app" "${url}/?un=${username}&pw=${password}"
} 

