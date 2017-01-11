# Path to your oh-my-zsh installation.
# export PATH="/Users/mtajitsu/.pythonz/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

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

# added by travis gem
# [ -f /Users/mtajitsu/.travis/travis.sh ] && source /Users/mtajitsu/.travis/travis.sh

ulimit -n 65536
alias gcd='$(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias pass="lpass ls | peco | sed -E 's/(.+)\[id\:(.*)$/\1/g' | sed -e 's/(none)\///g' | xargs lpass show --password | pbcopy"
alias decode_uri='nkf -w --url-input'
alias encode_uri='nkf -WwMQ | tr = %'
alias speco='cd ${SPEC_BASE}; file=$(find ${SPEC_BASE}/spec/ -type f | grep spec.rb | peco); echo "bundle exec rspec ${file}"; bin/rspec ${file}'
alias history_all='history 1'

function login_sf() {
  username=$(lpass show --username $1)
  password=$(lpass show --password $1)
  url=$(lpass show --url $1)
  /usr/bin/open -a "/Applications/Google Chrome.app" "${url}/?un=${username}&pw=${password}"
}
